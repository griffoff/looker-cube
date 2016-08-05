- view: dim_productplatform
  label: 'Product Platform'
  sql_table_name: DW_GA.DIM_PRODUCTPLATFORM
  fields:

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true
    
  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true
    
  - dimension: is_platform
    type: string
    sql: ${TABLE}.IS_PLATFORM
    hidden: true
    
  - dimension: productplatform
    label: 'Platfom name'
    type: string
    sql: ${TABLE}.PRODUCTPLATFORM
    
  - dimension: productplatformid
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID
    hidden: true
    primary_key: true
    
  - measure: count
    type: count
    drill_fields: []

