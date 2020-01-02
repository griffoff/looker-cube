view: sap_subscription_v {
    derived_table: {
      sql: SELECT EVENT_TIME::date as date, 'SAP-SUBSCRIPTION' as DATASET
          FROM SUBSCRIPTION.PROD.SAP_SUBSCRIPTION_EVENT
          GROUP BY 1
          ORDER BY 1 DESC
       ;;
    }

    dimension: date {
      type: date
      sql: ${TABLE}."DATE" ;;
    }


    dimension: dataset {
      type: string
      sql: ${TABLE}."DATASET" ;;
    }

    set: detail {
      fields: [date, count, dataset]
    }
  measure: count {
    label: "# Activity Count"
    type: count
    sql: ${TABLE}.date ;;
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
