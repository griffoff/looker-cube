- view: fact_appusage
  label: 'App Dock'
  sql_table_name: DW_GA.FACT_APPUSAGE
  fields:

  - dimension: activityid
    type: string
    sql: ${TABLE}.ACTIVITYID
    hidden: true

  - measure: clickcount
    label: '# of Clicks'
    type: sum
    sql: ${TABLE}.CLICKCOUNT

  - dimension: courseid
    type: string
    sql: ${TABLE}.COURSEID
    hidden: true

  - dimension: deviceplatformid
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID
    hidden: true

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true

  - dimension: eventdatekey
    type: string
    sql: ${TABLE}.EVENTDATEKEY
    hidden: true
    
  - dimension: filterflag
    type: string
    sql: ${TABLE}.FILTERFLAG

  - dimension: iframeapplicationid
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID
    hidden: true

  - dimension: learningpathid
    type: string
    sql: ${TABLE}.LEARNINGPATHID
    hidden: true

  - dimension_group: loaddate
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.LOADDATE
    hidden: true
    
  - dimension: locationid
    type: string
    hidden: true
    sql: ${TABLE}.LOCATIONID

  - dimension: pageinstanceid
    type: string
    sql: ${TABLE}.PAGEINSTANCEID
    hidden: true
    
  - dimension: partyid
    type: string
    sql: ${TABLE}.PARTYID
    hidden: true

  - dimension: productid
    type: string
    sql: ${TABLE}.PRODUCTID
    hidden: true

  - dimension: productplatformid
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID
    hidden: true

  - dimension: timekey
    type: string
    sql: ${TABLE}.TIMEKEY
    hidden: true

  - dimension: userid
    type: string
    sql: ${TABLE}.USERID
    hidden: true
    
  - measure: user_count
    label: '# of Users'
    type: count_distinct
    sql: ${userid}

  - measure: count
    type: count
    drill_fields: [location.locationid]

