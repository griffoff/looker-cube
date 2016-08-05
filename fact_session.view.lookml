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

  - dimension_group: loaddate
    hidden: true
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.LOADDATE

  - dimension: locationid
    hidden: true
    type: string
    sql: ${TABLE}.LOCATIONID

  - dimension: noofcourses
    type: number
    sql: ${TABLE}.NOOFCOURSES

  - measure: pageviewcount
    type: average
    sql: ${TABLE}.PAGEVIEWCOUNT

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

  - measure: sessionviewtime
    type: average
    sql: ${TABLE}.SESSIONVIEWTIME

  - dimension: timekey
    hidden: true
    type: string
    sql: ${TABLE}.TIMEKEY

  - dimension: userid
    hidden: true
    type: string
    sql: ${TABLE}.USERID

  - measure: count
    type: count
    drill_fields: [location.locationid]

