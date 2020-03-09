view: courseinstructor {
  label: "Course / Section Details"
#   sql_table_name: DW_GA.COURSEINSTRUCTOR ;;
  derived_table: {
    sql:
    with courseintr as (
        Select ci.*,p.guid
        from prod.dw_ga.courseinstructor ci
              left join  prod.dw_ga.dim_party p
              on ci.partyid = p.partyid
      )
      ,instr as (
          Select
                c.instructor_guid
                , c.olr_course_key
                ,c.course_start_date
                , c.is_new_customer
                ,c.is_returning_customer
                , e.email, ROW_NUMBER() OVER (PARTITION BY instructor_guid ORDER BY IFF(email is null, 0, 1), e._ldts DESC) = 1 as preferred
          from prod.cu_user_analysis.user_courses c
          left join prod.datavault.hub_user u on c.instructor_guid = u.uid
          left join prod.datavault.sat_user_pii e on u.hub_user_key = e.hub_user_key
                  and active
      )
      ,instr_pref AS (SELECT * FROM instr WHERE preferred)
      Select
        COALESCE(a.coursekey, b.olr_course_key) AS coursekey
        ,a.snapshot_id
        ,a.org_id
        ,a.partyid
        ,COALESCE(a.instructoremail, b.email) AS instructoremail
        ,COALESCE(a.ROLE, 'INSTRUCTOR') AS ROLE
        ,COALESCE(a.guid, b.instructor_guid) AS guid
        ,row_number() OVER (PARTITION BY guid ORDER BY b.course_start_date) = 1 AS first_course_section
        ,hash(coursekey, instructor_guid) as pk
      from courseintr a
      FULL join instr_pref b on b.instructor_guid = a.guid
                        and b.olr_course_key = a.coursekey
    ;;
#     sql:
#       with courseintr as (
#         Select ci.*,p.guid
#         from prod.dw_ga.courseinstructor ci
#               left join  prod.dw_ga.dim_party p
#               on ci.partyid = p.partyid
#       ),instr as (
#           Select c.instructor_guid, c.olr_course_key,c.course_start_date, c.is_new_customer,c.is_returning_customer, e.email, ROW_NUMBER() OVER (PARTITION BY instructor_guid ORDER BY IFF(email is null, 0, 1), e._ldts DESC) = 1 as preferred
#           from prod.cu_user_analysis.user_courses c
#           left join prod.datavault.hub_user u on c.instructor_guid = u.uid
#           left join prod.datavault.sat_user_pii e on u.hub_user_key = e.hub_user_key
#                   and active
#       )
#       Select
#         COALESCE(a.coursekey, b.olr_course_key) AS coursekey
#         ,a.snapshot_id
#         ,a.org_id
#         ,a.partyid
#         ,COALESCE(a.instructoremail, b.email) AS instructoremail
#         ,COALESCE(a.ROLE, 'INSTRUCTOR') AS ROLE
#         ,COALESCE(a.guid, b.instructor_guid) AS guid
#         ,row_number() OVER (PARTITION BY guid ORDER BY b.course_start_date) = 1 AS first_course_section
#         ,hash(coursekey, instructor_guid) as pk
#       from courseintr a
#       FULL join instr b on b.instructor_guid = a.guid
#                         and b.olr_course_key = a.coursekey
#                         and preferred
#   ;;
    persist_for: "24 hours"
  }

  set: marketing_fields {fields:[instructoremail,is_new_customer,is_returning_customer,instructor_guid]}

  dimension: pk {
    primary_key: yes
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

#   dimension: instructorid {
#     label: "Instructor ID"
#     type: string
#     sql: ${TABLE}.INSTRUCTORID ;;
#     hidden: yes
#   }

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
    description: "Instructor"
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
    description: "Instructor user ID.  ID may represent a coordinator based on how the course was set up."
    type: string
    sql: ${TABLE}."GUID" ;;
  }

  dimension: new_or_returning {
    type: string
    group_label: "Instructor"
    sql: CASE WHEN ${TABLE}.first_course_section THEN 'New to Cengage' ELSE 'Returning' END ;;
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

  measure: instructor_count {
    label: "# Instructors"
    description: "uique count of instructor guids"
    hidden: no
    type: count_distinct
    sql: ${instructor_guid} ;;
  }

  measure: count {
    label: "# Instructors on course"
    hidden: yes
    type: count
    drill_fields: []
  }
}
