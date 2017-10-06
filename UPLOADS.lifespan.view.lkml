view: lifespan {
  sql_table_name: UPLOADS.ZPG.LIFESPAN ;;

  measure: _2017_digital {
    type: sum_distinct
    sql: ${TABLE}._2017_DIGITAL ;;
  }

  dimension: pk {
      sql: ${entity_no} || ${prod_family_cd} ;;
      hidden: yes
      primary_key: yes
  }

  dimension: entity_no {
    type: number
    sql: ${TABLE}.ENTITY_NO ;;
    hidden: yes
  }

  dimension: institution_nm {
    type: string
    sql: ${TABLE}.INSTITUTION_NM ;;
    hidden: yes
  }

  dimension: prod_family_cd {
    type: string
    sql: ${TABLE}.PROD_FAMILY_CD ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
