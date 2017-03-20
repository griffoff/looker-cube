connection: "snowflake_dev"
label:"Item Analysis"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "cube.model.lkml"

explore: csfitakes {
  label: "CSFI data"
  extends: [dim_course]
   join: dim_course {
      sql_on: ${csfitakes.coursekey} = ${dim_course.coursekey};;
      relationship: many_to_one
   }
  }

explore: mankiw_questions {
  label: "Mankiw data"
  extends: [dim_course]
  join: dim_course {
    sql_on: ${mankiw_questions.coursekey} = ${dim_course.coursekey};;
    relationship: many_to_one
  }
}
