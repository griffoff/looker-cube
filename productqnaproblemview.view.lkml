view: productqnaproblemview {
  sql_table_name: STG_APLIA.PRODUCTQNAPROBLEMVIEW ;;

  dimension: assignment_title {
    type: string
    sql: ${TABLE}.ASSIGNMENT_TITLE ;;
  }

  dimension: author {
    type: string
    sql: ${TABLE}.AUTHOR ;;
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}.CONTEXT_ID ;;
  }

  dimension: discipline_name {
    type: string
    sql: ${TABLE}.DISCIPLINE_NAME ;;
  }

  dimension: edition {
    type: string
    sql: ${TABLE}.EDITION ;;
  }

  dimension: isbn {
    type: string
    sql: ${TABLE}.ISBN ;;
  }

  dimension: load_txt {
    type: string
    sql: ${TABLE}.LOAD_TXT ;;
  }

  dimension: problem_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.PROBLEM_ID ;;
  }

  dimension: problem_title {
    type: string
    sql: ${TABLE}.PROBLEM_TITLE ;;
  }

  dimension: problem_version {
    type: string
    sql: ${TABLE}.PROBLEM_VERSION ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.PRODUCT_ID ;;
  }

  dimension: qnaversion {
    type: string
    sql: ${TABLE}.QNAVERSION ;;
  }

  dimension: subdiscipline_name {
    type: string
    sql: ${TABLE}.SUBDISCIPLINE_NAME ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.TITLE ;;
  }

  dimension: visibility {
    type: string
    sql: ${TABLE}.VISIBILITY ;;
  }

  measure: count {
    type: count
    drill_fields: [discipline_name, subdiscipline_name, problem.problem_id]
  }
  measure: problem_count {
    label: "# of problem IDs"
    type: count_distinct
    sql: ${TABLE}.PROBLEM_ID;;
  }
}
