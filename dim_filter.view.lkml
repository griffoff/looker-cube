view: dim_filter {
  label: "Course / Section Details"

  derived_table: {
    sql:
      SELECT
        "#CONTEXT_ID" AS course_key
        , COALESCE(TRY_CAST(course_internal_flg AS BOOLEAN), FALSE)
          OR UPPER(entity_name_course) IN ('NGLSYNC TEST SCHOOL', 'TEST')
          OR entity_name_course ilike 'CENGAGE%'
          OR entity_name_course ilike 'SOUTHWESTERN PUBL%'
        AS is_internal
      FROM prod.stg_clts.olr_courses
    ;;
    sql_trigger_value: SELECT COUNT(*) FROM prod.stg_clts.olr_courses;;
  }

  dimension: course_key {hidden: yes}

  dimension: is_internal {
    label: "Internal Course"
    type: yesno
    hidden: yes
  }

  dimension: is_external {
    view_label: "** RECOMMENDED FILTERS **"
    label: "Real Course"
    description: "Flag to identify real courses, rather than test/demo/internal"
    type: yesno
    sql: NOT ${is_internal};;
  }

#   # # You can specify the table name if it's different from the view name:
#   #   sql_table_name: my_schema_name.dim_filter
#   #
#   #  fields:
#   # #     Define your dimensions and measures here, like this:
#   #     - dimension: id
#   #       type: number
#   #       sql: ${TABLE}.id
#   #
#   #     - dimension: created
#   #       type: time
#   #       timeframes: [date, week, month, year]
#   #       sql: ${TABLE}.created_at
#   #
#   #     - measure: count
#   #       type: count
#   set: ALL_FIELDS {
#     fields: [filterflag,filtersort,filterdesc,is_external]
#   }
#
#   derived_table: {
#     sql: select 0 as filterflag, 'Real Course' as filterdesc, 0 as filtersort
#       union select 1, 'Identified as Test Data (1)', 1
#       union select 2, 'Identified as Test Data (2)', 2
#       union select 3, 'Identified as Test Data (3)', 3
#       union select -1, 'Real Course', 0
#       order by 3
#        ;;
#       persist_for: "24 hours"
#   }
#
#   dimension: filterflag {
#     type: number
#     sql: ${TABLE}.filterflag ;;
#     hidden: yes
#     primary_key: yes
#   }
#
#   dimension: filtersort {
#     type: number
#     sql: ${TABLE}.filtersort ;;
#     hidden: yes
#   }
#
#   dimension: filterdesc {
#     label: "Real or Test (filter flag)"
#     type: string
#     hidden: yes
#     sql: ${TABLE}.filterdesc ;;
#     order_by_field: filtersort
#   }
#
#   dimension: is_internal {
#     label: "Internal Course"
#     type: yesno
#     hidden: yes
#     sql: ${TABLE}.filterflag not in (0, -1) ;;
#   }
#
#   dimension: is_external {
#     view_label: "** RECOMMENDED FILTERS **"
#     label: "Real Course"
#     description: "Flag to identify real courses, rather than test/demo/internal"
#     type: yesno
#     sql: ${TABLE}.filterflag in (0, -1) ;;
#   }

}
