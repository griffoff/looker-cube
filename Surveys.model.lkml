connection: "snowflake_migration_test"


include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
#include: "cube.model.lkml"     #include definitions from main model

 explore: aplia_passive_survey {
#    extends: [dim_course]
#   join: dim_course {
#    sql_on: ${aplia_passive_survey.coursecontextid} = ${dim_course.coursekey};;
#   }
 }
