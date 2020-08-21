view: sap_subscription_v {
    derived_table: {
      sql: select * from SUBSCRIPTION.PROD.SAP_SUBSCRIPTION_EVENT
        ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension_group: _ldts {
      type: time
      sql: ${TABLE}."_LDTS" ;;
    }

    dimension: _rsrc {
      type: string
      sql: ${TABLE}."_RSRC" ;;
    }

    dimension: message_format_version {
      type: number
      sql: ${TABLE}."MESSAGE_FORMAT_VERSION" ;;
    }

    dimension: message_type {
      type: string
      sql: ${TABLE}."MESSAGE_TYPE" ;;
    }

    dimension: product_platform {
      type: string
      sql: ${TABLE}."PRODUCT_PLATFORM" ;;
    }

    dimension: platform_environment {
      type: string
      sql: ${TABLE}."PLATFORM_ENVIRONMENT" ;;
    }

    dimension: user_environment {
      type: string
      sql: ${TABLE}."USER_ENVIRONMENT" ;;
    }

    dimension_group: event_time {
      type: time
      sql: ${TABLE}."EVENT_TIME" ;;
    }

    dimension: current_guid {
      type: string
      sql: ${TABLE}."CURRENT_GUID" ;;
    }

    dimension: original_guid {
      type: string
      sql: ${TABLE}."ORIGINAL_GUID" ;;
    }

    dimension_group: initialization_time {
      type: time
      sql: ${TABLE}."INITIALIZATION_TIME" ;;
    }

    dimension: contract_id {
      type: string
      sql: ${TABLE}."CONTRACT_ID" ;;
    }

    dimension: contract_status {
      type: string
      sql: ${TABLE}."CONTRACT_STATUS" ;;
    }

    dimension: subscription_id {
      type: string
      sql: ${TABLE}."SUBSCRIPTION_ID" ;;
    }

    dimension_group: subscription_start {
      type: time
      sql: ${TABLE}."SUBSCRIPTION_START" ;;
    }

    dimension_group: subscription_end {
      type: time
      sql: ${TABLE}."SUBSCRIPTION_END" ;;
    }

    dimension_group: available_until {
      type: time
      sql: ${TABLE}."AVAILABLE_UNTIL" ;;
    }

    dimension: subscription_status {
      type: string
      sql: ${TABLE}."SUBSCRIPTION_STATUS" ;;
    }

    dimension: subscription_plan_id {
      type: string
      sql: ${TABLE}."SUBSCRIPTION_PLAN_ID" ;;
    }

    dimension: subscription_duration {
      type: string
      sql: ${TABLE}."SUBSCRIPTION_DURATION" ;;
    }

    dimension_group: placed_time {
      type: time
      sql: ${TABLE}."PLACED_TIME" ;;
    }

    dimension_group: cancelled_time {
      type: time
      sql: ${TABLE}."CANCELLED_TIME" ;;
    }

    dimension: cancellation_reason {
      type: string
      sql: ${TABLE}."CANCELLATION_REASON" ;;
    }

    dimension: payment_source_type {
      type: string
      sql: ${TABLE}."PAYMENT_SOURCE_TYPE" ;;
    }

    dimension: payment_source_id {
      type: string
      sql: ${TABLE}."PAYMENT_SOURCE_ID" ;;
    }

    dimension: payment_source_guid {
      type: string
      sql: ${TABLE}."PAYMENT_SOURCE_GUID" ;;
    }

    dimension: payment_source_line {
      type: string
      sql: ${TABLE}."PAYMENT_SOURCE_LINE" ;;
    }

    dimension: item_id {
      type: string
      sql: ${TABLE}."ITEM_ID" ;;
    }

    set: detail {
      fields: [
        _ldts_time,
        _rsrc,
        message_format_version,
        message_type,
        product_platform,
        platform_environment,
        user_environment,
        event_time_time,
        current_guid,
        original_guid,
        initialization_time_time,
        contract_id,
        contract_status,
        subscription_id,
        subscription_start_time,
        subscription_end_time,
        available_until_time,
        subscription_status,
        subscription_plan_id,
        subscription_duration,
        placed_time_time,
        cancelled_time_time,
        cancellation_reason,
        payment_source_type,
        payment_source_id,
        payment_source_guid,
        payment_source_line,
        item_id
      ]
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
