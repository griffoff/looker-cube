explore: course_keys_filter_3 {}
view: course_keys_filter_3 {
  sql_table_name: DW.DW.COURSE_KEYS_FILTER_3
    ;;

  dimension: course_key {
    type: string
    sql: ${TABLE}."COURSE_KEY" ;;
  }

  dimension: course_key_flag {
    type: string
    sql: 1 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
