- view: dim_activationtype
  sql_table_name: DW_GA.DIM_ACTIVATIONTYPE
  fields:

  - dimension: activationtypeid
    type: string
    sql: ${TABLE}.ACTIVATIONTYPEID

  - dimension: activationtypename
    type: string
    sql: ${TABLE}.ACTIVATIONTYPENAME

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - measure: count
    type: count
    drill_fields: [activationtypename]

