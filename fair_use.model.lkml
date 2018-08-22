include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/core/common.lkml"
include: "/project_source/*.view.lkml"
include: "dims.lkml" #include dims model
include: "/cube/*.view" #include all the views
include: "/cube/*dashboard.lookml*" #include all the dashboards


connection: "snowflake_prod"
label:"Cube Data on Looker"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
explore:  olr_nonolr_combined_user_activations {}
