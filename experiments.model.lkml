connection: "snowflake_prod"
label:"Experimental / Data Science"

include: "/core/common.lkml"
#include dims model
include: "dims.lkml"
# include all the views
include: "*.view"


explore: activities_per_week {
  extends: [dim_course]
  label: "Student Assignment Completion"
  description: "Data set used as base for trial period abuse investigation"
  join: dim_course {
    sql_on: ${activities_per_week.courseid} = ${dim_course.courseid};;
    relationship: many_to_one
  }
}
