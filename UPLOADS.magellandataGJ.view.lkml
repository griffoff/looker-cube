view: magellanhigeredpipgj {
  view_label: "Gaurav Magellan Upload"
  sql_table_name: uploads.ZSH.MAGELLANDataGJ ;;

  dimension: pk {
    type: string
    sql: ${entity_number} || ${isbn_13} ;;
    primary_key: yes
    hidden: yes
  }

  dimension: account {
    type: string
    sql: ${TABLE}.ACCOUNT ;;
  }

  dimension: cengage_course {
    type: string
    sql: ${TABLE}.CENGAGE_COURSE ;;
  }

  dimension: course_fee {
    type: string
    sql: ${TABLE}.COURSE_FEE ;;
  }

  dimension: course_id {
    type: string
    sql: ${TABLE}.COURSE_ID ;;
  }

  dimension: discipline {
    type: string
    sql: ${TABLE}.DISCIPLINE ;;
  }

  dimension: institution_course {
    type: string
    sql: ${TABLE}.INSTITUTION_COURSE ;;
  }

  dimension: isbn_13 {
    type: string
    sql: ${TABLE}.ISBN_13::string ;;
  }

  dimension: opty_id {
    type: number
    sql: ${TABLE}.OPTY_ID ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.REVENUE ;;
  }

  dimension: stage {
    type: string
    sql: ${TABLE}.STAGE ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: tech_required {
    type: string
    sql: ${TABLE}.TECH_REQUIRED ;;
  }

  dimension: technology {
    type: string
    sql: ${TABLE}.TECHNOLOGY ;;
  }

  dimension: term {
    type: string
    sql: ${TABLE}.TERM ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.TITLE ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  dimension: units {
    type: number
    sql: ${TABLE}.UNITS ;;
  }
  dimension: entity_number{
    type: string
    sql: ${TABLE}.ENTITY_NUMBER::string ;;
    }

  measure: weighted_revenue {
    type: sum
    sql: ${TABLE}.WEIGHTED_REVENUE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
