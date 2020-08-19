view: datavault_test_report {
  derived_table: {
    sql: SELECT * FROM "QA_TESTREPORTS"."DATAVAULT_STATUS"
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: execution_time {
    type: time
    sql: ${TABLE}."EXECUTION_TIME" ;;
  }

  dimension: enviroment {
    type: string
    sql: ${TABLE}."ENVIROMENT" ;;
  }

  dimension: test_name {
    type: string
    sql: ${TABLE}."TEST_NAME" ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}."SOURCE" ;;
  }

  dimension: test_table {
    type: string
    sql: ${TABLE}."TEST_TABLE" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  set: detail {
    fields: [
      execution_time_time,
      enviroment,
      test_name,
      source,
      test_table,
      status
    ]
  }
}
