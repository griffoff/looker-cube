view: fact_siteusage {
  label: "Learning Path - Usage Data"
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
    html:
    <div style="width:100%;">
      <div title="max: {{clickcount_avg_max._rendered_value}}" style="width: {{clickcount_avg_percent._rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">
        {{rendered_value}}
      </div>
    </div>;;
  }

  measure: clickcount_max {
    label: "Clicks (max)"
    type: number
    sql: max(${clickcount} ) over ();;
  }

  measure: clickcount_avg_max {
    label: "Clicks (avg) (max)"
    type: number
    sql: max(${clickcount_avg} ) over ();;
    hidden: yes
  }

  measure: clickcount_total_max {
    label: "Clicks (max) (max)"
    type: number
    sql: max(${clickcount}) over ();;
    hidden: yes
  }

  measure: clickcount_avg_percent {
    type: number
    sql: ${clickcount_avg_max}/${clickcount_avg_max} ;;
    value_format_name: percent_1
    hidden:  yes
  }

  measure: clickcount_percent {
    type: number
    sql: ${clickcount}/${clickcount_max} ;;
    value_format_name: percent_1
    hidden:  yes
  }

  measure: clickcount {
    label: "Clicks (total)"
    type: sum
    sql: ${TABLE}.CLICKCOUNT ;;
    html:
    <div style="width:100%;">
      <div title="max: {{clickcount_max._rendered_value}}" style="width: {{clickcount_percent._rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">
        {{rendered_value}}
      </div>
    </div>;;
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
    label: "Views (avg)"
    type: average
    sql: ${pageviewcount} ;;
  }

  measure: pageviewcount_sum {
    label: "Views (total)"
    type: sum
    sql: ${pageviewcount} ;;
  }

  dimension: pageviewtime {
    type: number
    sql: ${TABLE}.PAGEVIEWTIME/1000.0/86400.0 ;;
    hidden: yes
  }

  measure: pageviewtime_max {
    label: "Browser time (max)"
    type: number
    sql: max(${pageviewtime_avg}) over () ;;
    value_format: "hh:mm:ss"
  }

  measure: pageviewtime_avg {
    label: "Browser time (avg)"
    type: average
    sql: NULLIF(${pageviewtime}, 0) ;;
    value_format: "h:mm:ss"
    html:
    <div style="width:100%;">
      <div title="max: {{pageviewtime_max._rendered_value}}" style="width: {{pageviewtime_percent._rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">
        {{rendered_value}}
      </div>
    </div>;;
  }

  measure: pageviewtime_percent {
    type: number
    sql: ${pageviewtime_avg}/${pageviewtime_max} ;;
    value_format_name: percent_1
    hidden:  yes
  }

  measure: pageviewtime_sum {
    label: "Browser time (total)"
    type: sum
    sql: ${pageviewtime} ;;
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
      <div style="width:100%;">
        <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
      </div>
    ;;
  }
}

#- measure: count
#  label: 'No. of page view records'
#  type: count
#  drill_fields: [location.locationid]
