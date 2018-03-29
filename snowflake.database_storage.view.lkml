view: database_storage {
  sql_table_name: ZPG.DATABASE_STORAGE ;;

  dimension: pk {
    sql: ${database_name} || ${usage_date} ;;
    hidden: yes
    primary_key: yes
  }
  dimension: average_database_bytes {
    type: number
    sql: ${TABLE}.AVERAGE_DATABASE_BYTES ;;
  }

  dimension: average_failsafe_bytes {
    type: number
    sql: ${TABLE}.AVERAGE_FAILSAFE_BYTES ;;
  }

  dimension: daily_total_Tbytes {
    sql:(${average_database_bytes} + ${average_failsafe_bytes}) / 1024 / 1024 / 1024 / 1024;;
    value_format_name: decimal_2
  }

  measure: average_daily_Tbytes {
    type: average
    sql:${daily_total_Tbytes} ;;
    value_format_name: decimal_2
  }

  measure: credit_usage {
    type:sum
    sql:${daily_total_Tbytes} / 28;;
    value_format_name: decimal_2
  }

  measure: storage_cost_per_credit {
    type: number
    sql: 23 ;;
    hidden: yes
  }

  measure: storage_cost_per_day {
    type: number
    sql: ${credit_usage} * ${storage_cost_per_credit} ;;
    value_format_name: currency
  }

  measure: storage_cost_per_hour {
    type: number
    sql: (${credit_usage} * ${storage_cost_per_credit}) / 24;;
    value_format_name: currency
  }

  dimension: database_name {
    type: string
    sql: ${TABLE}.DATABASE_NAME ;;
  }

  dimension_group: usage {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.USAGE_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [database_name]
  }
}
