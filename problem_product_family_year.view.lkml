view: problem_product_family_year {
  sql_table_name: STG_APLIA.PROBLEM_PRODUCT_FAMILY_YEAR ;;

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  measure: num_assigned {
    label: "# of courses assigned "
    type: sum
    sql: ${TABLE}.NUMBER_ASSIGNED ;;
  }
  measure: num_Answered {
    label: "# of answers "
    type: sum
    sql: ${TABLE}.number_Answered ;;
  }

  dimension: problem_id {
    type: string
    sql: ${TABLE}.PROBLEM_ID ;;
  }

  dimension: productfamily {
    type: string
    sql: ${TABLE}.PRODUCTFAMILY ;;
  }

  dimension: ProblemTitle {
    type: string
    sql: ${TABLE}.PROBLEM_TITLE ;;
  }
  dimension: startdatekey {
    type: string
    sql: ${TABLE}.STARTDATEKEY ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
