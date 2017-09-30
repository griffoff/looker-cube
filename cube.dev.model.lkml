include: "cube.model.lkml"

#connection: "snowflake_prod"
label:"DEV - Cube Data on Looker"

explore: activity_usage_facts {}

explore: fact_siteusage_dev {
  extends: [fact_siteusage]
  label: "DEV site usage extend"
  from: fact_siteusage
  view_name: fact_siteusage

  join: activity_usage_facts {
    view_label: "Activity Facts"
    sql_on: (${activity_usage_facts.courseid},${activity_usage_facts.activity_type},${activity_usage_facts.partyid})
      = (${fact_siteusage.courseid},${mindtap_lp_activity_tags.activity_type},${fact_siteusage.partyid}) ;;
    relationship: one_to_one
  }

}

explore: fact_session {
  label: "Web - Sessions"
  extends: [dim_user, dim_course]

  join: dim_location {
    sql_on: ${fact_session.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
  }

  join: dim_session_date {
    from: dim_date
    sql_on: ${fact_session.eventdatekey} = ${dim_session_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_time {
    sql_on: ${fact_session.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_deviceplatform {
    sql_on: ${fact_session.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
  }

  join: dim_product {
    sql_on: ${fact_session.productid} = ${dim_product.productid} ;;
    relationship: many_to_one
  }

  join: dim_productplatform {
    sql_on: ${fact_session.productplatformid} = ${dim_productplatform.productplatformid} ;;
    relationship: many_to_one
  }

  join: dim_user {
    sql_on: ${fact_session.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${fact_session.productid} = ${dim_course.productid} ;;
    relationship: many_to_many
  }
}

explore: learningpathusage {
  from: fact_activity
  label: "Learning Path - MT Usage Data"
  description: "Start point for learning path usage from the student perspective including application usage information collected via google analytics."
  extends: [dim_user, dim_course, dim_pagedomain]
  extension: required

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

  join: mindtap_lp_activity_tags {
    sql_on: (${dim_product.productfamily},${dim_product.edition_number},${dim_learningpath.lowest_level})=(${mindtap_lp_activity_tags.product_family},${mindtap_lp_activity_tags.edition_number}, ${lp_activity_tags_test.learning_path_activity_title});;
    relationship: many_to_many
  }
}
