view: wacarp_class_performance_classification {
  sql_table_name: WEBASSIGN.WACARP_CLASS_PERFORMANCE_CLASSIFICATION ;;

  dimension: display_name {
    type: string
    sql: ${TABLE}."DISPLAY_NAME" ;;
  }

  dimension: flag_high {
    type: number
    sql: ${TABLE}."FLAG_HIGH" ;;
  }

  dimension: flag_highest {
    type: number
    sql: ${TABLE}."FLAG_HIGHEST" ;;
  }

  dimension: flag_low {
    type: number
    sql: ${TABLE}."FLAG_LOW" ;;
  }

  dimension: flag_lowest {
    type: number
    sql: ${TABLE}."FLAG_LOWEST" ;;
  }

  dimension: flag_sufficient {
    type: number
    sql: ${TABLE}."FLAG_SUFFICIENT" ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}."SCORE" ;;
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
    drill_fields: [display_name]
  }
}
