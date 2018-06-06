view: json_testreports_v {
  sql_table_name: QA_TESTREPORTS.JSON_TESTREPORTS_V ;;

  dimension: duration {
    type: number
    sql: ${TABLE}.DURATION ;;
  }

  dimension: error_message {
    type: string
    sql: ${TABLE}.ERROR_MESSAGE ;;
  }

  dimension: exec_id {
    type: string
    sql: ${TABLE}.EXEC_ID ;;
  }

  dimension: feature_file {
    type: string
    sql: ${TABLE}.FEATURE_FILE ;;
  }

  dimension: feature_file_status {
    type: string
    sql: ${TABLE}.FEATURE_FILE_STATUS ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.KEYWORD ;;
  }

  dimension: load_date {
    type: string
    sql: ${TABLE}.LOAD_DATE ;;
  }

  dimension: scenario_name {
    type: string
    sql: ${TABLE}.SCENARIO_NAME ;;
  }

  dimension: scenario_status {
    type: string
    sql: ${TABLE}.SCENARIO_STATUS ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: step {
    type: string
    sql: ${TABLE}.STEP ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.TAGS ;;
  }

  measure: count_of_exec_key{
    type: count
    label: "Count of exec key"
    sql_distinct_key: ${TABLE}.EXEC_ID  ;;
    drill_fields: [scenario_name]
  }
}
