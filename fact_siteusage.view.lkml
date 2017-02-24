view: fact_siteusage {
  label: "Web Usage"
  sql_table_name: DW_GA.FACT_SITEUSAGE ;;

  dimension: activityid {
    hidden: yes
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
  }

  measure: clickcount {
    type: average
    sql: ${TABLE}.CLICKCOUNT ;;
  }

  dimension: courseenddatekey {
    hidden: yes
    type: string
    sql: ${TABLE}.COURSEENDDATEKEY ;;
  }

  dimension: courseid {
    hidden: yes
    type: string
    sql: ${TABLE}.COURSEID ;;
  }

  dimension: coursestartdatekey {
    hidden: yes
    type: string
    sql: ${TABLE}.COURSESTARTDATEKEY ;;
  }

  dimension: daysbeforecourseend {
    hidden: yes
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
  }

  dimension: daysfromcoursestart {
    hidden: yes
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART ;;
  }

  dimension: deviceplatformid {
    hidden: yes
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID ;;
  }

  dimension_group: eventdate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.EVENTDATE ;;
  }

  dimension: eventdatekey {
    hidden: yes
    type: string
    sql: ${TABLE}.EVENTDATEKEY ;;
  }

  dimension: eventtypeid {
    hidden: yes
    type: string
    sql: ${TABLE}.EVENTTYPEID ;;
  }

  dimension: filterflag {
    hidden: yes
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
  }

  dimension: institutionid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
  }

  dimension: institutionlocationid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
  }

  dimension: learningpathid {
    hidden: yes
    type: string
    sql: ${TABLE}.LEARNINGPATHID ;;
  }

  dimension_group: loaddate {
    hidden: yes
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
  }

  dimension: locationid {
    hidden: yes
    type: string
    sql: ${TABLE}.LOCATIONID ;;
  }

  dimension: masternodeid {
    hidden: yes
    type: string
    sql: ${TABLE}.MASTERNODEID ;;
  }

  dimension: pagedomainid {
    hidden: yes
    type: string
    sql: ${TABLE}.PAGEDOMAINID ;;
  }

  dimension: pageinstanceid {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.PAGEINSTANCEID ;;
  }

  dimension: pageviewcount {
    type: number
    sql: ${TABLE}.PAGEVIEWCOUNT ;;
    hidden: yes
  }

  measure: pageviewcount_avg {
    label: "Page views (avg)"
    type: average
    sql: ${pageviewcount} ;;
  }

  measure: pageviewcount_sum {
    label: "Page views (total)"
    type: sum
    sql: ${pageviewcount} ;;
  }

  dimension: pageviewtime {
    type: number
    sql: ${TABLE}.PAGEVIEWTIME/60000.0 ;;
    hidden: yes
  }

  measure: pageviewtime_avg {
    label: "Page view time (avg)"
    type: average
    sql: ${pageviewtime} ;;
    value_format: "0.0 \m\i\n\s"
  }

  measure: pageviewtime_sum {
    label: "Page view time (total)"
    type: sum
    sql: ${pageviewtime}/60 ;;
    value_format: "0.0 \h\r\s"
  }

  dimension: partyid {
    hidden: yes
    type: string
    sql: ${TABLE}.PARTYID ;;
  }

  dimension: productid {
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCTID ;;
  }

  dimension: productplatformid {
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
  }

  dimension: timekey {
    hidden: yes
    type: string
    sql: ${TABLE}.TIMEKEY ;;
  }

  dimension: userid {
    hidden: yes
    type: string
    sql: ${TABLE}.USERID ;;
  }
}

#- measure: count
#  label: 'No. of page view records'
#  type: count
#  drill_fields: [location.locationid]
