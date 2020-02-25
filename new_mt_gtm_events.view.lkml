
view: new_mt_gtm_events {
  derived_table: {
    sql: Select *,TO_DATE(TO_TIMESTAMP(((VISITSTARTTIME*1000) + HITS_TIME)/1000)) AS ACTIVITY_DATE from PROD.RAW_GA.GA_DATA_PARSED
      where EventCategory IN ('EDIT_MODE','SEARCH','HELP','LPN','ABOUT','COURSE_SETTINGS')
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension: ga_data_parsed_id {
    type: number
    sql: ${TABLE}."GA_DATA_PARSED_ID" ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}."RSRC" ;;
    hidden: yes
  }

  dimension_group: activity {
    type: time
    sql: ${TABLE}."ACTIVITY_DATE" ;;
  }

  dimension_group: ldts {
    type: time
    sql: ${TABLE}."LDTS" ;;
    hidden: yes
  }

  dimension: datasetid {
    type: string
    sql: ${TABLE}."DATASETID" ;;
  }

  dimension: fullvisitorid {
    type: string
    sql: ${TABLE}."FULLVISITORID" ;;
  }

  dimension: visitid {
    type: number
    sql: ${TABLE}."VISITID" ;;
  }

  dimension: visitnumber {
    type: number
    sql: ${TABLE}."VISITNUMBER" ;;
  }

  dimension: visitstarttime {
    type: number
    sql: ${TABLE}."VISITSTARTTIME" ;;
  }

  dimension: hits_time {
    type: number
    sql: ${TABLE}."HITS_TIME" ;;
  }

  dimension: hits_hitnumber {
    type: number
    sql: ${TABLE}."HITS_HITNUMBER" ;;
  }

  dimension_group: visit_start_time {
    type: time
    sql: ${TABLE}."VISIT_START_TIME" ;;
    hidden: yes
  }

  dimension_group: hit_time {
    type: time
    sql: ${TABLE}."HIT_TIME" ;;
    hidden: yes
  }

  dimension_group: prev_hit_time {
    type: time
    sql: ${TABLE}."PREV_HIT_TIME" ;;
    hidden: yes
  }

  dimension_group: next_hit_time {
    type: time
    sql: ${TABLE}."NEXT_HIT_TIME" ;;
    hidden: yes
  }

  dimension: duration_from_visit_start {
    type: number
    sql: ${TABLE}."DURATION_FROM_VISIT_START" ;;
  }

  dimension: duration_from_prev_hit {
    type: number
    sql: ${TABLE}."DURATION_FROM_PREV_HIT" ;;
  }

  dimension: duration_to_next_hit {
    type: number
    sql: ${TABLE}."DURATION_TO_NEXT_HIT" ;;
  }

  dimension: hostname {
    type: string
    sql: ${TABLE}."HOSTNAME" ;;
  }

  dimension: pagepath {
    type: string
    sql: ${TABLE}."PAGEPATH" ;;
  }

  dimension: totals_timeonsite {
    type: number
    sql: ${TABLE}."TOTALS_TIMEONSITE" ;;
  }

  dimension: datalayer {
    type: string
    sql: ${TABLE}."DATALAYER" ;;
  }

  dimension: datalayer_json {
    type: string
    sql: ${TABLE}."DATALAYER_JSON" ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}."URL" ;;
  }

  dimension: nbid {
    type: number
    sql: ${TABLE}."NBID" ;;
  }

  dimension: parentid {
    type: number
    sql: ${TABLE}."PARENTID" ;;
  }

  dimension: nbnodeid {
    type: number
    sql: ${TABLE}."NBNODEID" ;;
  }

  dimension: deploymentid {
    type: string
    sql: ${TABLE}."DEPLOYMENTID" ;;
  }

  dimension: param_size {
    type: number
    sql: ${TABLE}."PARAM_SIZE" ;;
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}."COURSEKEY" ;;
  }

  dimension: userssoguid {
    type: string
    sql: ${TABLE}."USERSSOGUID" ;;
  }

  measure: count_guid {
    type: count_distinct
    sql:  ${TABLE}."USERSSOGUID" ;;
  }

  dimension: userrole {
    type: string
    sql: ${TABLE}."USERROLE" ;;
  }

  dimension: productplatform {
    type: string
    sql: ${TABLE}."PRODUCTPLATFORM" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."ENVIRONMENT" ;;
  }

  dimension: strlocaltime {
    type: string
    sql: ${TABLE}."STRLOCALTIME" ;;
  }

  dimension: localtimefmt {
    type: string
    sql: ${TABLE}."LOCALTIMEFMT" ;;
  }

  dimension_group: localtime_timestamp_tz {
    type: time
    sql: ${TABLE}."LOCALTIME_TIMESTAMP_TZ" ;;
  }

  dimension: courseuri {
    type: string
    sql: ${TABLE}."COURSEURI" ;;
  }

  dimension: eventcategory {
    type: string
    sql: ${TABLE}."EVENTCATEGORY" ;;
  }

  dimension: eventaction {
    type: string
    sql: ${TABLE}."EVENTACTION" ;;
  }

  dimension: eventlabel {
    type: string
    sql: ${TABLE}."EVENTLABEL" ;;
  }

  dimension: eventvalue {
    type: number
    sql: ${TABLE}."EVENTVALUE" ;;
  }

  dimension: activityrefid {
    type: string
    sql: ${TABLE}."ACTIVITYREFID" ;;
  }

  dimension: activityuri {
    type: string
    sql: ${TABLE}."ACTIVITYURI" ;;
  }

  dimension: cendocid {
    type: string
    sql: ${TABLE}."CENDOCID" ;;
  }

  dimension: sessionid {
    type: string
    sql: ${TABLE}."SESSIONID" ;;
  }

  dimension: coretextisbn {
    type: string
    sql: ${TABLE}."CORETEXTISBN" ;;
  }

  dimension: geonetwork_region {
    type: string
    sql: ${TABLE}."GEONETWORK_REGION" ;;
  }

  dimension: geonetwork_metro {
    type: string
    sql: ${TABLE}."GEONETWORK_METRO" ;;
  }

  dimension: ismobile {
    type: string
    sql: ${TABLE}."ISMOBILE" ;;
  }

  dimension: devicecategory {
    type: string
    sql: ${TABLE}."DEVICECATEGORY" ;;
  }

  set: detail {
    fields: [
      ga_data_parsed_id,
      rsrc,
      ldts_time,
      datasetid,
      fullvisitorid,
      visitid,
      visitnumber,
      visitstarttime,
      hits_time,
      hits_hitnumber,
      visit_start_time_time,
      hit_time_time,
      prev_hit_time_time,
      next_hit_time_time,
      duration_from_visit_start,
      duration_from_prev_hit,
      duration_to_next_hit,
      hostname,
      pagepath,
      totals_timeonsite,
      datalayer,
      datalayer_json,
      url,
      nbid,
      parentid,
      nbnodeid,
      deploymentid,
      param_size,
      coursekey,
      userssoguid,
      userrole,
      productplatform,
      environment,
      strlocaltime,
      localtimefmt,
      localtime_timestamp_tz_time,
      courseuri,
      eventcategory,
      eventaction,
      eventlabel,
      eventvalue,
      activityrefid,
      activityuri,
      cendocid,
      sessionid,
      coretextisbn,
      geonetwork_region,
      geonetwork_metro,
      ismobile,
      devicecategory
    ]
  }
}
