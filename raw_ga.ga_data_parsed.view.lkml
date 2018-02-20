map_layer: cities {
  url: "https://github.com/drei01/geojson-world-cities/blob/master/cities.geojson"
}

view: ga_data_parsed {
  label: "User Event Data"
  sql_table_name: DEV.RAW_GA.GA_DATA_PARSED ;;

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

  dimension: duration_to_next_hit {
    type: number
    sql: ${TABLE}.DURATION_TO_NEXT_HIT ;;
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
    timeframes: [raw,time, date, hour_of_day, day_of_week, time_of_day, month, year, week_of_year]
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

  dimension: geonetwork_region {
    type: string
    map_layer_name: us_states
  }

  dimension: geonetwork_metro {
    type: string
    map_layer_name: cities
  }

  dimension: ismobile {
    type: yesno
  }

  dimension: devicecategory {
    type: string
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

  #substitute for logins
  measure: session_count {
    type: count_distinct
    sql:  ${sessionid} ;;
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

  dimension: reading_page_view {
    label: "Page No. Viewed"
    type: number
    sql: nullif(${datalayer_json}:readingPageView::string, '')::int+1 ;;
  }

  dimension: reading_page_count {
    label: "Pages in Book"
    type: number
    sql: nullif(${datalayer_json}:readingPageCount::string,'') ;;
  }

  measure: pages_read {
    label: "Total Reader Pages Viewed"
    type: number
    sql: count(${reading_page_view}) ;;
  }

  measure: pages_in_books {
    label: "Total Pages Available to Read"
    type: sum_distinct
    sql: ${reading_page_count} ;;
  }

  measure: reading_page_max {
    label: "Max Page Viewed"
    type: max
    sql: ${reading_page_view} ;;
  }

  measure: reading_page_percent {
    label: "% of total pages read"
    type: number
    sql: ${pages_read} / ${pages_in_books} ;;
    value_format_name: percent_1
  }

  measure: duration_from_prev_hit_avg {
    type: average
    sql: ${duration_from_prev_hit} ;;
    value_format_name: duration_hms
  }

  measure: duration_to_next_hit_avg {
    type: average
    sql: ${duration_to_next_hit} ;;
    value_format_name: duration_hms
  }

  measure: duration_to_score_correlation {
    type: number
    sql: CORR(${user_final_scores.final_score}, ${duration_to_next_hit}) ;;
    value_format_name: decimal_3
  }

}
