- view: fact_enrollment
  sql_table_name: DW_GA.FACT_ENROLLMENT
  fields:

  - dimension: courseid
    type: string
    sql: ${TABLE}.COURSEID

  - dimension: daysbeforecourseend
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND

  - dimension: daysfromcoursestart
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART

  - dimension: dropped
    type: string
    sql: ${TABLE}.DROPPED

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension: enrollment
    type: string
    sql: ${TABLE}.ENROLLMENT

  - dimension: enrollmentstatusid
    type: string
    sql: ${TABLE}.ENROLLMENTSTATUSID

  - dimension: eventdatekey
    type: string
    sql: ${TABLE}.EVENTDATEKEY

  - dimension: filterflag
    type: string
    sql: ${TABLE}.FILTERFLAG

  - dimension: fullenrollment
    type: string
    sql: ${TABLE}.FULLENROLLMENT

  - dimension: graceperiod
    type: string
    sql: ${TABLE}.GRACEPERIOD

  - dimension: insitutionlocationid
    type: string
    sql: ${TABLE}.INSITUTIONLOCATIONID

  - dimension: institutionid
    type: string
    sql: ${TABLE}.INSTITUTIONID

  - dimension: partyid
    type: string
    sql: ${TABLE}.PARTYID

  - dimension: productid
    type: string
    sql: ${TABLE}.PRODUCTID

  - dimension: row_id
    type: string
    sql: ${TABLE}.ROW_ID

  - dimension: userid
    type: string
    sql: ${TABLE}.USERID

  - measure: count
    type: count
    drill_fields: []

