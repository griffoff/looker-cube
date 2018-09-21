view: wacarp_student_responses {
  sql_table_name: WEBASSIGN.WACARP_STUDENT_RESPONSES ;;

  dimension: assignment_id {
    type: number
    sql: ${TABLE}."ASSIGNMENT_ID" ;;
  }

  dimension: attempt_num {
    type: number
    sql: ${TABLE}."ATTEMPT_NUM" ;;
  }

  dimension: boxnum {
    type: number
    sql: ${TABLE}."BOXNUM" ;;
  }

  dimension: deployment_id {
    type: number
    sql: ${TABLE}."DEPLOYMENT_ID" ;;
  }

  dimension_group: due {
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
    sql: ${TABLE}."DUE" ;;
  }

  dimension: is_correct {
    type: number
    sql: ${TABLE}."IS_CORRECT" ;;
  }

  dimension: question_id {
    type: number
    sql: ${TABLE}."QUESTION_ID" ;;
  }

  dimension: response_id {
    type: number
    sql: ${TABLE}."RESPONSE_ID" ;;
  }

  dimension: section_id {
    type: number
    sql: ${TABLE}."SECTION_ID" ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
