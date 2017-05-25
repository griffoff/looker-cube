view: problem_usage {
  sql_table_name: STG_APLIA.PROBLEM_USAGE ;;

  dimension: problem_id {
    type: string
    sql: ${TABLE}.PROBLEM_ID ;;
  }
  measure: num_of_courses_actual {
    label: "# of courses this problem id is used in"
    type: sum
    sql: ${TABLE}.NUM_OF_COURSES_ACTUAL ;;
  }

  measure: num_of_courses_possible {
    label: "# of courses this problem id could be used in based on product family"
    type: sum
    sql: ${TABLE}.NUM_OF_COURSES_POSSIBLE ;;
  }

  measure: percent_used {
    label: "course coverage - actual over possible"
    type: percent_of_total
    sql: (${num_of_courses_actual} / ${num_of_courses_possible})*100;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
  measure: problem_count {
    label: "# of problem IDs"
    type: count_distinct
    sql: ${TABLE}.PROBLEM_ID;;
  }
}
