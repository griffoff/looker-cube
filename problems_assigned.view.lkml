view: problems_assigned {
  sql_table_name: STG_APLIA.PROBLEMS_ASSIGNED ;;

  measure: num_answers {
    type: sum
    sql: ${TABLE}.NUM_ANSWERS ;;
  }
  measure: num_answers_avg {
    label: "average # of answers "
    type: average
    sql:  ${TABLE}.NUM_ANSWERS ;;
  }
  measure: num_answers_sum {
    label: "sum of answers "
    type: sum
    sql:  ${TABLE}.NUM_ANSWERS ;;
  }

  measure: num_assigned {
    type: sum
    sql: ${TABLE}.NUM_ASSIGNED_ASSIGNMENTS ;;
  }
  measure: num_assigned_avg {
    label: "average # of assignments "
    type: average
    sql:  ${TABLE}.NUM_ASSIGNED_ASSIGNMENTS ;;
  }
  measure: num_assigned_sum {
    label: "sum of assignments "
    type: sum
    sql:  ${TABLE}.NUM_ASSIGNED_ASSIGNMENTS ;;
  }
  dimension: problem_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.PROBLEM_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [problem.problem_id]
  }
}
