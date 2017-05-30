view: membership {
  sql_table_name: STG_APLIA.MEMBERSHIP ;;

  dimension: context_guid {
    type: string
    sql: ${TABLE}.CONTEXT_GUID ;;
  }

  dimension_group: enroll {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ENROLL_DATE ;;
  }

  dimension: etextbook_purchased {
    type: number
    sql: ${TABLE}.ETEXTBOOK_PURCHASED ;;
  }

  dimension_group: grace_period_extension {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.GRACE_PERIOD_EXTENSION ;;
  }

  dimension: payment_status {
    type: string
    sql: ${TABLE}.PAYMENT_STATUS ;;
  }

  dimension: role_guid {
    type: string
    sql: ${TABLE}.ROLE_GUID ;;
  }

  dimension: rpt_alert_show_yn {
    type: number
    sql: ${TABLE}.RPT_ALERT_SHOW_YN ;;
  }

  dimension: second_term_credit_amount {
    type: number
    sql: ${TABLE}.SECOND_TERM_CREDIT_AMOUNT ;;
  }

  dimension_group: second_term_credit_applied {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SECOND_TERM_CREDIT_APPLIED_DATE ;;
  }

  dimension: second_term_credit_applied_id {
    type: number
    sql: ${TABLE}.SECOND_TERM_CREDIT_APPLIED_ID ;;
  }

  dimension: second_term_credit_type {
    type: number
    sql: ${TABLE}.SECOND_TERM_CREDIT_TYPE ;;
  }

  dimension: section_guid {
    type: string
    sql: ${TABLE}.SECTION_GUID ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: status_comment {
    type: string
    sql: ${TABLE}.STATUS_COMMENT ;;
  }

  dimension: student_id {
    type: string
    sql: ${TABLE}.STUDENT_ID ;;
  }

  dimension: student_status {
    type: string
    sql: ${TABLE}.STUDENT_STATUS ;;
  }

  dimension: textbook_purchased {
    type: number
    sql: ${TABLE}.TEXTBOOK_PURCHASED ;;
  }

  dimension: third_term_credit_amount {
    type: number
    sql: ${TABLE}.THIRD_TERM_CREDIT_AMOUNT ;;
  }

  dimension_group: third_term_credit_applied {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.THIRD_TERM_CREDIT_APPLIED_DATE ;;
  }

  dimension: third_term_credit_applied_id {
    type: number
    sql: ${TABLE}.THIRD_TERM_CREDIT_APPLIED_ID ;;
  }

  dimension: third_term_credit_type {
    type: number
    sql: ${TABLE}.THIRD_TERM_CREDIT_TYPE ;;
  }

  dimension: transfer_to_guid {
    type: string
    sql: ${TABLE}.TRANSFER_TO_GUID ;;
  }

  dimension: user_guid {
    type: string
    sql: ${TABLE}.USER_GUID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
