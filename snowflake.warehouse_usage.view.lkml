view: warehouse_usage {
  sql_table_name: ZPG.WAREHOUSE_USAGE ;;

  measure: credits_used {
    type: sum
    sql: ${TABLE}.CREDITS_USED ;;
  }

  measure: credits_used_average {
    type: average
    sql: ${TABLE}.CREDITS_USED ;;
  }

  measure: credits_used_max {
    type: max
    sql: ${TABLE}.CREDITS_USED ;;
  }

  measure: credits_used_min {
    type: min
    sql: ${TABLE}.CREDITS_USED ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.END_TIME ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      hour3,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.START_TIME ;;
  }

  dimension: warehouse_name {
    type: string
    sql: ${TABLE}.WAREHOUSE_NAME ;;
  }

  measure: count {
    type: count
    drill_fields: [warehouse_name]
  }
}
