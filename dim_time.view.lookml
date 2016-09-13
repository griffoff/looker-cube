- view: dim_time
  label: 'Time'
  sql_table_name: DW_GA.DIM_TIME
  fields:

  - dimension: ampm
    type: string
    sql: ${TABLE}.AMPM

  - dimension: hour
    type: number
    sql: ${TABLE}.HOUR
    order_by_field: hour24

  - dimension: hour24
    type: number
    sql: ${TABLE}.HOUR24

  - dimension: minute
    type: number
    sql: ${TABLE}.MINUTE

  - dimension: time
    type: time
    timeframes: [hour_of_day, minute, raw]
    sql: ${TABLE}.TIME
    hidden: true

  - dimension: timekey
    type: string
    sql: ${TABLE}.TIMEKEY
    hidden: true
    primary_key: true

  #- measure: count
  #  type: count
  #  drill_fields: []

