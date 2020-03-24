view: product_facts {
  label: "Activations"
  derived_table: {
    sql:
          select by_product_fk
                --,productfamily
                --,edition
                --,is_lms_integrated
                --,date_granularity
                --,institutionid
                ,sum(noofactivations) as product_activations
                ,count(case when noofactivations > 0 then 1 end) as activated_courses
                ,sum(users) as product_users
          from ${course_section_facts.SQL_TABLE_NAME}
          group by 1
          order by 1;;
    sql_trigger_value: select count(*) from ${course_section_facts.SQL_TABLE_NAME} ;;
  }

  set:  ALL_FIELDS {
    fields: [by_product_fk, activations_for_isbn, product_users]
  }

  set:  details {
    fields: [dim_product.product_family, dim_product.productname, dim_institution.institutionname, activations_for_isbn, product_users]
  }

  dimension: by_product_fk {
    primary_key: yes
    type: string
    hidden: yes
  }

#   dimension: productfamily {
#     hidden: yes
#     type: string
#   }
#
#   dimension: edition {
#     hidden: yes
#     type: string
#   }
#
#   dimension: is_lms_integrated {
#     label: "LMS Integrated"
#     hidden: yes
#     type: string
#     sql: ${TABLE}.is_lms_integrated ;;
#   }
#
#   dimension: date_granularity {
#     label: "Time period"
#     hidden: yes
#     type: string
#     sql: ${TABLE}.date_granularity ;;
#   }

  measure: activations_for_isbn {
    label: "# Product Activations"
    description: "Total paid activations for Product Family + Edition combination for a given Fiscal Year and whether it is LMS integrated.
    Measure represents all activations for all courses of 'this product'. 'This product' means all courses that share the same combination of (1) Product Family, (2) Edition, (3) Fiscal Year and (4) LMS status.
    Measure is to be used as a denominator when normalizing data as a Percent of Activations."
    type: sum_distinct
    sql: ${TABLE}.product_activations ;;
    #sql_distinct_key: ${by_product_fk} ;;
    drill_fields: [details*]
  }

  measure: activated_courses_for_isbn {
    label: "# Product Activations - Number of Courses"
    description: "Distinct count of courses with activations in 'this product'. 'This product' means all courses that share the same combination of (1) Product Family, (2) Edition, (3) Fiscal Year and (4) LMS status."
    type: sum_distinct
    sql: ${TABLE}.activated_courses ;;
    #sql_distinct_key: ${by_product_fk} ;;
    drill_fields: [details*]
  }

  measure: product_users {
    label: "# Product Users"
    description: "Total Users with at least 1 login for Product Family + Edition combination for a given Fiscal Year and whether it is LMS integrated.
    Measure represents all users for all courses of 'this product'. 'This product' means all courses that share the same combination of (1) Product Family, (2) Edition, (3) Fiscal Year and (4) LMS status.
    Measure is to be used as a denominator when normalizing data as a Percent of Users."
    type: sum_distinct
    sql: ${TABLE}.product_users ;;
    #sql_distinct_key: ${by_product_fk} ;;
    drill_fields: [details*]
  }

}
