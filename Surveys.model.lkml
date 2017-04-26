connection: "snowflake_prod"

include: "*.view.lkml"
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "dims.model.lkml"     #include definitions from main model

label: "Qualtrics Surveys"

 explore: aplia_passive_survey {
   extends: [dim_course]
   label: "Aplia Passive Survey"
   join: dim_course {
    sql_on: ${aplia_passive_survey.coursecontextid} = ${dim_course.coursekey};;
    relationship: many_to_one
   }
 }
