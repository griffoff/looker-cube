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
    label: "Query Start"
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
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
        sql: ${query_type} not in ('DESCRIBE', 'SHOW', 'CREATE_TABLE', 'ALTER SESSION', 'COPY', 'MERGE', 'USE');;
        label: "Uses Credits"
        }
      else: "No Credit Usage"
    }
  }

  dimension: uses_compute {
      type: string
      sql:${uses_credits}='Uses Credits' ;;
  }

  dimension: warehouse_name {
    type: string
    sql: ${TABLE}.WAREHOUSE_NAME ;;
    hidden: yes
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

  measure: warehouse_cost {
    type: number
    sql: ${credit_usage} * ${warehouse_cost_per_credit} ;;
    value_format_name: currency
    drill_fields: [query_details*]
  }

  measure: storage_cost {
    type: number
    sql: ${database_storage.storage_cost_per_hour} * count(distinct ${start_hour}) ;;
    value_format_name: currency
  }
}