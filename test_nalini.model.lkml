connection: "snowflake_prod"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

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

explore: milady_course_engagement_accreditation_report_ga {
  label: "Milady Accreditation Data"
  description: "Data points to build the Acceditation report"
}

explore: liberty_daily_feed {
  label: "Liberty Data feed"
  description: "Data points for the daily feed to Liberty"
}
