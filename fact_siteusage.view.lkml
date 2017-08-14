view: paid_users {
derived_table: {
  sql:
    select distinct courseid, userid
    from dw_ga.fact_activation;;
  sql_trigger_value: select count(*) from dw_ga.fact_activation ;;
  }

  dimension: courseid {hidden:yes}
  dimension: userid {hidden:yes}
  dimension: paid {
    type: yesno
    sql: ${userid} is not null;;
  }

  dimension: paidcategory {
    label: "Paid (Paid/Unpaid)"
    type: string
    sql: case when ${userid} is not null then 'Paid' else 'Unpaid' end;;
  }
}

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
    timeframes: [time, hour, minute, date, week, month]
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
    sql: CASE
              WHEN ${TABLE}.PAGEVIEWTIME>=1000
                THEN ${TABLE}.PAGEVIEWTIME /1000.0/86400.0
              ELSE NULL
              END;;
    hidden: yes
  }

  measure: pageviewtime_max {
    label: "Browser time (max)"
    type: max
    sql: ${pageviewtime};;
    value_format: "hh:mm:ss"
  }

  measure: pageviewtime_avg {
    label: "Browser time (avg)"
    type: average
    sql: ${pageviewtime};;
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

  measure: pageviewtime_sum_hours {
    label: "Browser time (total hours)"
    description: "Total browser time in hours"
    type: sum
    hidden:  no
    sql: ${pageviewtime}*24 ;;
# Note: I changed this measure by removing the format and making it represent the # of hours. Because the measure produces a number, there was trouble with converting it to a value format associated with type: time. -CM
  }

  measure: session_count {
    label: "# Sessions"
    type: count_distinct
    sql: ${TABLE}.sessionnumber ;;
    value_format: "#,##0"
    hidden: no
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

  measure: usercount {
    label: "# Users"
    type: count_distinct
    sql: ${partyid} ;;
    hidden: no
    drill_fields: [dim_product.productfamily, dim_institution.institutionname, dim_learningpath.lowest_level, usercount]
  }

  measure: percent_of_activations {
    label: "% of Activations (used / exposed)"
    description: "
    No. of people / Total activations in this context
    i.e.
      no. of people who accessed vs no. of people who were exposed to this feature
    "
    type: number
    sql: COALESCE(${usercount} / NULLIF(${course_section_facts.total_noofactivations}, 0.0),0) ;;
    value_format_name: percent_1
    html:
      <div style="width:100%;">
        <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
      </div>
    ;;
  }

  measure: percent_of_all_activations {
    label: "% of Activations (used / all activations)"
    description: "
    No. of people who accessed vs. all activations/user possible whether they where exposed or whether the activity/item was hidden in their learning path"
    type:  number
    sql: COALESCE(${usercount} / NULLIF(${product_facts.activations_for_isbn}, 0.0),0) ;;
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
