view: entities {
  label: "Entities"
  sql_table_name: STG_CLTS.ENTITIES ;;

  dimension: city_nm {
    type: string
    sql: ${TABLE}.CITY_NM ;;
  }

  dimension: country_cd {
    type: string
    sql: ${TABLE}.COUNTRY_CD ;;
  }

  dimension: country_de {
    type: string
    sql: ${TABLE}.COUNTRY_DE ;;
  }

  dimension: county_nm {
    type: string
    sql: ${TABLE}.COUNTY_NM ;;
  }

  dimension: cust_no {
    type: string
    sql: ${TABLE}.CUST_NO ;;
  }

  dimension: district_nm {
    type: string
    sql: ${TABLE}.DISTRICT_NM ;;
  }

  dimension: enrollment_no {
    type: string
    sql: ${TABLE}.ENROLLMENT_NO ;;
  }

  dimension: entity_no {
    primary_key: yes
    type: string
    sql: ${TABLE}.ENTITY_NO ;;
  }

  dimension: entity_status {
    type: string
    sql: ${TABLE}.ENTITY_STATUS ;;
  }

  dimension: entity_status_dt {
    type: string
    sql: ${TABLE}.ENTITY_STATUS_DT ;;
  }

  dimension: est_enrollment {
    type: string
    sql: ${TABLE}.EST_ENROLLMENT ;;
  }

  dimension: institution_nm {
    type: string
    sql: ${TABLE}.INSTITUTION_NM ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: mdr_no {
    type: string
    sql: ${TABLE}.MDR_NO ;;
  }

  dimension: mdr_pop_served {
    type: string
    sql: ${TABLE}.MDR_POP_SERVED ;;
  }

  dimension: mkt_seg_maj_cd {
    type: string
    sql: ${TABLE}.MKT_SEG_MAJ_CD ;;
  }

  dimension: mkt_seg_maj_de {
    type: string
    sql: ${TABLE}.MKT_SEG_MAJ_DE ;;
  }

  dimension: mkt_seg_min_cd {
    type: string
    sql: ${TABLE}.MKT_SEG_MIN_CD ;;
  }

  dimension: mkt_seg_min_de {
    type: string
    sql: ${TABLE}.MKT_SEG_MIN_DE ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.POSTAL_CODE ;;
  }

  dimension: previous_id {
    type: string
    sql: ${TABLE}.PREVIOUS_ID ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: state_cd {
    type: string
    sql: ${TABLE}.STATE_CD ;;
  }

  dimension: state_de {
    type: string
    sql: ${TABLE}.STATE_DE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
