- view: fact_enrollment
  label: 'Enrollments'
  sql_table_name: DW_GA.FACT_ENROLLMENT
  fields:

  - dimension: courseid
    type: string
    sql: ${TABLE}.COURSEID
    hidden: true
  
  - dimension: daysbeforecourseend
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND
    hidden: true

  - dimension: daysfromcoursestart
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART
    hidden: true

  - measure: dropped
    type: sum
    sql: ${TABLE}.DROPPED

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true
    
  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true

  - measure: enrollment
    type: sum
    sql: ${TABLE}.ENROLLMENT

  - dimension: enrollmentstatusid
    type: string
    sql: ${TABLE}.ENROLLMENTSTATUSID
    hidden: true

  - dimension: eventdatekey
    type: string
    sql: ${TABLE}.EVENTDATEKEY
    hidden: true

  - dimension: filterflag
    type: string
    sql: ${TABLE}.FILTERFLAG
    hidden: true

  - measure: fullenrollment
    label: 'Full Enrollment'
    type: sum
    sql: ${TABLE}.FULLENROLLMENT

  - measure: graceperiod
    type: sum
    sql: ${TABLE}.GRACEPERIOD

  - dimension: insitutionlocationid
    type: string
    sql: ${TABLE}.INSITUTIONLOCATIONID
    hidden: true
    
  - dimension: institutionid
    type: string
    sql: ${TABLE}.INSTITUTIONID
    hidden: true

  - dimension: partyid
    type: string
    sql: ${TABLE}.PARTYID
    hidden: true

  - dimension: productid
    type: string
    sql: ${TABLE}.PRODUCTID
    hidden: true

  - dimension: row_id
    type: string
    sql: ${TABLE}.ROW_ID
    hidden: true

  - dimension: userid
    type: string
    sql: ${TABLE}.USERID
    hidden: true

  - measure: enrollment_count
    type: count
    drill_fields: []

