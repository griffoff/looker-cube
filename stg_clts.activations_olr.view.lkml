view: activations_olr {
  sql_table_name: STG_CLTS.ACTIVATIONS_OLR ;;

  set: activation_details {
    fields: [actv_entity_name, actv_code, actv_dt_date, user_guid, actv_user_type, actv_region, platform]
  }

  dimension: actv_code {
    type: string
    sql: ${TABLE}.ACTV_CODE ;;
    primary_key: yes
  }

  dimension: actv_count {
    label: "Activation count"
    type: number
    sql: ${TABLE}.ACTV_COUNT ;;
  }

  dimension: actv_counter_base {
    label: "Activation count"
    type: string #number
    sql: case when ${TABLE}.ACTV_COUNT > 0 then ${actv_code} || ${actv_dt_date} || ${user_guid} end;;
    hidden: yes
  }
# In order to pass validation commented the dimension
#  dimension:  is_hed {
#    label: "Is HED"
#    type: yesno
#    sql:  case when ${magellan_hed_entities.entity_no} is not null then True else False end ;;
#  }

  measure: actv_counter {
    label: "Distinct activations"
    type: count_distinct
    sql: ${actv_counter_base} ;;
    drill_fields: [activation_details*]
  }

  measure: actv_code_count {
    label: "Distinct activation codes"
    type: count_distinct
    sql: ${actv_code} ;;
    drill_fields: [activation_details*]
  }

  measure: m_actv_count {
    label: "Activation count"
    type: sum
    sql: ${actv_count} ;;
    drill_fields: [activation_details*]
  }

  dimension_group: actv_dt {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      day_of_month,
      month_num
    ]
    convert_tz: no
    sql: ${TABLE}.ACTV_DT ;;
  }

  dimension: actv_datekey  {
    type: number
    sql: ${actv_dt_year}*10000 + ${actv_dt_month_num}*100 + ${actv_dt_day_of_month} ;;
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

  dimension: actv_trial_purchase {
    type: string
    sql: ${TABLE}.ACTV_TRIAL_PURCHASE ;;
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

  dimension: isbn13 {
    type: string
    sql: ${TABLE}.ISBN13 ;;
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
    label: "Record count"
    type: count
  }
}
