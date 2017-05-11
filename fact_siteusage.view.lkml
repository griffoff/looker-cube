view: fact_siteusage {
  label: "Web Usage"
  sql_table_name: DW_GA.FACT_SITEUSAGE ;;

  dimension: pk {
    sql: ${TABLE}.pageinstanceid || ${TABLE}.userid || ${TABLE}.learningpathid || ${TABLE}.eventdate || ${TABLE}.daysfromcoursestart ;;
    hidden: yes
    primary_key: yes
  }

  dimension: activityid {
    hidden: yes
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
  }

  measure: clickcount_avg {
    label: "Clicks (avg)"
    type: average
    sql: ${TABLE}.CLICKCOUNT ;;
  }

  measure: clickcount {
    label: "Clicks (total)"
    type: sum
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
    sql: ${TABLE}.PAGEVIEWTIME/1000.0 ;;
    hidden: yes
  }

  measure: pageviewtime_avg {
    label: "Page view time (avg)"
    type: average
    sql: NULLIF(${pageviewtime}, 0)/86400.0 ;;
    value_format: "h:mm:ss"
  }

  measure: pageviewtime_sum {
    label: "Page view time (total)"
    type: sum
    sql: ${pageviewtime}/86400.0 ;;
    value_format: "hh:mm:ss"
  }

  measure: session_count {
    label: "No. of Sessions"
    type: count_distinct
    sql: ${TABLE}.sessionnumber ;;
    value_format: "#,##0"
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

  measure: percent_of_activations {
    label: "% of Activations"
    description: "
    No. of people / Total activations is this context
    i.e.
      no. of people who accessed vs no. of people who were exposed to this feature
    "
    type: number
    sql: COALESCE(${dim_party.count} / NULLIF(${fact_activation_by_course.total_noofactivations}, 0.0),0) ;;
    value_format_name: percent_1
    html:
      {% if value > 0.6 %}
      {% assign intensity = (value - 0.6)/(1 - 0.6) %}
      <div style="height: 100%;background-color: rgba(25,200,25,{{intensity}}); text-align:center; color:white">
      {% elsif value > 0.4 %}
      {% assign intensity = (value - 0.4)/(0.6 - 0.4) %}
      <div style="height: 100%;background-color: rgba(230,130,50,{{intensity}}); text-align:center; color:white">
      {% else %}
      {% assign intensity = 1 %}
      <div style="height: 100%;background-color: rgba(200,25,25,{{intensity}}); text-align:center; color:white">
      {% endif %}
      {{ rendered_value }} </div>
      ;;
      #add this to the end to see the intensity value for debugging
      #<div>{{intensity}}</div>
      # for the lower bound - waiting on a fix/response from looker as it generates an error
      #{% assign intensity = (0.4 - value) / 0.4 %}
  }
}

#- measure: count
#  label: 'No. of page view records'
#  type: count
#  drill_fields: [location.locationid]
