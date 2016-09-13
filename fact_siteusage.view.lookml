- view: fact_siteusage
  label: 'Web Usage'
  sql_table_name: DW_GA.FACT_SITEUSAGE
  fields:

  - dimension: activityid
    hidden: true
    type: string
    sql: ${TABLE}.ACTIVITYID

  - measure: clickcount
    type: average
    sql: ${TABLE}.CLICKCOUNT

  - dimension: courseenddatekey
    hidden: true
    type: string
    sql: ${TABLE}.COURSEENDDATEKEY

  - dimension: courseid
    hidden: true
    type: string
    sql: ${TABLE}.COURSEID

  - dimension: coursestartdatekey
    hidden: true
    type: string
    sql: ${TABLE}.COURSESTARTDATEKEY

  - dimension: daysbeforecourseend
    hidden: true
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND

  - dimension: daysfromcoursestart
    hidden: true
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART

  - dimension: deviceplatformid
    hidden: true
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID

  - dimension_group: eventdate
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.EVENTDATE

  - dimension: eventdatekey
    hidden: true
    type: string
    sql: ${TABLE}.EVENTDATEKEY

  - dimension: eventtypeid
    hidden: true
    type: string
    sql: ${TABLE}.EVENTTYPEID

  - dimension: filterflag
    hidden: true
    type: string
    sql: ${TABLE}.FILTERFLAG

  - dimension: institutionid
    hidden: true
    type: string
    sql: ${TABLE}.INSTITUTIONID

  - dimension: institutionlocationid
    hidden: true
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID

  - dimension: learningpathid
    hidden: true
    type: string
    sql: ${TABLE}.LEARNINGPATHID

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

  - dimension: masternodeid
    hidden: true
    type: string
    sql: ${TABLE}.MASTERNODEID

  - dimension: pagedomainid
    hidden: true
    type: string
    sql: ${TABLE}.PAGEDOMAINID

  - dimension: pageinstanceid
    hidden: true
    primary_key: true
    type: string
    sql: ${TABLE}.PAGEINSTANCEID

  - measure: pageviewcount
    type: average
    sql: ${TABLE}.PAGEVIEWCOUNT

  - measure: pageviewtime
    type: average
    sql: ${TABLE}.PAGEVIEWTIME

  - dimension: partyid
    hidden: true
    type: string
    sql: ${TABLE}.PARTYID

  - dimension: productid
    hidden: true
    type: string
    sql: ${TABLE}.PRODUCTID

  - dimension: productplatformid
    hidden: true
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID

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

