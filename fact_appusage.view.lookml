- view: fact_appusage
  sql_table_name: DW_GA.FACT_APPUSAGE
  fields:

  - dimension: activityid
    type: string
    sql: ${TABLE}.ACTIVITYID

  - dimension: clickcount
    type: string
    sql: ${TABLE}.CLICKCOUNT

  - dimension: courseid
    type: string
    sql: ${TABLE}.COURSEID

  - dimension: deviceplatformid
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension: eventdatekey
    type: string
    sql: ${TABLE}.EVENTDATEKEY

  - dimension: filterflag
    type: string
    sql: ${TABLE}.FILTERFLAG

  - dimension: iframeapplicationid
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID

  - dimension: learningpathid
    type: string
    sql: ${TABLE}.LEARNINGPATHID

  - dimension_group: loaddate
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.LOADDATE

  - dimension: locationid
    type: string
    # hidden: true
    sql: ${TABLE}.LOCATIONID

  - dimension: pageinstanceid
    type: string
    sql: ${TABLE}.PAGEINSTANCEID

  - dimension: partyid
    type: string
    sql: ${TABLE}.PARTYID

  - dimension: productid
    type: string
    sql: ${TABLE}.PRODUCTID

  - dimension: productplatformid
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID

  - dimension: timekey
    type: string
    sql: ${TABLE}.TIMEKEY

  - dimension: userid
    type: string
    sql: ${TABLE}.USERID

  - measure: count
    type: count
    drill_fields: [location.locationid]

