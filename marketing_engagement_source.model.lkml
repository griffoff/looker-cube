connection: "snowflake_dev"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
#include dims model
include: "dims.lkml"

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
explore: engagementsource_marketing{
    label: "engagement_marketing"
    extends: [dim_course]
    join:  dim_course {
      sql_on: ${dim_course.coursekey} = ${engagementsource_marketing.coursekey} ;;
      relationship: many_to_one
    }
}
