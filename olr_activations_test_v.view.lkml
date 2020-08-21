view: olr_activations_test_v {
    derived_table: {
      sql: select local_time as event_time , count(*) as count1 from OLR.PROD.SECTION_V4
              group by 1
              union all
              select local_time as event_time , count(*) as count1 from OLR.PROD.PRODUCT_v4
              group by 1
              union all
              select local_time as event_time , count(*) as count1 from OLR.PROD.PROVISIONED_PRODUCT_v4
              group by 1
              union all
              select event_time as event_time , count(*) as count1 from OLR.PROD.RAW_EL_TO_SECTION_MAPPING_v4
              group by 1
              union all
              select event_time as event_time , count(*) as count1 from OLR.PROD.RAW_ENROLLMENT_v4
              group by 1
              union all
              select local_time as event_time , count(*) as count1 from OLR.PROD.SERIAL_NUMBER_v4
              group by 1
              union all
              select event_time as event_time , count(*) as count1 from OLR.PROD.ENTERPRISE_LICENSE
              group by 1
              order by 1 Desc limit 50
               ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

  dimension_group: event_time {
    type: time
    label:"Event"
    timeframes: [raw, year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
    sql: ${TABLE}."EVENT_TIME" ;;
  }

    dimension: count1 {
      type: number
      sql: ${TABLE}."COUNT1" ;;
    }

    set: detail {
      fields: [event_time_time, count1]
    }



  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: olr_activations_test_v {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
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
