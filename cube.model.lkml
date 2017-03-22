connection: "snowflake_migration_test"
label:"Cube Data on Looker"

#include dims model
include: "dims.model.lkml"
# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: fact_activation {
  label: "Activations"
  extends: [fact_appusage, dim_user, dim_course]

  join: dim_date {
    sql_on: ${fact_activation.activationdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
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

  join: dim_product {
    sql_on: ${fact_activation.productid} = ${dim_product.productid} ;;
    relationship: many_to_one
  }

  join: dim_institution {
    sql_on: ${fact_activation.institutionid} = ${dim_institution.institutionid} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${fact_activation.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activation.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_end_date {
    sql_on: ${fact_activation.daysbeforecourseend} = ${dim_relative_to_end_date.days} ;;
    relationship: many_to_one
  }

  join: fact_enrollment {
    sql_on: ${fact_activation.courseid} = ${fact_enrollment.courseid} and ${fact_activation.partyid}) = ${fact_enrollment.partyid}) ;;
    relationship: one_to_many
  }

  join: fact_appusage {
    sql_on: (${fact_activation.productplatformid}, ${fact_activation.productid}, ${fact_activation.courseid}, ${fact_activation.partyid}, ${fact_activation.userid}) =  (26, ${fact_appusage.productid}, ${fact_appusage.courseid}, ${fact_appusage.partyid}, ${fact_appusage.userid})
          and {% condition fact_appusage.filter_appusage_rank %} ${fact_appusage.app_rank} {% endcondition %}
          and {% condition fact_appusage.filter_appusage_rank_user %} ${fact_appusage.app_rank_user} {% endcondition %}
          ;;

    relationship: one_to_many
  }

#join: fact_activation_appusage {
#    sql_on: (${fact_activation.productplatformid}, ${fact_activation.productid}, ${fact_activation.courseid}, ${fact_activation.partyid}, ${fact_activation.userid}) =  (26, ${fact_activation_appusage.productid}, ${fact_activation_appusage.courseid}, ${fact_activation_appusage.partyid}, ${fact_activation_appusage.userid});;
#    relationship: one_to_one
#  }

join: fact_activation_siteusage {
    sql_on: (${fact_activation.productplatformid}, ${fact_activation.productid}, ${fact_activation.courseid}, ${fact_activation.partyid}, ${fact_activation.userid}) =  (${fact_activation_siteusage.productplatformid}, ${fact_activation_siteusage.productid}, ${fact_activation_siteusage.courseid}, ${fact_activation_siteusage.partyid}, ${fact_activation_siteusage.userid});;
    relationship: one_to_many
  }
}

explore: fact_activityoutcome {
  label: "Activity Outcomes"
  extends: [dim_user, dim_course, dim_learningpath]

  join: dim_completion_date {
    sql_on: ${fact_activityoutcome.completeddatekey} = ${dim_completion_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_user {
    sql_on: ${fact_activityoutcome.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_product {
    sql_on: ${fact_activityoutcome.productid} = ${dim_product.productid} ;;
    relationship: many_to_one
  }

  join: dim_learningpath {
    sql_on: ${fact_activityoutcome.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
  }

  join: dim_activity {
    sql_on: ${fact_activityoutcome.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
  }

  join: dim_institution {
    sql_on: ${fact_activityoutcome.institutionid} = ${dim_institution.institutionid} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${fact_activityoutcome.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activityoutcome.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_end_date {
    sql_on: ${fact_activityoutcome.daysbeforecourseend} = ${dim_relative_to_end_date.days} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_due_date {
    sql_on: ${fact_activityoutcome.daysleftbeforeduedate} = ${dim_relative_to_due_date.days} ;;
    relationship: many_to_one
  }

  join: dim_time {
    sql_on: ${fact_activityoutcome.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    sql_on: ${fact_activityoutcome.filterflag} = ${dim_filter.filterflag} ;;
    relationship: many_to_one
  }

  join: fact_activation {
    sql_on: ${fact_activityoutcome.courseid} = ${fact_activation.courseid} and ${fact_activityoutcome.userid} = ${fact_activation.userid} ;;
    relationship: many_to_one
  }
}

explore: fact_activity {
  label: "Instructor Activities"
  extends: [dim_user, dim_course, dim_learningpath]

  join: dim_eventtype {
    sql_on: ${fact_activity.eventtypeid} = ${dim_eventtype.eventtypeid} ;;
    relationship: many_to_one
  }

  join: dim_created_date {
    sql_on: ${fact_activity.createddatekey} = ${dim_created_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_user {
    sql_on: ${fact_activity.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_product {
    sql_on: ${fact_activity.productid} = ${dim_product.productid} ;;
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

  join: dim_institution {
    sql_on: ${fact_activity.institutionid} = ${dim_institution.institutionid} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${fact_activity.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activity.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_end_date {
    sql_on: ${fact_activity.daysbeforecourseend} = ${dim_relative_to_end_date.days} ;;
    relationship: many_to_one
  }

  join: dim_time {
    sql_on: ${fact_activity.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    sql_on: ${fact_activity.filterflag} = ${dim_filter.filterflag} ;;
    relationship: many_to_one
  }
}

explore: fact_appusage {
  label: "App usage"
  extends: [dim_user, dim_course, dim_learningpath]

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

  join: dim_product {
    sql_on: ${fact_appusage.productid} = ${dim_product.productid} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${fact_appusage.courseid} = ${dim_course.courseid} ;;
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

  join: dim_productplatform {
    sql_on: ${fact_appusage.productplatformid} = ${dim_productplatform.productplatformid} ;;
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

  #join:  fact_activation {
  #  sql_on: (26, ${fact_appusage.productid}, ${fact_appusage.courseid}, ${fact_appusage.partyid}, ${fact_appusage.userid}) = (${fact_activation.productplatformid}, ${fact_activation.productid}, ${fact_activation.courseid}, ${fact_activation.partyid}, ${fact_activation.userid});;
  #  relationship: many_to_one
  #}

}


explore: fact_enrollment {
  label: "Enrollments"
  extends: [dim_user, dim_course]

  join: dim_date {
    sql_on: ${fact_enrollment.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_user {
    sql_on: ${fact_enrollment.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_product {
    sql_on: ${fact_enrollment.productid} = ${dim_product.productid} ;;
    relationship: many_to_one
  }

  join: dim_institution {
    sql_on: ${fact_enrollment.institutionid} = ${dim_institution.institutionid} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${fact_enrollment.courseid} = ${dim_course.courseid} ;;
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
  label: "Web - Site usage"
  extends: [dim_user, dim_course, dim_pagedomain]

  join: dim_date {
    sql_on: ${fact_siteusage.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${fact_siteusage.courseid} = ${dim_course.courseid} ;;
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

  join: dim_master_node {
    sql_on: ${fact_siteusage.masternodeid} = ${dim_master_node.masternodeid} ;;
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

  join: dim_product {
    sql_on: ${fact_siteusage.productid} = ${dim_product.productid} ;;
    relationship: many_to_one
  }

  join: dim_time {
    sql_on: ${fact_siteusage.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_pagedomain {
    sql_on: ${fact_siteusage.pagedomainid} = ${dim_pagedomain.pagedomainid} ;;
    relationship: many_to_one
  }

  join: dim_start_date {
    sql_on: ${fact_siteusage.coursestartdatekey} = ${dim_start_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_siteusage.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }
}

explore: full_student_course_metrics {
  label: "Data Science - Full Student Course Metrics"
  extends: [dim_course, dim_user]

  join: dim_course {
    relationship: many_to_one
    sql_on: ${coursekey} = ${dim_course.coursekey} ;;
  }

  join: dim_party {
    sql_on: ${full_student_course_metrics.user_guid} = ${dim_party.guid} ;;
    relationship: many_to_one
  }

  join: dim_user {
    relationship: many_to_one
    sql_on: ${dim_user.mainpartyid} = ${dim_party.partyid} ;;
  }
}

explore: duedates {
  label: "Upcoming due dates"
  extends: [dim_course]

  join: dim_course {
    relationship: many_to_one
    sql_on: ${coursekey} = ${dim_course.coursekey} ;;
  }
}
