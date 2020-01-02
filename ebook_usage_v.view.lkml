view: ebook_usage_v {
   sql_table_name:prod.unlimited.cu_ebook_usage;;

  dimension_group: event_time {
  type: time
  label:"Date"
  timeframes: [raw, year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
}

  dimension: activity_count {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.activity_count ;;
  }



  measure: Activity_Count {
    label: "# event_count"
    type: sum
    sql: ${TABLE}.activity_count;;
  }

  }
