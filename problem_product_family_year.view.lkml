view: problem_product_family_year {
  sql_table_name: STG_APLIA.PROBLEM_PRODUCT_FAMILY_YEAR ;;

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  measure: num_of_courses_actual {
    type: sum
    sql: ${TABLE}.NUM_OF_COURSES_ACTUAL ;;
  }

  dimension: problem_id {
    type: string
    sql: ${TABLE}.PROBLEM_ID ;;
  }

  measure: product_family_size {
    type: sum
    sql: ${TABLE}.PRODUCT_FAMILY_SIZE ;;
  }

  dimension: productfamily {
    type: string
    sql: ${TABLE}.PRODUCTFAMILY ;;
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
