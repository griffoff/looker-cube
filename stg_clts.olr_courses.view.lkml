view: olr_courses {
  label: "Courses"
  sql_table_name: STG_CLTS.OLR_COURSES ;;

  dimension_group: begin_date {
    label: "Course Start"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.BEGIN_DATE ;;
  }

  dimension: cgi {
    type: string
    sql: ${TABLE}.CGI ;;
  }

  dimension: cnow_institution_id {
    type: string
    sql: ${TABLE}.CNOW_INSTITUTION_ID ;;
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}."#CONTEXT_ID" ;;
  }

  dimension: course_internal_flg {
    type: string
    sql: ${TABLE}.COURSE_INTERNAL_FLG ;;
  }

  dimension: course_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.COURSE_KEY ;;
  }

  dimension: course_name {
    type: string
    sql: ${TABLE}.COURSE_NAME ;;
  }

  dimension: created_on {
    type: string
    sql: ${TABLE}.CREATED_ON ;;
  }

  dimension: el_contract_id {
    type: string
    sql: ${TABLE}.EL_CONTRACT_ID ;;
  }

  dimension: el_max_seats {
    type: string
    sql: ${TABLE}.EL_MAX_SEATS ;;
  }

  dimension: el_type {
    type: string
    sql: ${TABLE}.EL_TYPE ;;
  }

  dimension: end_date {
    type: string
    sql: ${TABLE}.END_DATE ;;
  }

  dimension: enrollments {
    type: string
    sql: ${TABLE}.ENROLLMENTS ;;
  }

  dimension: entity_id_sub {
    type: string
    sql: ${TABLE}.ENTITY_ID_SUB ;;
  }

  dimension: entity_name_course {
    type: string
    sql: ${TABLE}.ENTITY_NAME_COURSE ;;
  }

  dimension: entity_no {
    type: string
    sql: ${TABLE}.ENTITY_NO ;;
  }

  dimension: from_cgi {
    type: string
    sql: ${TABLE}.FROM_CGI ;;
  }

  dimension: instructor_guid {
    type: string
    sql: ${TABLE}.INSTRUCTOR_GUID ;;
  }

  dimension: instructor_name {
    type: string
    sql: ${TABLE}.INSTRUCTOR_NAME ;;
  }

  dimension: isbn {
    type: string
    sql: ${TABLE}.ISBN ;;
  }

  dimension: last_updated_on {
    type: string
    sql: ${TABLE}.LAST_UPDATED_ON ;;
  }

  dimension: ldap_instr_contact_id {
    type: string
    sql: ${TABLE}.LDAP_INSTR_CONTACT_ID ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: mag_acct_id {
    type: string
    sql: ${TABLE}.MAG_ACCT_ID ;;
  }

  dimension: product_skey {
    type: string
    sql: ${TABLE}.PRODUCT_SKEY ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.PRODUCT_TYPE ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: secondary_instructor_guid {
    type: string
    sql: ${TABLE}.SECONDARY_INSTRUCTOR_GUID ;;
  }

  dimension: territory_id {
    type: string
    sql: ${TABLE}.TERRITORY_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [course_name, instructor_name]
  }
}
