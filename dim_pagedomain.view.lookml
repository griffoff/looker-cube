- view: dim_pagedomain
  sql_table_name: DW_GA.DIM_PAGEDOMAIN
  fields:

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension: dw_ldts
    type: string
    sql: ${TABLE}.DW_LDTS

  - dimension: environment
    type: string
    sql: ${TABLE}.ENVIRONMENT

  - dimension: loaddate
    type: string
    sql: ${TABLE}.LOADDATE

  - dimension: pagedomain
    type: string
    sql: ${TABLE}.PAGEDOMAIN

  - dimension: pagedomainid
    type: string
    sql: ${TABLE}.PAGEDOMAINID

  - dimension: productplatformid
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID

  - measure: count
    type: count
    drill_fields: []

