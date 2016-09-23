- view: dim_filter
  label: 'Course Exclusions (filterflag)'

# # You can specify the table name if it's different from the view name:
#   sql_table_name: my_schema_name.dim_filter
#
#  fields:
# #     Define your dimensions and measures here, like this:
#     - dimension: id
#       type: number
#       sql: ${TABLE}.id
#
#     - dimension: created
#       type: time
#       timeframes: [date, week, month, year]
#       sql: ${TABLE}.created_at
#
#     - measure: count
#       type: count


  derived_table:
     sql: |
      select 0 as filterflag, 'Real Course' as filterdesc, 0 as filtersort
      union select 1, 'Identified as Test Data (1)', 1
      union select 2, 'Identified as Test Data (2)', 2
      union select 3, 'Identified as Test Data (3)', 3
      union select -1, 'Real Course', 0
      order by 3
      
  fields:
  - dimension: filterflag
    type: number
    sql: ${TABLE}.filterflag
    hidden: true
    primary_key: true
    
  - dimension: filtersort
    type: number
    sql: ${TABLE}.filtersort
    hidden: true
    
  - dimension: filterdesc
    label: 'Real or Test (filter flag)'
    type: string
    sql: ${TABLE}.filterdesc
    order_by_field: filtersort