view: rental_events_v {
  derived_table: {
    sql: select * from SUBSCRIPTION.NONPROD.SAP_RENTAL_EVENT limit 5
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

  dimension: rental_contract_id {
    type: string
    sql: ${TABLE}."RENTAL_CONTRACT_ID" ;;
  }

  dimension: isbn13 {
    type: string
    sql: ${TABLE}."ISBN13" ;;
  }

  dimension: customer_guid {
    type: string
    sql: ${TABLE}."CUSTOMER_GUID" ;;
  }

  dimension: rental_plan_id {
    type: string
    sql: ${TABLE}."RENTAL_PLAN_ID" ;;
  }

  dimension: linked_subscription_id {
    type: string
    sql: ${TABLE}."LINKED_SUBSCRIPTION_ID" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension_group: start_date {
    type: time
    sql: ${TABLE}."START_DATE" ;;
  }

  dimension_group: ship_date {
    type: time
    sql: ${TABLE}."SHIP_DATE" ;;
  }

  dimension_group: placed_time {
    type: time
    sql: ${TABLE}."PLACED_TIME" ;;
  }

  dimension_group: end_date {
    type: time
    sql: ${TABLE}."END_DATE" ;;
  }

  dimension: list_price {
    type: number
    sql: ${TABLE}."LIST_PRICE" ;;
  }

  dimension: accrued_value {
    type: number
    sql: ${TABLE}."ACCRUED_VALUE" ;;
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}."CURRENCY_CODE" ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}."EVENT_TYPE" ;;
  }

  dimension: period_name {
    type: string
    sql: ${TABLE}."PERIOD_NAME" ;;
  }

  dimension: external_system_id {
    type: string
    sql: ${TABLE}."EXTERNAL_SYSTEM_ID" ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}."EXTERNAL_ID" ;;
  }

  dimension: order_number {
    type: string
    sql: ${TABLE}."ORDER_NUMBER" ;;
  }

  dimension: order_entry_number {
    type: number
    sql: ${TABLE}."ORDER_ENTRY_NUMBER" ;;
  }

  dimension: book_condition {
    type: string
    sql: ${TABLE}."BOOK_CONDITION" ;;
  }

  dimension: duration_days {
    type: number
    sql: ${TABLE}."DURATION_DAYS" ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}."AMOUNT" ;;
  }

  dimension: shipment_tracking_number {
    type: string
    sql: ${TABLE}."SHIPMENT_TRACKING_NUMBER" ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}."NOTES" ;;
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
      rental_contract_id,
      isbn13,
      customer_guid,
      rental_plan_id,
      linked_subscription_id,
      status,
      start_date_time,
      ship_date_time,
      placed_time_time,
      end_date_time,
      list_price,
      accrued_value,
      currency_code,
      event_type,
      period_name,
      external_system_id,
      external_id,
      order_number,
      order_entry_number,
      book_condition,
      duration_days,
      amount,
      shipment_tracking_number,
      notes
    ]
  }
}
