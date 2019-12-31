view: cap_eventing_v {
    derived_table: {
      sql: SELECT DISTINCT EVENT_TIME::date as date,
              COUNT(*) AS COUNT, 'CAP_PROFILE_EVENT' as source FROM CAP_EVENTING.PROD.CAP_PROFILE_EVENT
              Group by 1
              UNION ALL
              SELECT DISTINCT EVENT_TIME::date as date,
              COUNT(*) AS COUNT, 'CAP_ACTIVITY_EVENT' as source FROM CAP_EVENTING.PROD.CAP_ACTIVITY_EVENT
              Group by 1
              UNION ALL
              SELECT DISTINCT EVENT_TIME::date as date,
              COUNT(*) AS COUNT, 'CLIENT_ACTIVITY_EVENT' as source FROM CAP_EVENTING.PROD.CLIENT_ACTIVITY_EVENT
              Group by 1
              UNION ALL
              SELECT DISTINCT EVENT_TIME::date as date,
              COUNT(*) AS COUNT, 'CLIENT_PROFILE_EVENT' as source FROM CAP_EVENTING.PROD.CLIENT_PROFILE_EVENT
              Group by 1
              UNION ALL
              SELECT DISTINCT EVENT_TIME::date as date,
              COUNT(*) AS COUNT, 'WA_CLIENT_ACTIVITY_EVENT' as source FROM CAP_EVENTING.PROD.WA_CLIENT_ACTIVITY_EVENT
              Group by 1
              UNION ALL
              SELECT DISTINCT EVENT_TIME::date as date,
              COUNT(*) AS COUNT, 'WA_CLIENT_PROFILE_EVENT' as source FROM CAP_EVENTING.PROD.WA_CLIENT_PROFILE_EVENT
              Group by 1
              UNION ALL
              SELECT DISTINCT EVENT_TIME::date as date,
              COUNT(*) AS COUNT, 'SERVER_ACTIVITY_EVENT' as source FROM CAP_EVENTING.PROD.SERVER_ACTIVITY_EVENT
              Group by 1
              order by 1
               ;;
    }

    dimension: date {
      type: date
      sql: ${TABLE}."DATE" ;;
    }

    dimension: count {
      type: number
      sql: ${TABLE}."COUNT" ;;
    }

    dimension: source {
      type: string
      sql: ${TABLE}."SOURCE" ;;
    }

    set: detail {
      fields: [date, count, source]
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
