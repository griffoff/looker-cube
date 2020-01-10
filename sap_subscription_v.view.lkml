view: sap_subscription_v {
  label: "SAP_SUBSCRIPTION_EVENT"
  sql_table_name: SUBSCRIPTION.PROD.SAP_SUBSCRIPTION_EVENT ;;

  dimension_group: event_time {
    type: time
    label:"Event"
    timeframes: [raw, year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
  }


  measure: count {
    label: "# event_count"
    type: count
  }
  }
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
