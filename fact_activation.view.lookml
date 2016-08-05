- view: fact_activation
  sql_table_name: DW_GA.FACT_ACTIVATION
  fields:

  - dimension: activationcode
    type: string
    sql: ${TABLE}.ACTIVATIONCODE
    primary_key: true

  - dimension: activationdatekey
    hidden: true
    type: string
    sql: ${TABLE}.ACTIVATIONDATEKEY

  - dimension: activationtypeid
    hidden: true
    type: string
    sql: ${TABLE}.ACTIVATIONTYPEID

  - dimension: courseid
    hidden: true
    type: string
    sql: ${TABLE}.COURSEID

  - dimension: daysbeforecourseend
    hidden: true
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND

  - dimension: daysfromcoursestart
    hidden: true
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART

  - dimension: dw_ldid
    hidden: true
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension: filterflag
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

  - dimension_group: loaddate
    hidden: true
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.LOADDATE

  - measure: noofactivations_base
    type: number
    sql: ${TABLE}.NOOFACTIVATIONS

  - measure: total_noofactivations
    type: sum
    sql: ${noofactivations_base}

  - measure: avg_noofactivations
    type: average
    sql: ${noofactivations_base}
    
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

  - dimension: userid
    hidden: true
    type: string
    sql: ${TABLE}.USERID

  - measure: count
    type: count
    drill_fields: []

