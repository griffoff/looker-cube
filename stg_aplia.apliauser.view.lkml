view: apliauser {
  sql_table_name: STG_APLIA.APLIAUSER ;;

  dimension: apliauser_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.APLIAUSER_ID ;;
  }

  dimension: completed_assignments {
    type: number
    sql: ${TABLE}.COMPLETED_ASSIGNMENTS ;;
  }

  dimension_group: create {
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
    sql: ${TABLE}.CREATE_DATE ;;
  }

  dimension_group: date_of_birth {
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
    sql: ${TABLE}.DATE_OF_BIRTH ;;
  }

  dimension: default_course_guid {
    type: string
    sql: ${TABLE}.DEFAULT_COURSE_GUID ;;
  }

  dimension: email_reminders {
    type: number
    sql: ${TABLE}.EMAIL_REMINDERS ;;
  }

  dimension: failed_logon_attempt_count {
    type: number
    sql: ${TABLE}.FAILED_LOGON_ATTEMPT_COUNT ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: guid {
    type: string
    sql: ${TABLE}.GUID ;;
  }

  dimension: inactive {
    type: number
    sql: ${TABLE}.INACTIVE ;;
  }

  dimension: is_gateway_user {
    type: number
    sql: ${TABLE}.IS_GATEWAY_USER ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: middle_initial {
    type: string
    sql: ${TABLE}.MIDDLE_INITIAL ;;
  }

  dimension: nickname {
    type: string
    sql: ${TABLE}.NICKNAME ;;
  }

  dimension: password {
    type: string
    sql: ${TABLE}.PASSWORD ;;
  }

  dimension: security_question_answer {
    type: string
    sql: ${TABLE}.SECURITY_QUESTION_ANSWER ;;
  }

  dimension: security_question_id {
    type: number
    sql: ${TABLE}.SECURITY_QUESTION_ID ;;
  }

  dimension: sso_guid {
    type: string
    sql: ${TABLE}.SSO_GUID ;;
  }

  dimension: three_day_also {
    type: number
    sql: ${TABLE}.THREE_DAY_ALSO ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: verification_code {
    type: string
    sql: ${TABLE}.VERIFICATION_CODE ;;
  }

  dimension_group: verified {
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
    sql: ${TABLE}.VERIFIED_DATE ;;
  }

  dimension: verified_yn {
    type: number
    sql: ${TABLE}.VERIFIED_YN ;;
  }

  measure: count {
    type: count
    drill_fields: [apliauser_id, first_name, last_name, nickname]
  }
}
