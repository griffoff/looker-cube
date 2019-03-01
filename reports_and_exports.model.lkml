connection: "snowflake_prod"
label:"DEV - Reports / Exports"

include: "//core/common.lkml"
#include dims model
include: "dims.lkml"
# include all the views
include: "*.view"

# include all the dashboards
# include: "*.dashboard"

explore: magellan_data {
  label: "Magellan export"
  extends: [dim_course]
  fields: [ALL_FIELDS*, -fact_siteusage.time_on_task_to_final_score_correlation]
  join: dim_course {
    sql_on:  ${magellan_data.coursekey} = ${dim_course.coursekey} ;;
    relationship: one_to_one
  }

  join: fact_siteusage {
    sql_on: ${dim_course.courseid} = ${fact_siteusage.courseid}
          and ${magellan_data.week_of_course} = (floor((${fact_siteusage.daysfromcoursestart}-1)/7))::int
          and ${fact_siteusage.filterflag} = 0 ;;
    relationship: one_to_many
  }

  join: dim_user {
    fields: [dim_user.user_role]
    sql_on: ${fact_siteusage.userid} = ${dim_user.userid};;
          # and ${dim_user.user_role} = 'STUDENT' ;;
    relationship: many_to_one

  }

}

#explore: magellan_summary_data {}
