connection: "snowflake_prod"
week_start_day: monday
label:"Cube Data on Looker"

#include dims model
include: "dims.model.lkml"
# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


explore: fact_activation {
  label: "Activations"
  description: "Starting point for specific activations-related questions (e.g. how many activations do we have per product by institution?)."
  extends: [dim_course]

  join: course_section_facts {
    fields: []
  }

  join: dim_date {
    sql_on: ${fact_activation.activationdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
    view_label: "Date - Activation Date"
  }

  join: dim_activationfilter {
    sql_on: ${fact_activation.activationfilterid} = ${dim_activationfilter.activationfilterid} ;;
    relationship: many_to_one
  }

  join: dim_activationregion {
    sql_on: ${fact_activation.activationregionid} = ${dim_activationregion.activationregionid} ;;
    relationship: many_to_one
  }

  #override product platform from course (the activation might be counted under a different platform)
  join: dim_productplatform {
    sql_on: ${fact_activation.productplatformid} = ${dim_productplatform.productplatformid} ;;
  }
#
   join: dim_user {
     sql_on: ${fact_activation.userid} = ${dim_user.userid} ;;
     relationship: many_to_one
   }

 join: dim_party {
    sql_on: ${dim_user.mainpartyid} = ${dim_party.partyid} ;;
     relationship: many_to_one
   }

#   join: user_facts {
#     sql_on: ${dim_user.userid} = ${user_facts.userid} ;;
#     relationship: one_to_one
#   }
#
  join: dim_course {
    #sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    sql_on: ${fact_activation.courseid} = ${dim_course.courseid} ;;
    type: full_outer
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activation.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

join: fact_activation_siteusage {
    sql_on: ${fact_activation.courseid} = ${fact_activation_siteusage.courseid};;
    relationship: many_to_one
  }

join: lifespan {
  sql_on: (${dim_institution.entity_no}, ${products.prod_family_cd}) = (${lifespan.entity_no}, ${lifespan.prod_family_cd}) ;;
  relationship: many_to_one
  }
}

explore: fact_activityoutcome {
  label: "Learning Path Analysis"
  description: "Starting point for learning path activities, assigned vs gradable, scores, etc."
  extends: [dim_user, dim_course, dim_learningpath]
  extension: required

  always_filter: {
    filters: {
      field: dim_learningpath.learningtype
      value: "Activity"
    }
  }

#   join: dim_completion_date {
#     sql_on: ${fact_activityoutcome.completeddatekey} = ${dim_completion_date.datekey} ;;
#     relationship: many_to_one
#   }

  join: dim_user {
    sql_on: ${fact_activityoutcome.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_learningpath {
    sql_on: ${fact_activityoutcome.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
  }

  join: fact_activity {
    sql_on: ${dim_learningpath.learningpathid} = ${fact_activity.learningpathid} ;;
    relationship:  one_to_many
  }

  join: dim_activity {
    sql_on: ${fact_activityoutcome.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
  }

  join: dim_eventtype {
    sql_on: ${fact_activity.eventtypeid} = ${dim_eventtype.eventtypeid} ;;
    relationship: many_to_one
  }

  join: dim_course {
#     sql_on: ${fact_activityoutcome.courseid} = ${dim_course.courseid} ;;
#    sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    sql_on: ${fact_activation.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    type: full_outer
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activityoutcome.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

#   join: dim_relative_to_end_date {
#     sql_on: ${fact_activityoutcome.daysbeforecourseend} = ${dim_relative_to_end_date.days} ;;
#     relationship: many_to_one
#   }
#
#   join: dim_relative_to_due_date {
#     sql_on: ${fact_activityoutcome.daysleftbeforeduedate} = ${dim_relative_to_due_date.days} ;;
#     relationship: many_to_one
#   }

  join: dim_time {
    sql_on: ${fact_activityoutcome.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    sql_on: ${fact_activityoutcome.filterflag} = ${dim_filter.filterflag} ;;
    relationship: many_to_one
  }

  join: fact_siteusage {
    sql_on: ${fact_siteusage.learningpathid} = ${fact_activityoutcome.learningpathid}
          and ${fact_siteusage.userid} = ${fact_activityoutcome.userid}
          and ${fact_siteusage.eventdatekey} = ${fact_activityoutcome.startdatekey}
          ;;
    relationship: many_to_many
  }

}

explore: fact_activity {
  label: "Learning Path - MT Instructor Modifications"
  description: "Starting point for learning path analysis from the instructor perspective (e.g. What has the instructor changed?  What has the instructor added?)"
  extends: [dim_course, dim_learningpath]

  join: dim_eventtype {
    sql_on: ${fact_activity.eventtypeid} = ${dim_eventtype.eventtypeid} ;;
    relationship: many_to_one
  }

  join: dim_created_date {
    sql_on: ${fact_activity.createddatekey} = ${dim_created_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_instructor_user {
    from: dim_user
    view_label: "User (Instructor)"
    sql_on: ${fact_activity.userid} = ${dim_instructor_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_instructor_party {
    from: dim_party
    view_label: "User (Instructor)"
    sql_on: ${dim_instructor_user.mainpartyid} = ${dim_instructor_party.partyid} ;;
    relationship: many_to_one
  }

  join: dim_learningpath {
    sql_on: ${fact_activity.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
  }

  join: dim_activity {
    sql_on: ${fact_activity.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
  }

  join: dim_course {
    #sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    sql_on: ${fact_activity.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    type: full_outer
  }

#   join:  fact_activityoutcome {
#     sql_on: (${dim_course.courseid}, ${dim_activity.activityid}) = (${fact_activityoutcome.courseid}, ${fact_activityoutcome.activityid}) ;;
#     relationship: one_to_many
#   }

  join:  fact_siteusage {
    sql_on: (${dim_course.courseid}, ${dim_activity.activityid}) = (${fact_siteusage.courseid}, ${fact_siteusage.activityid}) ;;
    relationship: one_to_many
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activity.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

#   join: dim_relative_to_end_date {
#     sql_on: ${fact_activity.daysbeforecourseend} = ${dim_relative_to_end_date.days} ;;
#     relationship: many_to_one
#   }

  join: dim_time {
    sql_on: ${fact_activity.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    sql_on: ${fact_activity.filterflag} = ${dim_filter.filterflag} ;;
    relationship: many_to_one
  }

#   join: dim_activity_view_uri {
#     sql_on: ${fact_activity.id} = ${dim_activity_view_uri.id};;
#     relationship: one_to_one
#   }
}

explore:  fact_appusage_by_user {
  extends: [dim_course, dim_user, dim_learningpath]
  label: "App dock usage - Mindtap"
  description: "
  Usage metrics about mindapps accessed via the Mindtap app dock
  Does not include usage of apps accessed via inline activities (from the learning path)
  "
  join: dim_course {
    sql_on: ${fact_appusage_by_user.courseid} = ${dim_course.courseid} ;;
    relationship: one_to_one
    type: full_outer
  }

  join: dim_iframeapplication {
    sql_on: ${fact_appusage_by_user.iframeapplicationid} = ${dim_iframeapplication.iframeapplicationid};;
    relationship: many_to_one
  }

  join: dim_iframeapplication_map {
    from: dim_iframeapplication
    fields: [dim_iframeapplication_map.iframeapplicationid]
    sql_on: ${dim_iframeapplication.iframeapplicationid} = ${dim_iframeapplication_map.iframeapplicationid_group};;
    relationship: many_to_one
  }

  join: dim_user {
    sql_on: ${fact_appusage_by_user.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: fact_appusage {
    sql_on: (${fact_appusage_by_user.courseid}, ${fact_appusage_by_user.userid}, ${dim_iframeapplication_map.iframeapplicationid}) = (${fact_appusage.courseid}, ${fact_appusage.userid}, ${fact_appusage.iframeapplicationid})  ;;
    relationship: one_to_many
  }

  join: dim_learningpath {
    sql_on: ${fact_appusage.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
  }

  join: dim_location {
    type: left_outer
    sql_on: ${fact_appusage.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
  }

   join: dim_date {
     sql_on: ${fact_appusage.eventdatekey} = ${dim_date.datekey} ;;
     relationship: many_to_one
   }

  join: dim_deviceplatform {
    sql_on: ${fact_appusage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
  }

  join: dim_time {
    sql_on: ${fact_appusage.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: datediff(day, to_date(nullif(${dim_course.startdatekey}, -1)::string, 'YYYYMMDD'), to_date(nullif(${fact_appusage.eventdatekey}, -1)::string, 'YYYYMMDD')) = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }
}



explore: fact_siteusage {
  label: "Learning Path - MT Usage Data"
  description: "Start point for learning path usage from the student persepctive including application usage information collected via google analytics."
  extends: [dim_user, dim_course, dim_pagedomain, dim_learningpath]

  join: dim_date {
    view_label: "Date - Date of activity"
    sql_on: ${fact_siteusage.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${fact_siteusage.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    type: full_outer
  }

  join: dim_product {
    sql_on: ${fact_siteusage.productid} = ${dim_product.productid} ;;
    relationship: many_to_one
  }

  join: dim_location {
    sql_on: ${fact_siteusage.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
  }

  join: dim_activity {
    sql_on: ${fact_siteusage.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
  }

  join: dim_learningpath {
    sql_on: ${fact_siteusage.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
  }

#   join: dim_master_node {
#     sql_on: ${fact_siteusage.masternodeid} = ${dim_master_node.masternodeid} ;;
#     relationship: many_to_one
#   }

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

}

explore: LP_Analysis_PSR_Limited_View {
  label: "Learning Path Analysis - Pilot Tagging Explore"
  from: fact_siteusage
  description: "TEST Explore Start point for learning path usage from the student persepctive including application usage information collected via google analytics."
  extends: [dim_user, dim_course, dim_pagedomain, dim_learningpath, dim_product]

  join: dim_date {
    view_label: "Date - Date of activity"
    sql_on: ${LP_Analysis_PSR_Limited_View.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
    fields: [dim_date.curated_fields*]
    #fields: [datevalue_date,datevalue_week,datevalue_month,datevalue_month_name,datevalue_year,datevalue_day_of_week,fiscalyear,count,]
  }

  join: dim_course {
    sql_on: ${LP_Analysis_PSR_Limited_View.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    type: full_outer
    fields: [dim_course.curated_fields*]
  }

  join: dim_product {
    fields: [dim_product.curated_fields*]
  }

  join: dim_location {
    sql_on: ${LP_Analysis_PSR_Limited_View.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
    fields: [dim_location.curated_fields*]
  }

  join: dim_activity {
    sql_on: ${LP_Analysis_PSR_Limited_View.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
    fields: [dim_activity.curated_fields*]
  }

  join: dim_learningpath {
    sql_on: ${LP_Analysis_PSR_Limited_View.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
    fields: [dim_learningpath.curated_fields*]
  }

#   join: dim_master_node {
#     sql_on: ${fact_siteusage.masternodeid} = ${dim_master_node.masternodeid} ;;
#     relationship: many_to_one
#   }

  join: dim_party {
    sql_on: ${LP_Analysis_PSR_Limited_View.partyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
    fields: [dim_party.curated_fields*]
  }

  join: dim_user {
    sql_on: ${LP_Analysis_PSR_Limited_View.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
    fields: [dim_user.curated_fields*]
  }

  join: dim_deviceplatform {
    sql_on: ${LP_Analysis_PSR_Limited_View.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
    fields: []
  }

#   join: dim_product {
#     sql_on: ${fact_siteusage.productid} = ${dim_product.productid} ;;
#     relationship: many_to_one
#   }

  join: dim_time {
    sql_on: ${LP_Analysis_PSR_Limited_View.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
    fields: []
  }

  join: dim_pagedomain {
    sql_on: ${LP_Analysis_PSR_Limited_View.pagedomainid} = ${dim_pagedomain.pagedomainid} ;;
    relationship: many_to_one
    fields: []
  }

  join: dim_relative_to_start_date {
    sql_on: ${LP_Analysis_PSR_Limited_View.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: fact_activityoutcome {
    sql_on: ${LP_Analysis_PSR_Limited_View.learningpathid} = ${fact_activityoutcome.learningpathid}
          and ${LP_Analysis_PSR_Limited_View.userid} = ${fact_activityoutcome.userid}
          and ${LP_Analysis_PSR_Limited_View.eventdatekey} = ${fact_activityoutcome.startdatekey}
          ;;
    relationship: many_to_many
  }

  join: paid_users {
    view_label: "User"
    sql_on: (${LP_Analysis_PSR_Limited_View.courseid}, ${LP_Analysis_PSR_Limited_View.userid}) = (${paid_users.courseid}, ${paid_users.userid}) ;;
    relationship: many_to_one
  }

  join: olr_courses {
    fields: [olr_courses.curated_fields*]
  }

  join: course_section_facts {
    fields: [course_section_facts.curated_fields*]
  }

  join: dim_institution {
    fields: [dim_institution.curated_fields*]
  }

  join: ipeds {
    fields: []
  }

  join: user_facts {
    fields: [user_facts.curated_fields*]
  }

#   join: fact_siteusage {
#     fields: [fact_siteusage.curated_fields*]
#   }
}
