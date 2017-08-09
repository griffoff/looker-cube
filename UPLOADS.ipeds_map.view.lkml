view: ipeds_map {

  sql_table_name: UPLOADS.ZPG.IPEDS_MAP ;;

  dimension: city_nm {
    type: string
    sql: ${TABLE}.CITY_NM ;;
    hidden: yes
  }

  dimension: entity_no {
    type: string
    sql: ${TABLE}.ENTITY_NO::string ;;
    hidden: yes
  }

  dimension: institution_nm {
    type: string
    sql: ${TABLE}.INSTITUTION_NM ;;
    hidden: yes
  }

  dimension: ipeds_id {
    type: string
    sql: NULLIF(${TABLE}.IPEDS_ID, 'N/A') ;;
    hidden: yes
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.NOTES ;;
    hidden: yes
  }

  dimension: school_type {
    type: string
    sql: ${TABLE}.SCHOOL_TYPE ;;
    hidden: yes
  }

  dimension: st {
    type: string
    sql: ${TABLE}.ST ;;
    hidden: yes
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.ZIP ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
