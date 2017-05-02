view: problems_assigned {
  sql_table_name: STG_APLIA.PROBLEMS_ASSIGNED ;;

  measure: num_answers {
    type: number
    sql: ${TABLE}.NUM_ANSWERS ;;
  }

  measure: num_assigned_assignments {
    type: number
    sql: ${TABLE}.NUM_ASSIGNED_ASSIGNMENTS ;;
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
