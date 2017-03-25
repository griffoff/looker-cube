view: fact_activityoutcome {
  label: "Activity Outcomes"
  sql_table_name: DW_GA.FACT_ACTIVITYOUTCOME ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
    hidden: yes
  }

  dimension: activityid {
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
    hidden: yes
  }

  dimension: attemptcompleted {
    type: string
    sql: ${TABLE}.ATTEMPTCOMPLETED ;;
    hidden: yes
  }

  dimension: autosubmitted {
    label: "Auto submitted"
    type: string
    sql: ${TABLE}.AUTOSUBMITTED ;;
  }

  dimension: completed {
    type: string
    sql: ${TABLE}.COMPLETED ;;
  }

  dimension: completeddatekey {
    type: string
    sql: ${TABLE}.COMPLETEDDATEKEY ;;
    hidden: yes
  }

  dimension: course_weight {
    type: number
    sql: ${TABLE}.COURSE_WEIGHT ;;
    hidden: yes
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: daysbeforecourseend {
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
    hidden: yes
  }

  dimension: daysfromcoursestart {
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART ;;
    hidden: yes
  }

  dimension: daysleftbeforeduedate {
    type: string
    sql: ${TABLE}.DAYSLEFTBEFOREDUEDATE ;;
    hidden: yes
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension_group: dw_ldts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
    hidden: yes
  }

  dimension: institutionid {
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
    hidden: yes
  }

  dimension: institutionlocationid {
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
    hidden: yes
  }

  dimension: latestflag {
    type: string
    sql: ${TABLE}.LATESTFLAG ;;
    hidden: yes
  }

  dimension: learningpathid {
    type: string
    sql: ${TABLE}.LEARNINGPATHID ;;
    hidden: yes
  }

  dimension_group: loaddate {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  measure: nooffails {
    label: "Total no. of fails"
    type: sum
    sql: ${TABLE}.NOOFFAILS ;;
    hidden: yes
  }

  measure: noofpasses {
    label: "Total no. of passes"
    type: sum
    sql: ${TABLE}.NOOFPASSESS ;;
    hidden: yes
  }

  measure: passpercent {
    label: "Pass percentage"
    type: number
    sql: ${noofpasses} / NULLIF(NVL(${noofpasses}, 0) + NVL(${nooffails}, 0), 0) ;;
    value_format: "0.0\%"
    hidden: yes
  }

  dimension: nooftakes_bucket {
    label: "No. of Takes Buckets"
    type: tier
    tiers: [1, 2, 3, 5, 10]
    style: integer
    sql: ${TABLE}.NOOFTAKES ;;
  }

  measure: nooftakes_avg {
    label: "Avg. no. of Takes"
    type: average
    sql: ${TABLE}.nooftakes::float ;;
  }

  measure: nooftakes_sum {
    label: "# of Takes"
    type: sum
    sql: ${TABLE}.nooftakes::int ;;
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  measure: points_earned {
    type: number
    sql: ${TABLE}.POINTS_EARNED ;;
    hidden: yes
  }

  measure: points_possible {
    type: number
    sql: ${TABLE}.POINTS_POSSIBLE ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: rowid {
    type: string
    sql: ${TABLE}.ROWID ;;
    hidden: yes
  }

  dimension: score {
    type: number
    sql: case when ${TABLE}.SCORE > 200 then 200 when ${TABLE}.SCORE <0 then null else ${TABLE}.SCORE end ;;
    hidden: yes
  }

  measure: score_avg {
    label: "Score (avg)"
    type: average
    sql: ${score} ;;
    value_format: "0.0\%"
  }

  measure: score_dev {
    label: "Score (std dev)"
    type: number
    sql: STDDEV(${score}) ;;
    value_format: "0.0\%"
  }

  measure: score_max {
    label: "Score (max)"
    type: max
    sql: ${score} ;;
    value_format: "0.0\%"
  }

  measure: score_min {
    label: "Score (min)"
    type: min
    sql: ${score} ;;
    value_format: "0.0\%"
  }

  dimension: startdatekey {
    type: string
    sql: ${TABLE}.STARTDATEKEY ;;
    hidden: yes
  }

  dimension_group: takeendtime {
    label: "Take End Time"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.TAKEENDTIME ;;
  }

  dimension: takestartdate {
    label: "Take Start Time"
    type: date
    sql: ${TABLE}.TAKESTARTTIME::date ;;
    hidden: yes
  }

  dimension_group: takestarttime {
    label: "Take Start Time"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.TAKESTARTTIME ;;
  }

  dimension: timeduration {
    type: number
    sql: COALESCE(NULLIF(${TABLE}.TIMEDURATION, 0), ${TABLE}.TIMESPENT) /1000.0 ;;
    hidden: yes
  }

  measure: timeduration_avg {
    label: "Avg. Duration (hrs)"
    type: average
    sql: ${timeduration}/3600.0 ;;
    value_format: "#,##0.0 \h\r\s"
  }

  dimension: timeduration_bucket {
    label: "Duration Buckets"
    type: tier
    tiers: [0, 5, 15, 30, 60]
    style: relational
    sql: ${TABLE}.TIMEDURATION/60000.0 ;;
    value_format: "0 \m\i\n\s"
  }

  dimension: timekey {
    type: string
    sql: ${TABLE}.TIMEKEY ;;
    hidden: yes
  }

  dimension: timespent {
    type: number
    sql: ${TABLE}.TIMESPENT ;;
    hidden: yes
  }

  dimension: user_weight {
    label: "Weight"
    type: number
    sql: ${TABLE}.USER_WEIGHT ;;
    hidden: yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id]
    hidden: yes
  }
}
