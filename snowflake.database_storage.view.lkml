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
    hidden: yes
  }

  dimension: days_in_month {
    type: number
    sql:  EXTRACT(day FROM LAST_DAY(${usage_raw}));;
    hidden: yes
  }

  dimension: average_failsafe_bytes {
    type: number
    sql: ${TABLE}.AVERAGE_FAILSAFE_BYTES ;;
    hidden: yes
  }

  dimension: daily_total_Tbytes {
    sql:(${average_database_bytes} + ${average_failsafe_bytes}) / power(1024, 4);;
    value_format_name: TB_1
  }

  dimension: hourly_total_Tbytes {
    sql:(${daily_total_Tbytes}) / 12;;
    value_format_name: TB_1
  }

  measure: credit_usage {
    type: sum
    sql:${daily_total_Tbytes};;
    value_format_name: TB_1
  }

  measure: credit_usage_per_hour {
    type: sum
    sql:${hourly_total_Tbytes};;
    value_format_name: decimal_2
  }

  dimension: storage_rate {
    type: number
    sql: 23 / ${days_in_month};;
    hidden: yes
  }

  measure: storage_cost {
    type: sum
    sql:  ${daily_total_Tbytes} * ${storage_rate} ;;
    value_format_name: currency
  }

  measure: storage_cost_per_hour {
    type: sum
    required_fields: [usage_date]
    sql:${hourly_total_Tbytes} * ${storage_rate} ;;
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
