view: fact_activation_by_course {
  view_label: "Activations"
  derived_table: {
    sql:
    with c as (
      select
        courseid
        ,productid
        ,institutionid
        ,startdatekey
        ,case when length(split_part(coursekey, '-', 1)) > 15 and array_size(split(coursekey, '-')) >= 2 and productplatformid= 26 then 'yes' else 'no' end as is_lms_integrated
      from dw_ga.dim_course
      )
    select
        a.courseid
        ,p.isbn13
        ,d.fiscalyearvalue as date_granularity
        ,c.is_lms_integrated
        ,c.institutionid
        ,sum(NOOFACTIVATIONS) as NOOFACTIVATIONS
        ,sum(sum(NOOFACTIVATIONS)) over (partition by p.isbn13, c.institutionid, c.is_lms_integrated, d.fiscalyearvalue) as product_activations
    from ZPG_ACTIVATIONS.DW_GA.FACT_ACTIVATION a
    inner join c on a.courseid = c.courseid
    inner join dw_ga.dim_product p on c.productid = p.productid
    inner join dw_ga.dim_date d on c.startdatekey = d.datekey
    group by 1, 2, 3, 4, 5
    order by 1;;
    sql_trigger_value: select count(*) from ZPG_ACTIVATIONS.dw_ga.fact_activation ;;
  }

  set: ALL_FIELDS {
    fields: [courseid,avg_noofactivations,course_count,institution_count,noofactivations_base,total_noofactivations,activations_for_isbn, isbn13, is_lms_integrated, date_granularity,institutionid]
  }

  set: course_detail {
    fields: [dim_start_date.calendarmonthname, dim_course.coursekey, dim_product.isbn13, is_lms_integrated, total_noofactivations, activations_for_isbn]
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

  dimension: isbn13 {
    hidden: yes
    type: string
    sql: ${TABLE}.isbn13 ;;
  }

  dimension: is_lms_integrated {
    hidden: yes
    type: string
    sql: ${TABLE}.is_lms_integrated ;;
  }

  dimension: date_granularity {
    hidden: yes
    type: string
    sql: ${TABLE}.date_granularity ;;
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
    drill_fields: [course_detail*]
  }

  measure: avg_noofactivations {
    label: "Avg. activations"
    type: average
    sql: ${noofactivations_base} ;;
  }

  measure: institution_count {
    label: "# Institutions with activations"
    type: count_distinct
    sql: case when ${TABLE}.NOOFACTIVATIONS > 0 then ${dim_institution.institutionid} end ;;
  }

  measure: course_count {
    label: "# Courses with activations"
    type: count_distinct
    sql: ${courseid} ;;
  }

  measure: activations_for_isbn {
    label: "Total activations for ISBN and Fiscal Year"
    description: "The total number of activations for all courses for the ISBN started in the same fiscal year related to the current context
    e.g.
    at item level it will represent the no. of activations
    on all courses with the same CORE TEXT ISBN and start fiscal year as the course where this item appears
    "
    type: sum_distinct
    sql: ${TABLE}.product_activations ;;
    sql_distinct_key: ${isbn13} || ${date_granularity} || ${institutionid} || ${is_lms_integrated}  ;;
    drill_fields: [course_detail*]
  }
}
