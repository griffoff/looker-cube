connection: "snowflake_migration_test"


include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
 explore: aplia_passive_survey {
  # join: dim_course {
#     sql_on: ${aplia_passive_survey.coursecontextid} = ${dim_course.coursekey}
#   }
#
#   join: users {
#     sql_on: ${users.id} = ${orders.user_id}
#   }
 }
