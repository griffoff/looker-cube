view: answer {
  sql_table_name: STG_APLIA.ANSWER ;;

  dimension: answer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ANSWER_ID ;;
  }

  dimension: answer_option_order {
    type: string
    sql: ${TABLE}.ANSWER_OPTION_ORDER ;;
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

  dimension: deleted {
    type: string
    sql: ${TABLE}.DELETED ;;
  }

  dimension_group: deleted {
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
    sql: ${TABLE}.DELETED_DATE ;;
  }

  dimension: full_credit_yn {
    type: string
    sql: ${TABLE}.FULL_CREDIT_YN ;;
  }

  dimension: gradable_yn {
    type: string
    sql: ${TABLE}.GRADABLE_YN ;;
  }

  dimension_group: graded {
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
    sql: ${TABLE}.GRADED_DATE ;;
  }

  dimension_group: ldts {
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
    sql: ${TABLE}.LDTS ;;
  }

  dimension: multi_choice_answer {
    type: string
    sql: ${TABLE}.MULTI_CHOICE_ANSWER ;;
  }

  dimension: partial_credit {
    type: number
    sql: ${TABLE}.PARTIAL_CREDIT ;;
  }

  dimension: problem_guid {
    type: string
    sql: ${TABLE}.PROBLEM_GUID ;;
  }

  dimension: problem_set_guid {
    type: string
    sql: ${TABLE}.PROBLEM_SET_GUID ;;
  }

  dimension: prof_answer_yn {
    type: string
    sql: ${TABLE}.PROF_ANSWER_YN ;;
  }

  dimension: prof_comment {
    type: string
    sql: ${TABLE}.PROF_COMMENT ;;
  }

  dimension: random_seed {
    type: string
    sql: ${TABLE}.RANDOM_SEED ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.SCORE ;;
  }

  dimension_group: score_credit_last_modified {
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
    sql: ${TABLE}.SCORE_CREDIT_LAST_MODIFIED ;;
  }

  dimension: string_answer {
    type: string
    sql: ${TABLE}.STRING_ANSWER ;;
  }

  dimension: temp_score {
    type: number
    sql: ${TABLE}.TEMP_SCORE ;;
  }

  dimension: true_false_answer {
    type: string
    sql: ${TABLE}.TRUE_FALSE_ANSWER ;;
  }

  dimension: user_feedback {
    type: string
    sql: ${TABLE}.USER_FEEDBACK ;;
  }

  dimension: user_guid {
    type: string
    sql: ${TABLE}.USER_GUID ;;
  }

  dimension: view_only_yn {
    type: string
    sql: ${TABLE}.VIEW_ONLY_YN ;;
  }

  dimension_group: visible {
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
    sql: ${TABLE}.VISIBLE_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [answer_id]
  }
}
