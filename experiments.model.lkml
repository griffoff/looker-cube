connection: "snowflake_prod"
label:"Cube Data on Looker"

#include dims model
include: "dims.model.lkml"
# include all the views
include: "*.view"

#  explore:  dim_learningpath_explore {
#    # extends: [fact_activityoutcome, fact_siteusage]
#    extends: [dim_course]
#    view_name: dim_learningpath
#    label: "Learning Path"
#
#    join:  fact_activityoutcome {
#      relationship: one_to_many
#      sql_on: ${dim_learningpath.learningpathid} = ${fact_activityoutcome.learningpathid} ;;
#    }
#
#    join:  fact_siteusage {
#      relationship: one_to_many
#      sql_on: ${dim_learningpath.learningpathid} = ${fact_siteusage.learningpathid} ;;
#    }
#
#    join: dim_course {
#      relationship: many_to_one
#      sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
#   }
#
#  }

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

# explore:  course_analysis {
#   from: dim_course
#   label: "Start with Course/Section"
#
#   join:  fact_activation {
#     sql_on: ${course_analysis.courseid} = ${fact_activation.courseid} ;;
#     relationship: one_to_many
#   }
#
#   join: dim_product {
#     sql_on: ${course_analysis.productid} = ${dim_product.productid} ;;
#     relationship: many_to_one
#   }
#
#   join: dim_user {
#     sql_on: ${fact_activation.userid} = ${dim_user.userid} ;;
#     relationship: many_to_one
#   }
#
#   join: fact_activity {
#     sql_on: ${course_analysis.courseid} = ${fact_activity.courseid} ;;
#     relationship: one_to_many
#   }
#
#   join: dim_eventtype {
#     sql_on: ${fact_activity.eventtypeid} = ${dim_eventtype.eventtypeid} ;;
#     relationship: many_to_one
#   }
#
#   join: dim_activity {
#     sql_on: ${fact_activity.activityid} = ${dim_activity.activityid} ;;
#     relationship: many_to_one
#   }
#
#   join: fact_activityoutcome {
#     sql_on: (${course_analysis.courseid},${dim_activity.activityid}, ${fact_activation.userid}) = (${fact_activityoutcome.courseid}, ${fact_activityoutcome.activityid}, ${fact_activityoutcome.userid}) =  ;;
#     relationship: one_to_many
#   }
#
#
# }
