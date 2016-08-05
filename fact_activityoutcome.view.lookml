- view: fact_activityoutcome
  sql_table_name: DW_GA.FACT_ACTIVITYOUTCOME
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.ID

  - dimension: activityid
    type: string
    sql: ${TABLE}.ACTIVITYID

  - dimension: attemptcompleted
    type: string
    sql: ${TABLE}.ATTEMPTCOMPLETED

  - dimension: autosubmitted
    type: string
    sql: ${TABLE}.AUTOSUBMITTED

  - dimension: completed
    type: string
    sql: ${TABLE}.COMPLETED

  - dimension: completeddatekey
    type: string
    sql: ${TABLE}.COMPLETEDDATEKEY

  - dimension: course_weight
    type: number
    sql: ${TABLE}.COURSE_WEIGHT

  - dimension: courseid
    type: string
    sql: ${TABLE}.COURSEID

  - dimension: daysbeforecourseend
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND

  - dimension: daysfromcoursestart
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART

  - dimension: daysleftbeforeduedate
    type: string
    sql: ${TABLE}.DAYSLEFTBEFOREDUEDATE

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension: filterflag
    type: string
    sql: ${TABLE}.FILTERFLAG

  - dimension: institutionid
    type: string
    sql: ${TABLE}.INSTITUTIONID

  - dimension: institutionlocationid
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID

  - dimension: latestflag
    type: string
    sql: ${TABLE}.LATESTFLAG

  - dimension: learningpathid
    type: string
    sql: ${TABLE}.LEARNINGPATHID

  - dimension_group: loaddate
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.LOADDATE

  - dimension: nooffails
    type: string
    sql: ${TABLE}.NOOFFAILS

  - dimension: noofpassess
    type: string
    sql: ${TABLE}.NOOFPASSESS

  - dimension: nooftakes
    type: string
    sql: ${TABLE}.NOOFTAKES

  - dimension: partyid
    type: string
    sql: ${TABLE}.PARTYID

  - dimension: points_earned
    type: number
    sql: ${TABLE}.POINTS_EARNED

  - dimension: points_possible
    type: number
    sql: ${TABLE}.POINTS_POSSIBLE

  - dimension: productid
    type: string
    sql: ${TABLE}.PRODUCTID

  - dimension: rowid
    type: string
    sql: ${TABLE}.ROWID

  - dimension: score
    type: number
    sql: ${TABLE}.SCORE

  - dimension: startdatekey
    type: string
    sql: ${TABLE}.STARTDATEKEY

  - dimension_group: takeendtime
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.TAKEENDTIME

  - dimension_group: takestarttime
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.TAKESTARTTIME

  - dimension: timeduration
    type: string
    sql: ${TABLE}.TIMEDURATION

  - dimension: timekey
    type: string
    sql: ${TABLE}.TIMEKEY

  - dimension: timespent
    type: string
    sql: ${TABLE}.TIMESPENT

  - dimension: user_weight
    type: number
    sql: ${TABLE}.USER_WEIGHT

  - dimension: userid
    type: string
    sql: ${TABLE}.USERID

  - measure: count
    type: count
    drill_fields: [id]

