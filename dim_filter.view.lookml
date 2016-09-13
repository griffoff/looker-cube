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
      select distinct filterflag
          ,case 
              when filterflag = 0 then 'Real Course' 
              else replace('Idenitified as Test data (#)', '#', filterflag)
             end as filterdesc
          ,case when filterflag = -1 then 99 else filterflag end as filtersort
      from dw_ga.fact_activation
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
    label: 'Filter type'
    type: string
    sql: ${TABLE}.filterdesc
    order_by_field: filtersort