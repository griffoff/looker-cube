connection: "snowflake_migration_test"
label:"Source Data on Snowflake"
include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: entities {

}
#
#   join: users {
#     sql_on: ${users.id} = ${orders.user_id}
#   }
# }
