view: warehouse_usage_detail {
  sql_table_name: ZPG.WAREHOUSE_USAGE_DETAIL ;;


  set: query_details {
    fields: [start_time, query_text, query_type, warehouse_name, database_name, schema_name, role_name, user_name, total_elapsed_time_compute_only, warehouse_cost]
  }
  dimension: database_name {
    type: string
    sql: ${TABLE}.DATABASE_NAME ;;
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
    hidden: yes
  }

  dimension: query_id {
    type: string
    sql: ${TABLE}.QUERY_ID ;;
    primary_key: yes
  }

  dimension: query_text {
    type: string
    sql: ${TABLE}.QUERY_TEXT ;;
  }

  dimension: query_type {
    type: string
    sql: ${TABLE}.QUERY_TYPE ;;
  }

  dimension: role_name {
    type: string
    sql: ${TABLE}.ROLE_NAME ;;
  }

  dimension: schema_name {
    type: string
    sql: ${TABLE}.SCHEMA_NAME ;;
  }

  dimension: start_time_key {
    sql: ${TABLE}.start_hour ;;
    hidden: yes
  }

  dimension_group: start {
    label: "Query"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      hour,
      hour3,
      hour6,
      date,
      day_of_week,
      day_of_month,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.START_TIME ;;
  }

  dimension: user_name {
    type: string
    sql: ${TABLE}.USER_NAME ;;
  }

  dimension: uses_credits {
    type: string
    #sql:${TABLE}.USES_COMPUTE=1 ;;
    case: {
      when: {
        #sql: ${query_type} in ('SELECT', 'UPDATE', 'INSERT', 'DELETE', 'COPY', 'MERGE');;
        sql: ${query_type} not in ('DESCRIBE', 'SHOW', 'CREATE_TABLE', 'ALTER SESSION', 'COPY', 'MERGE', 'USE', 'DROP', 'CREATE CONSTRAINT', 'ALTER USER');;
        label: "Uses Credits"
        }
      else: "No Credit Usage"
    }
  }

  dimension: uses_compute {
      type: yesno
      sql:${uses_credits}='Uses Credits' ;;
  }

  dimension: warehouse_name {
    type: string
    sql: ${TABLE}.WAREHOUSE_NAME ;;
    hidden: no
  }

  dimension: warehouse_size {
    type: string
    sql: ${TABLE}.WAREHOUSE_SIZE ;;
  }

  measure: count {
    type: count
    drill_fields: [database_name, schema_name, user_name, role_name, warehouse_name]
  }

  measure: total_elapsed_time {
    type: sum
    sql: ${TABLE}.TOTAL_ELAPSED_TIME / 1000 / 3600 / 24 ;;
    value_format_name: duration_hms
    drill_fields: [query_details*]
  }

  measure: total_elapsed_time_compute_only {
    type: sum
    sql: ${TABLE}.TOTAL_ELAPSED_TIME / 1000 / 3600 / 24;;
    filters: {
      field: uses_compute
      value: "Yes"
    }
    value_format_name: duration_hms
    drill_fields: [query_details*]
  }

  measure: credit_usage_percent {
    type: number
    sql: (${warehouse_usage_detail.total_elapsed_time_compute_only} / nullif(${warehouse_usage_total_time.total_elapsed_time_compute_only}, 0));;
    value_format_name: percent_2
  }

  measure: credit_usage {
    type: number
    sql: (${credit_usage_percent}) * ${warehouse_usage.credits_used};;
    value_format_name: decimal_2
    drill_fields: [query_details*]
  }

  measure: warehouse_cost_per_credit {
    type: number
    sql: 1.4 ;;
    hidden: yes
  }

  measure: warehouse_cost_raw {
    type: number
    sql: ${credit_usage} * ${warehouse_cost_per_credit} ;;
    value_format_name: currency
    drill_fields: [query_details*]
    hidden: yes
  }

  measure: warehouse_cost {
    label:"Warehouse Cost"
    type: number
    sql: coalesce(${warehouse_cost_raw}, ${warehouse_usage.warehouse_cost}) ;;
    value_format_name: currency
    drill_fields: [query_details*]
  }

  measure: warehouse_cost_monthly {
    label:"Warehouse Cost (1 month at this rate)"
    type: number
    sql: ${warehouse_cost} * 24 * 365 / 12;;
    value_format_name: currency
    drill_fields: [query_details*]
    required_fields: [start_hour]
  }

  measure: warehouse_cost_monthly_6 {
    label:"Warehouse Cost (1 month at the last 6 hours avg rate)"
    type: number
    sql: sum(${warehouse_cost}) over (order by ${start_hour} rows between 6 preceding and current row) * 4 * 365 / 12;;
    value_format_name: currency
    drill_fields: [query_details*]
    required_fields: [start_hour]
  }

  measure: warehouse_cost_mtd {
    required_fields: [start_date, start_month]
    type: number
    sql: sum(${warehouse_cost}) over (partition by ${start_month} order by ${start_date} rows unbounded preceding) ;;
    value_format_name: currency
  }

  measure: storage_cost {
    type: number
    sql: ${database_storage.storage_cost_per_hour} * count(distinct ${start_hour}) ;;
    value_format_name: currency
  }
}
