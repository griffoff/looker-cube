- view: dim_pagedomain
  label: 'Product Platform'
  sql_table_name: DW_GA.DIM_PAGEDOMAIN
  fields:

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true

  - dimension: dw_ldts
    type: string
    sql: ${TABLE}.DW_LDTS
    hidden: true
    
  - dimension: environment
    type: string
    sql: ${TABLE}.ENVIRONMENT
    
  - dimension: loaddate
    type: string
    sql: ${TABLE}.LOADDATE
    hidden: true
    
  - dimension: pagedomain
    label: 'Page Domain'
    type: string
    sql: ${TABLE}.PAGEDOMAIN
    
  
  - dimension: pagedomainid
    type: string
    sql: ${TABLE}.PAGEDOMAINID
    hidden: true
    primary_key: true
  
  - dimension: productplatformid
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID
    hidden: true
    
  - measure: count
    label: 'No. of product domains'
    type: count
    drill_fields: []

