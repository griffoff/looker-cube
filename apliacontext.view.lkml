view: apliacontext {
  sql_table_name: STG_APLIA.APLIACONTEXT ;;

  dimension: context_id {
    type: string
    sql: ${TABLE}.CONTEXT_ID ;;
  }

  dimension: deleted {
    type: string
    sql: ${TABLE}.DELETED ;;
  }

  dimension: deleted_date {
    type: string
    sql: ${TABLE}.DELETED_DATE ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: guid {
    type: string
    sql: ${TABLE}.GUID ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: reg_key {
    type: string
    sql: ${TABLE}.REG_KEY ;;
  }

  dimension: update_content_yn {
    type: string
    sql: ${TABLE}.UPDATE_CONTENT_YN ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
