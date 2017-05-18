view: fact_activation_by_product {
  label: "Activations"
  derived_table: {
    sql: select
              by_product_fk as pk
              ,isbn13,is_lms_integrated,date_granularity,sum(product_activations) as product_activations
          from (
            select distinct by_product_fk,isbn13,is_lms_integrated,date_granularity,institutionid,product_activations
            from ${fact_activation_by_course.SQL_TABLE_NAME}
            )
          group by 1, 2, 3, 4
          order by 1;;
          sql_trigger_value: select count(*) from ${fact_activation_by_course.SQL_TABLE_NAME} ;;
  }

  set:  ALL_FIELDS {
    fields: [isbn13, is_lms_integrated, date_granularity, activations_for_isbn]
  }

  set:  details {
    fields: [isbn13, dim_product.productname, dim_institution.institutionname, is_lms_integrated, date_granularity, activations_for_isbn]
  }

  dimension: pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.pk ;;
  }

  dimension: isbn13 {
    hidden: yes
    type: string
    sql: ${TABLE}.isbn13 ;;
  }

  dimension: is_lms_integrated {
    label: "LMS Integrated"
    hidden: yes
    type: string
    sql: ${TABLE}.is_lms_integrated ;;
  }

  dimension: date_granularity {
    label: "Time period"
    hidden: yes
    type: string
    sql: ${TABLE}.date_granularity ;;
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
    sql_distinct_key: ${pk} ;;
    drill_fields: [details*]
  }

}

view: fact_activation_by_course {
  view_label: "Activations"
  derived_table: {
    sql:
    with c as (
      select
        c.courseid
        ,c.productid
        ,c.institutionid
        ,case when length(split_part(c.coursekey, '-', 1)) > 15 and array_size(split(c.coursekey, '-')) >= 2 and c.productplatformid= 26 then 'yes' else 'no' end as is_lms_integrated
        ,COALESCE(d.fiscalyearvalue, 'UNKNOWN') as date_granularity
      from dw_ga.dim_course c
      left join dw_ga.dim_date d on case when c.startdatekey = -1 then c.enddatekey else c.startdatekey end = d.datekey
      )
    select
        a.courseid
        ,p.isbn13
        ,c.date_granularity
        ,c.is_lms_integrated
        ,c.institutionid
        ,p.isbn13 || c.is_lms_integrated || c.date_granularity as by_product_fk
        --,p.isbn13 || c.institutionid || c.is_lms_integrated || c.date_granularity as by_product_fk
        ,sum(NOOFACTIVATIONS) as NOOFACTIVATIONS
        ,sum(sum(NOOFACTIVATIONS)) over (partition by p.isbn13, c.institutionid, c.is_lms_integrated, c.date_granularity) as product_activations
    from ZPG_ACTIVATIONS.DW_GA.FACT_ACTIVATION a
    inner join c on a.courseid = c.courseid
    inner join dw_ga.dim_product p on c.productid = p.productid
    group by 1, 2, 3, 4, 5
    order by 1;;
    sql_trigger_value: select count(*) from ZPG_ACTIVATIONS.DW_GA.FACT_ACTIVATION;;
  }

  set: ALL_FIELDS {
    fields: [courseid,avg_noofactivations,course_count,institution_count,noofactivations_base,total_noofactivations,institutionid]
  }

  set: course_detail {
    fields: [dim_start_date.calendarmonthname, dim_course.coursekey, dim_product.isbn13, total_noofactivations, fact_activation_by_product.activations_for_isbn]
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

  measure: avg_noofactivations {
    label: "Avg. activations"
    type: average
    hidden: yes
    sql: ${noofactivations_base} ;;
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
#     sql: ${fact_activation_by_product.activations_for_isbn} ;;
#     label: "Total activations for ISBN and Fiscal Year"
#     description: "The total number of activations for all courses for the ISBN started in the same fiscal year related to the current context
#     e.g.
#     at item level it will represent the no. of activations
#     on all courses with the same CORE TEXT ISBN and start fiscal year as the course where this item appears
#     "
#   }

  measure: activations_for_isbn {
    label: "Total activations for ISBN and Fiscal Year and Institution"
    description: "The total number of activations for all courses for the ISBN started in the same fiscal year related to the current context
    e.g.
    at item level it will represent the no. of activations
    on all courses with the same CORE TEXT ISBN and start fiscal year as the course where this item appears
    "
    type: sum_distinct
    sql: ${TABLE}.product_activations ;;
    sql_distinct_key: ${by_product_fk} || ${institutionid}  ;;
    drill_fields: [course_detail*]
  }
}
