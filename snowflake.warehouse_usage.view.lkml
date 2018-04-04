view: warehouse_usage {
  view_label: "Warehouse Usage"
  sql_table_name: ZPG.WAREHOUSE_USAGE ;;

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
    hidden: yes
  }

  dimension: start_time_key {
    sql: ${start_raw} ;;
    hidden: yes
  }

  dimension: pk {
    sql: ${warehouse_name} || ${start_time_key} ;;
    hidden: yes
    primary_key: yes
  }

  dimension_group: start {
    label: "Usage"
    type: time
    timeframes: [
      raw,
      hour,
      hour_of_day,
      day_of_week,
      day_of_month,
      hour3,
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_year
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

  measure: warehouse_cost_per_credit {
    type: number
    sql: 1.4 ;;
    hidden: yes
  }

  measure: warehouse_cost {
    type: number
    sql: ${credits_used} * ${warehouse_cost_per_credit} ;;
    value_format_name: currency
  }

  measure: warehouse_cost_mtd {
    required_fields: [warehouse_name, start_date, start_month]
    type: number
    sql: sum(${warehouse_cost}) over (partition by ${warehouse_name}, ${start_month} order by ${start_date} rows unbounded preceding) ;;
    value_format_name: currency
  }
}
