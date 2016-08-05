- view: dim_eventtype
  sql_table_name: DW_GA.DIM_EVENTTYPE
  fields:

  - dimension: eventtypeid
    type: string
    sql: ${TABLE}.EVENTTYPEID

  - dimension: eventtypename
    type: string
    sql: ${TABLE}.EVENTTYPENAME

  - measure: count
    type: count
    drill_fields: [eventtypename]

