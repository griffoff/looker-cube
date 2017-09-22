view: fact_session {
  label: "Web Session"
  sql_table_name: DW_GA.FACT_SESSION ;;

  dimension: deviceplatformid {
    hidden: yes
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID ;;
  }

  dimension: dw_ldid {
    hidden: yes
    type: string
    sql: ${TABLE}.DW_LDID ;;
  }

  dimension_group: dw_ldts {
    hidden: yes
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
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

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
    hidden: yes
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
    type: number
    sql: ${TABLE}.LOCATIONID ;;
  }

  dimension: noofcourses {
    #X# Invalid LookML inside "dimension": {"type":null}
    sql: ${TABLE}.NOOFCOURSES ;;
    hidden: yes
  }

  dimension: pageviewcount {
    type: number
    sql: ${TABLE}.PAGEVIEWCOUNT ;;
    hidden: yes
  }

  measure: pageviewcount_avg {
    label: "Avg. pages per session"
    type: average
    sql: ${pageviewcount} ;;
    value_format: "0.0"
  }

  measure: pageviewcount_total {
    label: "Total page views"
    type: sum
    sql: ${pageviewcount} ;;
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

  dimension: sessionnumber {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.SESSIONNUMBER ;;
  }

  dimension: sessionviewtime {
    type: number
    sql: ${TABLE}.SESSIONVIEWTIME ;;
    hidden: yes
  }

  measure: sessionviewtime_avg {
    label: "Avg. session length"
    type: average
    sql: ${sessionviewtime}/1000/84000 ;;
    value_format_name: duration_hms
  }

  measure: sessionviewtime_total {
    label: "Total session time"
    type: sum
    #sql: ${sessionviewtime}/3600000.0 ;;
    sql: ${sessionviewtime}/1000.0/84000 ;;
    value_format_name: duration_hms
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

  measure: count {
    label: "No. of sessions"
    type: count
    drill_fields: [sessionnumber, dim_product.hed_discipline]
  }
}