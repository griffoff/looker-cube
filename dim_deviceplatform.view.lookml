- view: dim_deviceplatform
  label: 'Device/Platform'
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
    label: 'Device platform'
    group_label: 'Device'
    type: string
    sql: ${TABLE}.DEVICEPLATFORMNAME

  - dimension: devicesystemname
    label: 'Device system'
    group_label: 'Device'
    type: string
    sql: ${TABLE}.DEVICESYSTEMNAME

  - dimension: devicesystemtype
    label: 'Device system type'
    group_label: 'Device'
    type: string
    sql: ${TABLE}.DEVICESYSTEMTYPE

  - dimension: deviceuseragent
    label: 'Device user agent'
    group_label: 'Device'
    type: string
    sql: ${TABLE}.DEVICEUSERAGENT

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true

  - dimension_group: loaddate
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.LOADDATE
    hidden: true

  - measure: count
    label: 'No. of different device/platforms'
    type: count
    drill_fields: [devicebrowsername, deviceplatformname, devicesystemname]

