- view: fact_session
  label: 'Web Session'
  sql_table_name: DW_GA.FACT_SESSION
  fields:

  - dimension: deviceplatformid
    hidden: true
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID

  - dimension: dw_ldid
    hidden: true
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension_group: eventdate
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.EVENTDATE

  - dimension: eventdatekey
    hidden: true
    type: string
    sql: ${TABLE}.EVENTDATEKEY

  - dimension: filterflag
    type: string
    sql: ${TABLE}.FILTERFLAG
    hidden: true

  - dimension_group: loaddate
    hidden: true
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.LOADDATE

  - dimension: locationid
    hidden: true
    type: number
    sql: ${TABLE}.LOCATIONID

  - dimension: noofcourses
    type: 
    sql: ${TABLE}.NOOFCOURSES
    hidden: true
    
  - dimension: pageviewcount
    type: number
    sql: ${TABLE}.PAGEVIEWCOUNT
    hidden: true
    
  - measure: pageviewcount_avg
    label: 'Avg. pages per session'
    type: average
    sql: ${pageviewcount}
    value_format: '0.0'
    
  - measure: pageviewcount_total
    label: 'Total page views'
    type: sum
    sql: ${pageviewcount}
    
  - dimension: productid
    hidden: true
    type: string
    sql: ${TABLE}.PRODUCTID

  - dimension: productplatformid
    hidden: true
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID

  - dimension: sessionnumber
    hidden: true
    primary_key: true
    type: string
    sql: ${TABLE}.SESSIONNUMBER

  - dimension: sessionviewtime
    type: number
    sql: ${TABLE}.SESSIONVIEWTIME
    hidden: true
    
  - measure: sessionviewtime_avg
    label: 'Avg. session length (mins)'
    type: average
    sql: ${sessionviewtime}/60000.0
    value_format: '0.0 \m\i\n\s'
    
  - measure: sessionviewtime_total
    label: 'Total session time (hrs)'
    type: average
    sql: ${sessionviewtime}/3600000.0
    value_format: '0.0 \h\r\s'

  - dimension: timekey
    hidden: true
    type: string
    sql: ${TABLE}.TIMEKEY

  - dimension: userid
    hidden: true
    type: string
    sql: ${TABLE}.USERID

  - measure: count
    label: 'No. of sessions'
    type: count
    drill_fields: [sessionnumber, dim_product.hed_discipline]

