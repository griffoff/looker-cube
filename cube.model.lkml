connection: "snowflake_prod"
label:"Cube Data on Looker"

#include dims model
include: "dims.model.lkml"
# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


explore: fact_activation {
  label: "Activations"
  extends: [dim_course]
  fields: [ALL_FIELDS*, -fact_activation_by_course.ALL_FIELDS*]

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

  join: dim_user {
    sql_on: ${fact_activation.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_party {
    sql_on: ${dim_user.mainpartyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
  }

  join: user_facts {
    sql_on: ${dim_user.userid} = ${user_facts.userid} ;;
    relationship: one_to_one
  }

  join: dim_course {
    sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
#     sql_on: ${fact_activation.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activation.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

#   join: dim_relative_to_end_date {
#     sql_on: ${fact_activation.daysbeforecourseend} = ${dim_relative_to_end_date.days} ;;
#     relationship: many_to_one
#   }

  join: fact_enrollment {
    sql_on: ${fact_activation.courseid} = ${fact_enrollment.courseid} and ${fact_activation.partyid}) = ${fact_enrollment.partyid}) ;;
    relationship: one_to_many
  }

#   join: fact_appusage {
#     sql_on: (${fact_activation.productplatformid}, ${fact_activation.productid}, ${fact_activation.courseid}, ${fact_activation.partyid}, ${fact_activation.userid}) =  (26, ${fact_appusage.productid}, ${fact_appusage.courseid}, ${fact_appusage.partyid}, ${fact_appusage.userid})
#           and {% condition fact_appusage.filter_appusage_rank %} ${fact_appusage.app_rank} {% endcondition %}
#           and {% condition fact_appusage.filter_appusage_rank_user %} ${fact_appusage.app_rank_user} {% endcondition %}
#           ;;
#
#     relationship: one_to_many
#   }

join: fact_activation_siteusage {
    sql_on: (${fact_activation.productplatformid}, ${fact_activation.productid}, ${fact_activation.courseid}, ${fact_activation.partyid}, ${fact_activation.userid}) =  (${fact_activation_siteusage.productplatformid}, ${fact_activation_siteusage.productid}, ${fact_activation_siteusage.courseid}, ${fact_activation_siteusage.partyid}, ${fact_activation_siteusage.userid});;
    relationship: one_to_many
  }
}

explore: fact_activityoutcome {
  label: "Learning Path Analysis"
  description: "Details of learning path activities, assigned vs gradable, scores, etc."
  extends: [dim_user, dim_course, dim_learningpath]

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
    sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
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
  label: "Instructor Modifications"
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
    sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    #sql_on: ${fact_activity.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    #type: full_outer
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
  label: "Usage of Mindtap apps from the app dock"
  description: "
  Usage metrics about mindapps accessed via the Mindtap app dock
  Does not include usage of apps accessed via inline activities (from the learning path)
  "
  join: dim_course {
    sql_on: ${fact_appusage_by_user.courseid} = ${dim_course.courseid} ;;
    relationship: one_to_one
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

#   join: dim_date {
#     sql_on: ${fact_appusage.eventdatekey} = ${dim_date.datekey} ;;
#     relationship: many_to_one
#   }

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

explore: fact_appusage {
  label: "App usage - old"
  extends: [dim_course, dim_learningpath]
  extension:  required

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

  join: dim_user {
    sql_on: ${fact_appusage.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_party {
    sql_on: ${fact_appusage.partyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    #sql_on: ${fact_appusage.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
  }

  join: dim_deviceplatform {
    sql_on: ${fact_appusage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
  }

  join: dim_iframeapplication {
    sql_on: ${fact_appusage.iframeapplicationid} = ${dim_iframeapplication.iframeapplicationid} ;;
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

  join: fact_appusage_by_user {
    sql_on: (${fact_appusage.courseid}, ${fact_appusage.userid}) = (${fact_appusage_by_user.courseid}, ${fact_appusage_by_user.userid})
            and (${fact_appusage.iframeapplicationid} = ${fact_appusage_by_user.iframeapplicationid} or ${fact_appusage_by_user.iframeapplicationid} is null);;
    relationship: many_to_one
  }
}


explore: fact_enrollment {
  label: "Enrollments"
  extends: [dim_user, dim_course]
  extension: required

#   join: dim_date {
#     sql_on: ${fact_enrollment.eventdatekey} = ${dim_date.datekey} ;;
#     relationship: many_to_one
#   }

  join: dim_user {
    sql_on: ${fact_enrollment.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

#   join: dim_product {
#     sql_on: ${fact_enrollment.productid} = ${dim_product.productid} ;;
#     relationship: many_to_one
#   }
#
#   join: dim_institution {
#     sql_on: ${fact_enrollment.institutionid} = ${dim_institution.institutionid} ;;
#     relationship: many_to_one
#   }

  join: dim_course {
#     sql_on: ${fact_enrollment.courseid} = ${dim_course.courseid} ;;
    sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_enrollment.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_end_date {
    sql_on: ${fact_enrollment.daysbeforecourseend} = ${dim_relative_to_end_date.days} ;;
    relationship: many_to_one
  }
}

explore: fact_session {
  label: "Web - Sessions"
  extends: [dim_user]
  extension: required

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
}

explore: fact_siteusage {
  label: "Learning Path - Usage Data"
  description: "Learning path usage information including application usage information collected via google analytics"
  extends: [dim_user, dim_course, dim_pagedomain]

  join: dim_date {
    view_label: "Date - Date of activity"
    sql_on: ${fact_siteusage.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_course {
#     sql_on: ${fact_siteusage.courseid} = ${dim_course.courseid} ;;
    sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
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
}
