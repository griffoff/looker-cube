connection: "snowflake_prod"
label:"DEV - Reports / Exports"

#include dims model
include: "dims.model.lkml"
# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: magellan_data {
  label: "Magellan export"
  extends: [dim_course]
  join: dim_course {
    sql_on:  ${magellan_data.coursekey} = ${dim_course.coursekey} ;;
    relationship: one_to_one
  }
}

#explore: magellan_summary_data {}
