view: olr_courses {
  label: "Course / Section Details"
  sql_table_name: STG_CLTS.OLR_COURSES ;;
  set: curated_fields {fields:[course_key,course_name]}

  dimension_group: begin_date {
    label: "(OLR) Course Start"
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
    hidden:  yes
  }

  dimension: cnow_institution_id {
    type: string
    sql: ${TABLE}.CNOW_INSTITUTION_ID ;;
    hidden:  yes
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}."#CONTEXT_ID" ;;
    hidden:  yes
  }

  dimension: course_internal_flg {
    type: string
    sql: ${TABLE}.COURSE_INTERNAL_FLG ;;
    hidden: yes
  }

  dimension: course_key {
    label: "Course Key"
    primary_key: yes
    type: string
    sql: ${TABLE}.COURSE_KEY ;;
  }

  dimension: course_name {
    type: string
    sql: ${TABLE}.COURSE_NAME ;;
    hidden: yes
  }

  dimension: created_on {
    description: "Date on which the course was created"
    type: string
    sql: ${TABLE}.CREATED_ON ;;
  }

  dimension: el_contract_id {
    type: string
    sql: ${TABLE}.EL_CONTRACT_ID ;;
    hidden: yes
  }

  dimension: el_max_seats {
    type: string
    sql: ${TABLE}.EL_MAX_SEATS ;;
    hidden: yes
  }

  dimension: el_type {
    type: string
    sql: ${TABLE}.EL_TYPE ;;
    hidden:  yes
  }

  dimension_group: end_date {
    label: "Course End"
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
    sql: ${TABLE}.END_DATE ;;
  }

  dimension: enrollments {
    description: "Estimated enrollment figure.  These figures are input by LCs and have not been verified."
    type: string
    sql: ${TABLE}.ENROLLMENTS ;;
    hidden: yes
  }

  dimension: entity_id_sub {
    type: string
    sql: ${TABLE}.ENTITY_ID_SUB ;;
    hidden: yes
  }

  dimension: entity_name_course {
    description: "Institution name"
    type: string
    sql: ${TABLE}.ENTITY_NAME_COURSE ;;
  }

  dimension: entity_no {
    type: string
    sql: ${TABLE}.ENTITY_NO ;;
    hidden: yes
  }

  dimension: from_cgi {
    type: string
    sql: ${TABLE}.FROM_CGI ;;
    hidden: yes
  }

  dimension: instructor_guid {
    label: "Instructor GUID"
    description: "Instructor user ID.  ID may represent a coordinator based on how the course was set up."
    type: string
    sql: ${TABLE}.INSTRUCTOR_GUID ;;
  }

  dimension: instructor_name {
    description: "Instructor name may not always be available, and when available, may represent a coordinator based on how the course was set up."
    type: string
    sql: ${TABLE}.INSTRUCTOR_NAME ;;
  }

  dimension: isbn {
    label: "ISBN"
    description: "IAC ISBN associated with a given course/section."
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
    hidden:  yes
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
    hidden: yes
  }

  dimension: mag_acct_id {
    type: string
    sql: ${TABLE}.MAG_ACCT_ID ;;
    hidden: yes
  }

  dimension: product_skey {
    type: string
    sql: ${TABLE}.PRODUCT_SKEY ;;
    hidden: yes
  }

  dimension: product_type {
    description: "Product/platform (e.g. MTC = MindTap Classic)"
    type: string
    sql: ${TABLE}.PRODUCT_TYPE ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
    hidden: yes
  }

  dimension: secondary_instructor_guid {
    label: "Secondary Instructor GUID"
    description: "User ID of an additional instructor associated with a given course key.  If used, a department head likely is listed as the primary instructor
      as he/she set up a course for all professors."
    type: string
    sql: ${TABLE}.SECONDARY_INSTRUCTOR_GUID ;;
  }

  dimension: territory_id {
    description: "Internal Cengage territory code."
    type: string
    sql: ${TABLE}.TERRITORY_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [course_name, instructor_name]
    hidden: yes
  }
}
