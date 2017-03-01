view: activations_olr_v {
  sql_table_name: STG_CLTS.ACTIVATIONS_OLR_V ;;

  dimension: actv_code {
    type: string
    sql: ${TABLE}.ACTV_CODE ;;
  }

  dimension: actv_count {
    type: string
    sql: ${TABLE}.ACTV_COUNT ;;
  }

  dimension_group: actv_dt {
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
    sql: ${TABLE}.ACTV_DT ;;
  }

  dimension: actv_entity_id {
    type: string
    sql: ${TABLE}.ACTV_ENTITY_ID ;;
  }

  dimension: actv_entity_name {
    type: string
    sql: ${TABLE}.ACTV_ENTITY_NAME ;;
  }

  dimension: actv_isbn {
    type: string
    sql: ${TABLE}.ACTV_ISBN ;;
  }

  dimension: actv_region {
    type: string
    sql: ${TABLE}.ACTV_REGION ;;
  }

  dimension: actv_user_type {
    type: string
    sql: ${TABLE}.ACTV_USER_TYPE ;;
  }

  dimension: code_type {
    type: string
    sql: ${TABLE}.CODE_TYPE ;;
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}.CONTEXT_ID ;;
  }

  dimension: pac_isbn {
    type: string
    sql: ${TABLE}.PAC_ISBN ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.PLATFORM ;;
  }

  dimension: user_guid {
    type: string
    sql: ${TABLE}.USER_GUID ;;
  }

  measure: count {
    type: count
    drill_fields: [actv_entity_name]
  }
}
