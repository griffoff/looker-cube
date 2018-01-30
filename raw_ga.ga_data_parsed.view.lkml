view: ga_data_parsed {
  sql_table_name: RAW_GA.GA_DATA_PARSED ;;

  dimension: ga_data_parsed_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.GA_DATA_PARSED_ID ;;
  }

  dimension: activityrefid {
    type: string
    sql: ${TABLE}.ACTIVITYREFID ;;
  }

  dimension: activityuri {
    type: string
    sql: ${TABLE}.ACTIVITYURI ;;
  }

  dimension: cendocid {
    type: string
    sql: ${TABLE}.CENDOCID ;;
  }

  dimension: coretextisbn {
    type: string
    sql: ${TABLE}.CORETEXTISBN ;;
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: courseuri {
    type: string
    sql: ${TABLE}.COURSEURI ;;
  }

  dimension: datalayer {
    type: string
    sql: ${TABLE}.DATALAYER ;;
  }

  dimension: datalayer_json {
    type: string
    sql: ${TABLE}.DATALAYER_JSON ;;
  }

  dimension: datasetid {
    type: string
    sql: ${TABLE}.DATASETID ;;
  }

  dimension: deploymentid {
    type: string
    sql: ${TABLE}.DEPLOYMENTID ;;
  }

  dimension: duration_from_prev_hit {
    type: number
    sql: ${TABLE}.DURATION_FROM_PREV_HIT ;;
  }

  dimension: duration_from_visit_start {
    type: number
    sql: ${TABLE}.DURATION_FROM_VISIT_START ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.ENVIRONMENT ;;
  }

  dimension: eventaction {
    type: string
    sql: ${TABLE}.EVENTACTION ;;
  }

  dimension: eventcategory {
    type: string
    sql: ${TABLE}.EVENTCATEGORY ;;
  }

  dimension: eventlabel {
    type: string
    sql: ${TABLE}.EVENTLABEL ;;
  }

  dimension: eventvalue {
    type: number
    sql: ${TABLE}.EVENTVALUE ;;
  }

  dimension: fullvisitorid {
    type: string
    sql: ${TABLE}.FULLVISITORID ;;
  }

  dimension_group: hit {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.HIT_TIME ;;
  }

  dimension: hits_hitnumber {
    type: number
    sql: ${TABLE}.HITS_HITNUMBER ;;
  }

  dimension: hits_time {
    type: number
    sql: ${TABLE}.HITS_TIME ;;
  }

  dimension: hostname {
    type: string
    sql: ${TABLE}.HOSTNAME ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
    hidden: yes
  }

  dimension_group: localtime_timestamp_tz {
    group_label: "Local Time"
    label: ""
    type: time
    timeframes: [raw, date, hour_of_day, day_of_week, time_of_day, month, year, week_of_year]
    sql: ${TABLE}.LOCALTIME_TIMESTAMP_TZ ;;
  }

  dimension: localtime_timestamp_tz_day_hour_sort {
    type: number
    sql: (decode(to_char(${localtime_timestamp_tz_raw}, 'dy'), 'Sun', 0, 'Mon', 1, 'Tue', 2, 'Wed', 3, 'Thu', 4, 'Fri', 5, 'Sat', 6) || '.' || to_char(${localtime_timestamp_tz_raw}, 'hh24'))::float ;;
    hidden: yes
  }

  dimension: localtime_timestamp_tz_day_hour {
    group_label: "Local Time"
    label: "Day of Week/Hour of Day"
    type: string
    sql: to_char(${localtime_timestamp_tz_raw}, 'dy hh24:00') ;;
    order_by_field: localtime_timestamp_tz_day_hour_sort
  }



  dimension: localtimefmt {
    type: string
    sql: ${TABLE}.LOCALTIMEFMT ;;
    hidden: yes
  }

  dimension: nbid {
    type: number
    value_format_name: id
    sql: ${TABLE}.NBID ;;
  }

  dimension: nbnodeid {
    type: number
    value_format_name: id
    sql: ${TABLE}.NBNODEID ;;
  }

  dimension: pagepath {
    type: string
    sql: ${TABLE}.PAGEPATH ;;
  }

  dimension: param_size {
    type: number
    sql: ${TABLE}.PARAM_SIZE ;;
  }

  dimension: parentid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PARENTID ;;
  }

  dimension_group: prev_hit {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.PREV_HIT_TIME ;;
  }

  dimension: productplatform {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORM ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
    hidden: yes
  }

  dimension: sessionid {
    type: string
    sql: ${TABLE}.SESSIONID ;;
    hidden: yes
  }

  dimension: strlocaltime {
    type: string
    sql: ${TABLE}.STRLOCALTIME ;;
    hidden: yes
  }

  dimension: totals_timeonsite {
    type: number
    sql: ${TABLE}.TOTALS_TIMEONSITE/60/60/24 ;;
  }

  dimension: totals_timeonsite_tier {
    type: tier
    tiers: [0, 100, 500]
    sql: ${totals_timeonsite} ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.URL ;;
  }

  dimension: userrole {
    type: string
    sql: ${TABLE}.USERROLE ;;
  }

  dimension: userssoguid {
    type: string
    sql: ${TABLE}.USERSSOGUID ;;
    hidden: no
  }

  dimension_group: visit_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.VISIT_START_TIME ;;
  }

  dimension: visitid {
    type: number
    value_format_name: id
    sql: ${TABLE}.VISITID ;;
    hidden: yes
  }

  dimension: visitnumber {
    type: number
    sql: ${TABLE}.VISITNUMBER ;;
  }

  dimension: visitstarttime {
    type: number
    sql: ${TABLE}.VISITSTARTTIME ;;
    hidden: yes
  }

  measure: totals_timeonsite_sum {
    type: sum_distinct
    sql: ${totals_timeonsite} ;;
    value_format_name: duration_hms
  }

  measure: totals_timeonsite_avg {
    type: average_distinct
    sql: ${totals_timeonsite} ;;
    value_format_name: duration_hms
  }

  measure: visit_count {
    type: count_distinct
    sql: ${visitid} ;;
  }

  measure: visitor_count {
    type: count_distinct
    sql: ${fullvisitorid} ;;
  }

  measure: unique_students {
    type: count_distinct
    sql: ${userssoguid} ;;
  }

  measure: visits_per_student {
    type: number
    sql: ${visit_count} / ${visitor_count} ;;
  }

  measure: hits_per_student {
    type:  number
    sql: ${count} / ${visitor_count} ;;
  }

  measure: count {
    type: count
    drill_fields: [ga_data_parsed_id, hostname]
  }

  dimension:  time_in_mindtap {
    hidden: yes
    type:number
    sql: case when lower(${eventcategory}) = 'time-in-mindtap' then ${eventvalue}
                when lower(${eventaction}) = 'time-in-mindtap' then ${eventvalue}
                when contains(lower(${eventlabel}), 'time-in-mindtap') then ${eventvalue}
         else 0 end/(1000*60*60*24)  ;;
  }

  measure: time_in_mindtap_sum {
    type: sum
    sql: ${time_in_mindtap} ;;
    value_format_name: duration_hms
    group_label : "DS event metrics"

  }

  measure: time_in_mindtap_avg {
    type: average
    sql: ${time_in_mindtap} ;;
    value_format_name: duration_hms
    group_label : "DS event metrics"
  }
}
