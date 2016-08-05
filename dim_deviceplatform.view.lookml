- view: dim_deviceplatform
  sql_table_name: DW_GA.DIM_DEVICEPLATFORM
  fields:

  - dimension: devicebrowsergroup
    type: string
    sql: ${TABLE}.DEVICEBROWSERGROUP

  - dimension: devicebrowsername
    type: string
    sql: ${TABLE}.DEVICEBROWSERNAME

  - dimension: devicebrowserversion
    type: string
    sql: ${TABLE}.DEVICEBROWSERVERSION

  - dimension: devicecategory
    type: string
    sql: ${TABLE}.DEVICECATEGORY

  - dimension: deviceplatformgroup
    type: string
    sql: ${TABLE}.DEVICEPLATFORMGROUP

  - dimension: deviceplatformid
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID

  - dimension: deviceplatformname
    type: string
    sql: ${TABLE}.DEVICEPLATFORMNAME

  - dimension: devicesystemname
    type: string
    sql: ${TABLE}.DEVICESYSTEMNAME

  - dimension: devicesystemtype
    type: string
    sql: ${TABLE}.DEVICESYSTEMTYPE

  - dimension: deviceuseragent
    type: string
    sql: ${TABLE}.DEVICEUSERAGENT

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension_group: loaddate
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.LOADDATE

  - measure: count
    type: count
    drill_fields: [devicebrowsername, deviceplatformname, devicesystemname]

