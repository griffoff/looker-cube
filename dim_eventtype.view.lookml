- view: dim_eventtype
  label: 'Learning Path Modifications'
  sql_table_name: DW_GA.DIM_EVENTTYPE
  fields:

  - dimension: eventtypeid
    type: string
    sql: ${TABLE}.EVENTTYPEID
    primary_key: true
    hidden: true

  - dimension: eventtypename
    label: 'Action'
    type: string
    sql: ${TABLE}.EVENTTYPENAME

