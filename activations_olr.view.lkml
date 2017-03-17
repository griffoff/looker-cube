view: activations_olr {
  sql_table_name: STG_CLTS.ACTIVATIONS_OLR ;;

  dimension: actv_code {
    type: string
    sql: ${TABLE}.ACTV_CODE ;;
  }

  measure: actv_code_count {
    label: "distinct activation codes"
    type: count_distinct
    sql: ${actv_code} ;;
  }

  measure: actv_count {
    type: sum
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

  dimension: actv_olr_id {
    type: string
    sql: ${TABLE}.ACTV_OLR_ID ;;
  }

  dimension: actv_region {
    type: string
    sql: ${TABLE}.ACTV_REGION ;;
  }

  dimension: actv_user_type {
    type: string
    sql: ${TABLE}.ACTV_USER_TYPE ;;
  }

  dimension: code_source {
    type: string
    sql: ${TABLE}.CODE_SOURCE ;;
  }

  dimension: code_type {
    type: string
    sql: ${TABLE}.CODE_TYPE ;;
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}.CONTEXT_ID ;;
  }

  dimension: entity_no {
    type: string
    sql: ${TABLE}.ENTITY_NO ;;
  }

  dimension: in_actv_flg {
    type: string
    sql: ${TABLE}.IN_ACTV_FLG ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: mag_acct_id {
    type: string
    sql: ${TABLE}.MAG_ACCT_ID ;;
  }

  dimension: pac_isbn {
    type: string
    sql: ${TABLE}.PAC_ISBN ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.PLATFORM ;;
  }

  dimension: product_skey {
    type: string
    sql: ${TABLE}.PRODUCT_SKEY ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.SOURCE ;;
  }

  dimension: territory_id {
    type: string
    sql: ${TABLE}.TERRITORY_ID ;;
  }

  dimension: territory_skey {
    type: string
    sql: ${TABLE}.TERRITORY_SKEY ;;
  }

  dimension: user_guid {
    type: string
    sql: ${TABLE}.USER_GUID ;;
  }

  measure: count {
    type: count
    drill_fields: [actv_entity_name, actv_code, actv_dt_date]
  }
}
