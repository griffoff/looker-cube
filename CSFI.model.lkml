connection: "snowflake_dev"
label:"CSFI Data"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "cube.model.lkml"

explore: csfitakes {
  extends: [dim_course]

   label: "Surveys"
   join: dim_course {
      #sql_on: ${csfitakes.coursekey} = ${dim_course.coursekey};;
      relationship: many_to_one
   }
  }
