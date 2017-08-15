connection: "snowflake_prod"
label:"Cube Data on Looker"

#include dims model
include: "dims.model.lkml"
# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


explore: learningpathusage {
  from: fact_activity
  label: "Learning Path - MT Usage Data"
  description: "Start point for learning path usage from the student persepctive including application usage information collected via google analytics."
  extends: [dim_user, dim_course, dim_pagedomain]

  join: dim_course {
    sql_on: ${learningpathusage.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    type: full_outer
  }

  join: dim_location {
    sql_on: ${fact_siteusage.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
  }

  join: dim_activity {
    sql_on: ${learningpathusage.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
  }

  join: dim_learningpath {
    sql_on: ${learningpathusage.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
  }

  join: fact_siteusage {
    sql_on: (${learningpathusage.courseid}, ${learningpathusage.learningpathid}) = (${fact_siteusage.courseid}, ${fact_siteusage.learningpathid})
      and (${fact_siteusage.eventdate_raw} >= ${learningpathusage.created_time} and ${fact_siteusage.eventdate_raw} < ${learningpathusage.next_created_time}) ;;
    type: left_outer
    relationship: one_to_many
  }

  join: dim_date {
    view_label: "Date - Date of activity"
    sql_on: ${fact_siteusage.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_party {
    sql_on: ${fact_siteusage.partyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
  }

  join: dim_user {
    sql_on: ${fact_siteusage.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_deviceplatform {
    sql_on: ${fact_siteusage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
  }

#   join: dim_product {
#     sql_on: ${fact_siteusage.productid} = ${dim_product.productid} ;;
#     relationship: many_to_one
#   }

  join: dim_time {
    sql_on: ${fact_siteusage.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_pagedomain {
    sql_on: ${fact_siteusage.pagedomainid} = ${dim_pagedomain.pagedomainid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_siteusage.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: fact_activityoutcome {
    sql_on: ${fact_siteusage.learningpathid} = ${fact_activityoutcome.learningpathid}
          and ${fact_siteusage.userid} = ${fact_activityoutcome.userid}
          and ${fact_siteusage.eventdatekey} = ${fact_activityoutcome.startdatekey}
          ;;
    relationship: many_to_many
  }

  join: paid_users {
    view_label: "User"
    sql_on: (${fact_siteusage.courseid}, ${fact_siteusage.userid}) = (${paid_users.courseid}, ${paid_users.userid}) ;;
    relationship: many_to_one
  }

  join: lp_activity_tags_test {
    sql_on: (${dim_product.productfamily},${dim_learningpath.lowest_level})=(${lp_activity_tags_test.product_family},${lp_activity_tags_test.learning_path_activity_title});;
    relationship: one_to_many
  }
}
