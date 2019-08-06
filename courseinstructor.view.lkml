view: courseinstructor {
  label: "Course / Section Details"
#   sql_table_name: DW_GA.COURSEINSTRUCTOR ;;
  derived_table: {
    sql:  with courseintr as (
  Select ci.*,p.guid from prod.dw_ga.courseinstructor ci
        left join  prod.dw_ga.dim_party p
        on ci.partyid = p.partyid
  ),instr as (
    Select distinct instructor_guid, olr_course_key,is_new_customer,is_returning_customer
    from prod.cu_user_analysis.user_courses
  )
    Select * from courseintr a
        left join instr b
    on b.instructor_guid = a.guid and b.olr_course_key = a.coursekey;;
    persist_for: "24 hours"
  }

  set: marketing_fields {fields:[instructoremail,is_new_customer,is_returning_customer,instructor_guid]}

  dimension: pk {
    primary_key: yes
    sql: hash(${coursekey}, ${instructor_guid}) ;;
    hidden: yes
  }

  dimension: coursekey {
    label: "Course Key"
    type: string
    sql: ${TABLE}.COURSEKEY ;;
    hidden: yes
  }

  dimension: instructoremail {
    group_label: "Instructor"
    label: "Instructor Email"
    description: " Please use this Email ID to identify the instructor linked to a course. We do not have an instructor name field yet"
    type: string
    sql: ${TABLE}.INSTRUCTOREMAIL ;;
  }

  dimension: instructorid {
    label: "Instructor ID"
    type: string
    sql: ${TABLE}.INSTRUCTORID ;;
    hidden: yes
  }

  dimension: org_id {
    label: "Org ID"
    type: string
    sql: ${TABLE}.ORG_ID ;;
    hidden: yes
  }

  dimension: partyid {
    label: "Party ID"
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  dimension: role {
    group_label: "Instructor"
    label: "Instructor Role"
    type: string
    sql: ${TABLE}.ROLE ;;
  }

  dimension: snapshot_id {
    label: "Snapshot ID"
    type: string
    sql: ${TABLE}.SNAPSHOT_ID ;;
    hidden: yes
  }

  dimension: instructor_guid {
    group_label: "Instructor"
    type: string
    sql: ${TABLE}."INSTRUCTOR_GUID" ;;
  }

  dimension: is_new_customer {
    group_label: "Instructor"
    label: "Is New Instructor"
    type: string
    sql:  ${TABLE}."IS_NEW_CUSTOMER" ;;
  }

  dimension: is_returning_customer {
    group_label: "Instructor"
    label: "Is Returning Instructor"
    type: string
    sql:  ${TABLE}."IS_RETURNING_CUSTOMER" ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
