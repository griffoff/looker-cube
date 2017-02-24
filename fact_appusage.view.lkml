view: fact_appusage {
  label: "App Dock"
  sql_table_name: DW_GA.FACT_APPUSAGE ;;

  dimension: activityid {
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
    hidden: yes
  }

  measure: clickcount {
    label: "# of Clicks"
    type: sum
    sql: ${TABLE}.CLICKCOUNT ;;
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: deviceplatformid {
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID ;;
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

  dimension: eventdatekey {
    type: string
    sql: ${TABLE}.EVENTDATEKEY ;;
    hidden: yes
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
  }

  dimension: iframeapplicationid {
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID ;;
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

  dimension: locationid {
    type: string
    hidden: yes
    sql: ${TABLE}.LOCATIONID ;;
  }

  dimension: pageinstanceid {
    type: string
    sql: ${TABLE}.PAGEINSTANCEID ;;
    hidden: yes
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden: yes
  }

  dimension: timekey {
    type: string
    sql: ${TABLE}.TIMEKEY ;;
    hidden: yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  measure: user_count {
    label: "# of Users"
    type: count_distinct
    sql: ${userid} ;;
  }

  measure: count {
    type: count
    drill_fields: [location.locationid]
  }
}
