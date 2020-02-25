connection: "snowflake_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

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


# explore: fivetran_audit {}


# explore: engagementsource_marketing{
#   label: "engagement_marketing"
#   extends: [dim_course]
#   join:  dim_course {
#     sql_on: ${dim_course.coursekey} = ${engagementsource_marketing.coursekey} ;;
#     relationship: many_to_one
#   }
# }

# explore: new_mt_gtm_events {}
