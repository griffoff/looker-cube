view: olr_activations_v {
  derived_table: {
    sql: select local_time as localtime,message_type from OLR.PROD.PRODUCT_v4
      //limit 1 local
      group by 1,2
      union all
      select local_time as localtime,message_type from OLR.PROD.PROVISIONED_PRODUCT_v4
      group by 1,2
      union all
      select event_time as localtime,message_type from OLR.PROD.RAW_EL_TO_SECTION_MAPPING_v4
      group by 1,2
      union all
      select event_time as localtime,message_type from OLR.PROD.RAW_ENROLLMENT_v4
      group by 1,2
      union all
      select local_time as localtime,message_type from OLR.PROD.SERIAL_NUMBER_v4
      group by 1,2
      union all
      select event_time as localtime,message_type from OLR.PROD.ENTERPRISE_LICENSE
      group by 1,2
      order by 1 desc
       ;;
  }

  measure: count {
    type: count
#     drill_fields: [detail*]
  }
#  dimension_group: localtime {
#   type: time
#   label:"localtime"
#   timeframes: [raw, year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
# }

dimension: localtime {
  type: date
}

  dimension: message_type {
    type: string
    sql: ${TABLE}."MESSAGE_TYPE" ;;
  }

#   set: detail {
#     fields: [localtime, message_type]
#   }
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
