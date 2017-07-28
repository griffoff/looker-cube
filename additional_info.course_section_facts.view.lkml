view: course_section_facts {
  view_label: "Activations"
  derived_table: {
    sql:
    with c as (
      select
        c.courseid
        ,c.productid
        ,c.institutionid
        ,i.HED
        ,case when length(split_part(c.coursekey, '-', 1)) > 15 and array_size(split(c.coursekey, '-')) >= 2 and c.productplatformid= 26 then 'yes' else 'no' end as is_lms_integrated
        ,COALESCE(d.fiscalyearvalue, 'UNKNOWN') as date_granularity
      from dw_ga.dim_course c
      --left join dw_ga.dim_date d on case when c.startdatekey = -1 then c.enddatekey else c.startdatekey end = d.datekey
      left join dw_ga.dim_date d on c.startdatekey = d.datekey
      left join ${dim_institution.SQL_TABLE_NAME} i on c.institutionid = i.institutionid
      )
    ,i as (
      select course.courseid, min(instructor.instructor_first_date) as instructor_first_date, min(instructor.instructor_first_date_key) as instructor_first_date_key
      from
      (SELECT b.userid as instructorid
            , min(datevalue) as instructor_first_date
            , min(a.startdatekey) as instructor_first_date_key
            FROM dw_ga.dim_course  a
            JOIN dw_ga.coursetoinstructor b
            ON a.courseid = b.courseid
            JOIN dw_ga.dim_date d
            on a.startdatekey = d.datekey
            group by 1) instructor
      join dw_ga.coursetoinstructor map
      on instructor.instructorid = map.userid
      join dw_ga.dim_course course
      on map.courseid = course.courseid
      group by 1
    )
    ,u as (
      select courseid, count(distinct userid) as users
      from dw_ga.fact_session
      group by 1
    )
    ,a as (
      select
          a.courseid
          ,p.productfamily
          ,p.edition
          ,c.date_granularity
          ,c.is_lms_integrated
          ,c.institutionid
          ,c.HED
          ,p.productfamily || p.edition || c.is_lms_integrated || c.HED || c.date_granularity as by_product_fk
          ,sum(NOOFACTIVATIONS) as NOOFACTIVATIONS
          --,sum(sum(NOOFACTIVATIONS)) over (partition by p.productfamily, p.edition, c.institutionid, c.is_lms_integrated, c.date_granularity) as product_activations
          --,sum(count(distinct a.courseid)) over (partition by p.productfamily, p.edition, c.is_lms_integrated, c.date_granularity) as activated_courses
      from ZPG_ACTIVATIONS.DW_GA.FACT_ACTIVATION a
      inner join c on a.courseid = c.courseid
      inner join dw_ga.dim_product p on c.productid = p.productid
    group by 1, 2, 3, 4, 5, 6, 7
    )
    select distinct
      a.*
      ,greatest(ifnull(u.users, 0), ifnull(a.NOOFACTIVATIONS, 0)) as users
      ,i.instructor_first_date
      ,i.instructor_first_date_key
    from a
    left join i on a.courseid = i.courseid
    left join u on a.courseid = u.courseid
    order by 1;;

    sql_trigger_value: select count(*) from ZPG_ACTIVATIONS.DW_GA.FACT_ACTIVATION;;
  }

  set: ALL_FIELDS {
    fields: [courseid,course_count,institution_count,noofactivations_base,total_noofactivations,institutionid,instructor_first_date, instructor_first_date_key, instructor_is_new, noofusers_base, total_users]
  }

  set: course_detail {
    fields: [dim_start_date.calendarmonthname, dim_course.coursekey, dim_product.isbn13, total_noofactivations, product_facts.activations_for_isbn, total_users]
  }

  dimension: courseid {
    hidden: yes
    type: string
    primary_key: yes
    sql: ${TABLE}.COURSEID ;;
  }

  dimension: institutionid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
  }

  dimension: by_product_fk {
    hidden: yes
    sql:  ${TABLE}.by_product_fk ;;
  }

  dimension: instructor_first_date {
    view_label: "Course / Section Details"
    label: "Instructor's first course start date"
    type: date
    hidden: yes
    sql: ${TABLE}.INSTRUCTOR_FIRST_DATE ;;
  }

  dimension: instructor_first_date_key {
    view_label: "Course / Section Details"
    type: number
    sql: ${TABLE}.INSTRUCTOR_FIRST_DATE_key ;;
    hidden: yes
  }

  dimension: instructor_is_new {
    view_label: "Course / Section Details"
    label: "Instructor is new?"
    type: yesno
    sql: ${instructor_first_date_key} = ${dim_course.startdatekey} ;;
  }

  dimension: noofactivations_base {
    type: number
    sql: ${TABLE}.NOOFACTIVATIONS ;;
    hidden: yes
  }

  measure: total_noofactivations {
    label: "Total activations"
    description: "
    The total number of activations for courses in this context
    e.g.
    at item level it will represent the no. of activations
    on courses where this item appears
    "
    type: sum_distinct
    sql: ${noofactivations_base} ;;
    sql_distinct_key: ${courseid} ;;
    drill_fields: [course_detail*]
  }

  dimension: noofusers_base {
    label: "# Users Accessed"
    description: "Number of people who have registered any web activity on the course, regardless of amount of use, or activation status"
    sql: ${TABLE}.users ;;
    hidden: yes
  }

  measure: total_users {
    label: "Total # Users"
    description: "
    The total number of users who have logged in at least once for courses in this context, regardless of activation status
    e.g.
    at item level it will represent the no. of users who have registered some activity
    on courses where this item appears
    "
    type: sum_distinct
    sql: ${noofusers_base} ;;
    sql_distinct_key: ${courseid} ;;
    drill_fields: [course_detail*]
  }


  measure: institution_count {
    label: "# Institutions with activations"
    type: count_distinct
    sql: case when ${TABLE}.NOOFACTIVATIONS > 0 then ${dim_institution.institutionid} end ;;
  }

  measure: course_count {
    label: "# Course sections with activations"
    type: count_distinct
    sql: ${courseid} ;;
  }

#   measure: activations_for_isbn {
#     hidden: yes
#     type: number
#     sql: ${product_facts.activations_for_isbn} ;;
#     label: "Total activations for ISBN and Fiscal Year"
#     description: "The total number of activations for all courses for the ISBN started in the same fiscal year related to the current context
#     e.g.
#     at item level it will represent the no. of activations
#     on all courses with the same CORE TEXT ISBN and start fiscal year as the course where this item appears
#     "
#   }

}