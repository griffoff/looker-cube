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

# Dimensions and measures for RI events
# Time in MT
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

  #ASSESSMENT
  dimension: assessment_activity_submitted {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'activity-submitted' and lower(${eventcategory}) = 'assessment' then 1 else 0 end ;;
  }

  dimension: assessment_launch {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'launch' and lower(${eventcategory}) = 'assessment' then 1 else 0 end ;;
  }

  dimension: assessment_activity_started {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'activity-started' and lower(${eventcategory}) = 'assessment' then 1 else 0 end ;;
  }

  dimension: assessment_view {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'view' and lower(${eventcategory}) = 'assessment' then 1 else 0 end ;;
  }

  dimension: assessment_activity {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'unknown' and split_part(, ':','4') = 'activity_id'
                                                      and lower(${eventcategory}) = 'assessment' then 1 else 0 end ;;
  }

  #TODO calculate measures for each category
  measure: assessment_activity_submitted_sum {
    type: sum
    sql: ${assessment_activity_submitted} ;;
    group_label : "DS event metrics"

  }

  measure: assessment_launch_sum {
    type: sum
    sql: ${assessment_launch} ;;
    group_label : "DS event metrics"

  }

  measure: assessment_activity_started_sum {
    type: sum
    sql: ${assessment_activity_started} ;;
    group_label : "DS event metrics"

  }

  measure: assessment_view_sum {
    type: sum
    sql: ${assessment_view} ;;
    group_label : "DS event metrics"

  }

  measure: assessment_activity_sum {
    type: sum
    sql: ${assessment_activity} ;;
    group_label : "DS event metrics"

  }


  #READING
  dimension: reading_Launch {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'launch' or     lower(${eventaction}) = 'app-dock-launch'
                        and lower(${eventcategory}) = 'reading' then 1 else 0 end ;;
  }
  measure:  reading_Launch_sum{
    type: sum
    sql: ${reading_Launch} ;;
    group_label : "DS event metrics"
  }

  dimension: reading_view {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'view' and lower(${eventcategory}) = 'reading' then 1 else 0 end ;;
  }
  measure:  reading_view_sum{
    type: sum
    sql: ${reading_view} ;;
    group_label : "DS event metrics"
  }

  dimension: reading_activity {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'unknown' and lower(${eventcategory}) = 'reading' then 1 else 0 end ;;
  }
  measure:  reading_activity_sum{
    type: sum
    sql: ${reading_activity} ;;
    group_label : "DS event metrics"
  }



  #MEDIA
  dimension: media {
    hidden: yes
    type: number
    sql: when lower(${eventcategory}) = 'media' then 1
                when lower(${eventaction}) = 'media' then 1
                when lower(${eventlabel}) ilike('%media%') then 1 else 0 end ;;
  }
  measure:  media_sum{
    type: sum
    sql: ${media} ;;
    group_label : "DS event metrics"
  }


  #SEARCHES
  dimension: search_launched {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'launch' or lower(eventAction) = 'app-dock-launch'
                    and lower(${eventcategory}) = 'search' then 1 else 0 ;;
  }
  measure:  search_launched_sum{
    type: sum
    sql: ${search_launched} ;;
    group_label : "DS event metrics"
  }

  dimension: search_performed {
    hidden: yes
    type: number
    sql: case when lower(${eventaction}) = 'search-performed' and lower(${eventcategory}) = 'search' then 1 else 0 end ;;
  }
  measure:  search_performed_sum{
    type: sum
    sql: ${search_performed} ;;
    group_label : "DS event metrics"
  }


  #NOTES
  #EVERNOTE
  dimension: everNote_Launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'evernote' then 1 else 0 end ;;
  }
  measure:everNote_Launch_sum{
    type: sum
    sql: ${everNote_Launch} ;;
    group_label : "DS event metrics"
  }

  dimension: everNoteMobile_Launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'evernote.mobile' then 1 else 0 end;;
  }
  measure:everNoteMobile_Launch_sum{
    type: sum
    sql: ${everNoteMobile_Launch} ;;
    group_label : "DS event metrics"
  }

  dimension: flashnotes_Launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'flashnotes' then 1 else 0 end;;
  }
  measure:flashnotes_Launch_sum{
    type: sum
    sql: ${flashnotes_Launch} ;;
    group_label : "DS event metrics"
  }

  dimension: flashnotesQAD_Launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'flashnotesqad' then 1 else 0 end;;
  }
  measure:flashnotesQAD_Launch_sum{
    type: sum
    sql: ${flashnotesQAD_Launch} ;;
    group_label : "DS event metrics"
  }

  dimension: flashnotesCEO_Launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'flashnotes.ceo' then 1 else 0 end;;
  }
  measure:flashnotesCEO_Launch_sum{
    type: sum
    sql: ${flashnotesCEO_Launch} ;;
    group_label : "DS event metrics"
  }

  #MY+NOTES
  dimension: mynotes_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'my+notes' then 1 else 0 end;;
  }
  measure:mynotes_launch_sum{
    type: sum
    sql: ${mynotes_launch} ;;
    group_label : "DS event metrics"
  }

  dimension: notepad_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and lower(eventcategory) = 'notepad' then 1 else 0 end;;
  }
  measure:notepad_launch_sum{
    type: sum
    sql: ${notepad_launch} ;;
    group_label : "DS event metrics"
  }


  dimension: onenote_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'onenote' then 1 else 0 end;;
  }
  measure:onenote_launch_sum{
    type: sum
    sql: ${onenote_launch} ;;
    group_label : "DS event metrics"
  }


  #QUICKNOTE
  dimension: quicknote_create {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'create' or lower(eventAction) = 'create-quicknote' and lower(eventcategory) = 'quicknote' then 1 else 0 end;;
  }
  measure:quicknote_create_sum{
    type: sum
    sql: ${quicknote_create} ;;
    group_label : "DS event metrics"
  }

  dimension: quicknote_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and lower(eventcategory) = 'quicknote' then 1 else 0 end;;
  }
  measure:quicknote_launch_sum{
    type: sum
    sql: ${quicknote_launch} ;;
    group_label : "DS event metrics"
  }

  #GRADEBOOK
  dimension: gradebook_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'gradebook' then 1 else 0 end;;
  }
  measure:gradebook_launch_sum{
    type: sum
    sql: ${gradebook_launch} ;;
    group_label : "DS event metrics"
  }


  #HOMEWORK
  dimension: homework_submitted {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'activity-submitted' and lower(eventcategory) = 'homework' then 1 else 0 end;;
  }
  measure:homework_submitted_sum{
    type: sum
    sql: ${homework_submitted} ;;
    group_label : "DS event metrics"
  }

  dimension: homework_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and lower(eventcategory) = 'homework' then 1 else 0 end;;
  }
  measure:homework_launch_sum{
    type: sum
    sql: ${homework_launch} ;;
    group_label : "DS event metrics"
  }

  dimension: homework_started {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'activity-started' and lower(eventcategory) = 'homework' then 1 else 0 end;;
  }
  measure:homework_started_sum{
    type: sum
    sql: ${homework_started} ;;
    group_label : "DS event metrics"
  }

  dimension: homework_view {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'view' and lower(eventcategory) = 'homework' then 1 else 0 end;;
  }
  measure:homework_view_sum{
    type: sum
    sql: ${homework_view} ;;
    group_label : "DS event metrics"
  }

  dimension: homework {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'UNKNOWN' and lower(eventcategory) = 'homework' then 1 else 0 end;;
  }
  measure:homework_sum{
    type: sum
    sql: ${homework} ;;
    group_label : "DS event metrics"
  }


  #BOOKMARKS
  dimension: bookmarks_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) ='bookmarks' then 1 else 0 end;;
  }
  measure:bookmarks_launch_sum{
    type: sum
    sql: ${bookmarks_launch} ;;
    group_label : "DS event metrics"
  }

  dimension: bookmarks_create {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'create' or lower(eventAction) = 'create-bookmark' and lower(eventcategory) ='bookmarks' then 1 else 0 end;;
  }
  measure:bookmarks_create_sum{
    type: sum
    sql: ${bookmarks_create} ;;
    group_label : "DS event metrics"
  }

  #PROGRESS
  dimension: progress_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'progress' then 1 else 0 end;;
  }
  measure:progress_launch_sum{
    type: sum
    sql: ${progress_launch} ;;
    group_label : "DS event metrics"
  }

  #FLASHCARDS
  dimension: flashcards_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'flashcards' or lower(eventCategory) = 'flash-cards' then 1 else 0 end;;
  }
  measure:flashcards_launch_sum{
    type: sum
    sql: ${flashcards_launch} ;;
    group_label : "DS event metrics"
  }

  dimension: flashcards_view {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'view' and lower(eventcategory) = 'flashcards' then 1 else 0 end;;
  }
  measure:flashcards_view_sum{
    type: sum
    sql: ${flashcards_view} ;;
    group_label : "DS event metrics"
  }

  #GLOSSARY
  dimension: glossary_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'glossary' then 1 else 0 end;;
  }
  measure:glossary_launch_sum{
    type: sum
    sql: ${glossary_launch} ;;
    group_label : "DS event metrics"
  }

  dimension: glossary_view {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'view' and lower(eventcategory) = 'glossary' then 1 else 0 end;;
  }
  measure:glossary_view_sum{
    type: sum
    sql: ${glossary_view} ;;
    group_label : "DS event metrics"
  }

  dimension: glossary_show {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'glossary-show' and lower(eventcategory) = 'glossary' then 1 else 0 end;;
  }
  measure:glossary_show_sum{
    type: sum
    sql: ${glossary_show} ;;
    group_label : "DS event metrics"
  }

  #HIGHLIGHTS
  dimension: highlights_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'app-dock-launch' and lower(eventcategory) ='highlight' then 1 else 0 end;;
  }
  measure:highlights_launch_sum{
    type: sum
    sql: ${highlights_launch} ;;
    group_label : "DS event metrics"
  }

  dimension: highlights_create {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'create' or lower(eventAction) = 'create-highlight' and lower(eventcategory) ='highlight' then 1 else 0 end;;
  }
  measure:highlights_create_sum{
    type: sum
    sql: ${highlights_create} ;;
    group_label : "DS event metrics"
  }

  #MESSAGECENTER
  dimension: messagecenter_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'messagecenter' then 1 else 0 end;;
  }
  measure:messagecenter_launch_sum{
    type: sum
    sql: ${messagecenter_launch} ;;
    group_label : "DS event metrics"
  }

  #MESSAGE - CENTER
  dimension: messagecenter_preferences_changed {
    hidden: yes
    type: number
    sql: case when lower(eventAction) ='preferences-changed' and lower(eventcategory) = 'message-center' then 1 else 0 end;;
  }
  measure:messagecenter_preferences_changed_sum{
    type: sum
    sql: ${messagecenter_preferences_changed} ;;
    group_label : "DS event metrics"
  }

  dimension: messagecenter_message_sent {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='message-sent' and lower(eventcategory) = 'message-center' then 1 else 0 end;;
  }
  measure:messagecenter_message_sent_sum{
    type: sum
    sql: ${messagecenter_message_sent} ;;
    group_label : "DS event metrics"
  }

  #STUDY GUIDE
  dimension: studyguide_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' and lower(eventcategory) = 'studyguide' then 1 else 0 end;;
  }
  measure:studyguide_launch_sum{
    type: sum
    sql: ${studyguide_launch} ;;
    group_label : "DS event metrics"
  }

  dimension: studyguide {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='unknown' and lower(eventcategory) = 'studyguide' then 1 else 0 end;;
  }
  measure:studyguide_sum{
    type: sum
    sql: ${studyguide} ;;
    group_label : "DS event metrics"
  }

  #CONCEPT-MAP
  dimension: concept_map_interacted {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='interacted' and lower(eventcategory) = 'concept-map' then 1 else 0 end;;
  }
  dimension: concept_map {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='unknown' and lower(eventcategory) = 'concept-map' then 1 else 0 end;;
  }
  #CONCEPTMAP
  dimension: conceptmap_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' and lower(eventcategory) = 'conceptmap' then 1 else 0 end ;;
  }
  #CONCEPTMAP.ACTIVITY
  dimension: conceptmap_activity_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'conceptmap.activity' then 1 else 0 end ;;
  }
  #CONCEPTMAP-DOCK.APP
  dimension: conceptmap_app_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'conceptmap-dock.app' then 1 else 0 end;;
  }
  #READSPEAKER
  dimension: readspeaker_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'readspeaker' then 1 else 0 end;;
  }
  dimension: readspeaker1_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'readspeaker1' then 1 else 0 end;;
  }
  dimension: readspeaker3_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'readspeaker3' then 1 else 0 end;;
  }
  #DICTIONARY
  dimension: dictionary_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'dictionary' then 1 else 0 end;;
  }
  #outcome.management
  dimension: outcome_management_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'outcome.management' then 1 else 0 end;;
  }
  #RSSFEED
  dimension: rssfeed_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'rssfeed' or lower(eventCategory) = 'rss-feed' then 1 else 0 end;;
  }
  #KALTURA
  dimension: kaltura_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'kaltura' then 1 else 0 end;;
  }
  #GOOGLE.DOC
  dimension: googledoc_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'google.doc' then 1 else 0 end;;
  }
  #googledocs
  dimension: googledocs_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' and lower(eventcategory) = 'googledocs' then 1 else 0 end;;
  }
  #GOOGLE-DOC
  dimension: google_docs_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' and lower(eventcategory) = 'google-doc' then 1 else 0 end;;
  }
  #YOUSEEu.QA
  dimension: youseeu_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'youseeu' then 1 else 0 end;;
  }
  #mindapp-scenario
  dimension: mindappscenario_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'mindapp-scenario' then 1 else 0 end;;
  }
  #studyhub.mindapp
  dimension: studyhubmindapp_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'studyhub.mindapp' then 1 else 0 end;;
  }
  #weblinks
  dimension: weblinks_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' and lower(eventcategory) = 'weblinks' then 1 else 0 end;;
  }
  #dlappdock.techconnections
  dimension: dlappdock_techconnections_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'dlappdock.techconnections' then 1 else 0 end;;
  }
  #dlmt.iq
  dimension: dlmt_iq_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) = 'app-dock-launch' and lower(eventCategory) = 'dlmt.iq' then 1 else 0 end;;
  }
  #dlmt.iq.instructortestcreator
  dimension: dlmt_iq_instructortestcreator_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'dlmt.iq.instructortestcreator' then 1 else 0 end;;
  }
  #dlmt.iq.studenttestcreator
  dimension: dlmt_iq_studenttestcreator_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'dlmt.iq.studenttestcreator' then 1 else 0 end;;
  }
  #connectyard.learner
  dimension: connectyardlearner_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'connectyard.learner' then 1 else 0 end;;
  }
  #mindtap_instructor_resourcecenter_launch
  dimension: mindtap_instructor_resourcecenter_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'mindtapinstructorresourcecenter' then 1 else 0 end;;
  }
  #questia
  dimension: questia_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'questia' then 1 else 0 end;;
  }
  #STUDYCENTER
  dimension: studycenter_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'studycenter' then 1 else 0 end;;
  }
  #CHEMISTRYREFERENCE
  dimension: chemistryreference_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'chemistryreference' then 1 else 0 end;;
  }

  #OUTLINE SPEECH
  dimension: outlinespeech_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'outline.speech' then 1 else 0 end;;
  }
  #cnow.hw_preclass_ilrn_com
  dimension: cnowhw_preclass_ilrn_com_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='app-dock-launch' and lower(eventcategory) = 'cnow.hw-preclass_ilrn_com' or lower(eventCategory) = 'cnow.hw-preclass-ilrn-com' then 1 else 0 end;;
  }
  #WAC
  dimension: wac_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'wac' then 1 else 0 end;;
  }
  #INSITE
  dimension: insite_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'insite' then 1 else 0 end;;
  }
  #ATP
  dimension: atp_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'atp' then 1 else 0 end;;
  }
  #POLLING
  dimension: polling_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'polling' then 1 else 0 end;;
  }
  #diet.wellnes.plus
  dimension: diet_wellnes_plus_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'diet.wellnes.plus' then 1 else 0 end;;
  }
  #MINDAPP-EPORTFOLIO
  dimension: mindapp_eportfolio_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'mindapp-eportfolio' then 1 else 0 end;;
  }
  #SYSTEMCHECK
  dimension: systemcheck_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'systemcheck' then 1 else 0 end;;
  }
  #MINDAPP RESOURCE VIEWER
  dimension: mindapp_resource_viewer_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='app-dock-launch' and lower(eventcategory) = 'mindapp.resource.viewer' then 1 else 0 end ;;
  }
  #DASHBOARD NAVIGATION
  dimension: dashboard_navigation {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='unknown' and lower(eventcategory) = 'dashboard' then 1 else 0 end;;
  }
  #ONEDRIVE
  dimension: onedrive_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'onedrive' then 1 else 0 end ;;
  }
  #FAQ
  dimension: faq_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'faq' then 1 else 0 end;;
  }
  #BLOG
  dimension: blog_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'blog' then 1 else 0 end;;
  }

  ##ACTIVITY
  dimension: rssfeed_activity_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'RSS Feed' then 1 else 0 end;;
  }
  dimension: studyguide_activity_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'study guide' then 1 else 0 end;;
  }
  dimension: studyguide_activity_view {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'view' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'study guide' then 1 else 0 end;;
  }
  dimension: homework_activity_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'homework' then 1 else 0 end;;
  }
  dimension: homework_activity_view {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'view' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'homework' then 1 else 0 end;;
  }
  dimension: media_activity_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'media' then 1 else 0 end;;
  }
  dimension: weblinks_activity_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'web links' then 1 else 0 end;;
  }
  dimension: googledocs_activity_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'google docs' then 1 else 0 end;;
  }
  dimension: Flashcards_activity_Launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'flash-cards' then 1 else 0 end;;
  }
  dimension: Assessment_activity_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'assessment' then 1 else 0 end;;
  }
  dimension: Assessment_activity_view {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'view' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'assessment' then 1 else 0 end;;
  }
  dimension: reading_activity_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'reading' then 1 else 0 end;;
  }
  dimension: reading_activity_view {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'view' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'reading' then 1 else 0 end ;;
  }
  dimension: other_activity_launch {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'other' then 1 else 0 end;;
  }
  dimension: other_activity_view {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'view' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'other' then 1 else 0 end;;
  }
  dimension: generated_folder_activity {
    hidden: yes
    type: number
    sql: case when lower(eventAction) = 'launch' and activitycgi is not null and split_part(activityCGI, ':', 3) = 'generated' then 1 else 0 end;;
  }

  #activity-builder
  dimension: activitybuilder_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' and lower(eventcategory) = 'activity-builder' then 1 else 0 end;;
  }
  #diet analysis plus
  dimension: diet_analysis_plus_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'diet.analysis.plus' then 1 else 0 end;;
  }
  #profile plus
  dimension: profile_plus_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'profile.plus' then 1 else 0 end ;;
  }
  #INAPPPURCHASE
  dimension: inapppurchase_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'inapppurchase' then 1 else 0 end;;
  }
  #COMPOSITION
  dimension: composition_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='app-dock-launch' and lower(eventcategory) = 'composition' then 1 else 0 end;;
  }
  #HISTORY-CONCEPTMAP.ACTIVITY
  dimension: history_conceptmapactivity_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'history-conceptmap.activity' then 1 else 0 end;;
  }
  #LAMS
  dimension: lams_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'lams' then 1 else 0 end;;
  }
  #LAMS-V2
  dimension: lams_v2_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) = 'app-dock-launch' and lower(eventCategory) = 'lams-v2' then 1 else 0 end;;
  }
  #GLOSSARY-SHOW2
  dimension: glossary_show2 {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='glossary-show' and lower(eventcategory) = 'glossary-show' then 1 else 0 end;;
  }
  dimension: create_glossary_show {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='create-glossary-show' and lower(eventcategory) = 'glossary-show' then 1 else 0 end  ;;
  }

  #OUTLINE COMPOSITION
  dimension: outline_composition_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'outline.composition' then 1 else 0 end;;
  }
  #OTHERS
  dimension: other_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' and lower(eventcategory) = 'other' then 1 else 0 end;;
  }
  dimension: other_activity_submitted {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='activity-submitted' and lower(eventcategory) = 'other' then 1 else 0 end;;
  }

  #LAUNCHES
  dimension: assignment_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch assignment' and lower(eventcategory) = 'launch' then 1 else 0 end;;
  }
  dimension: assignment_Learning_Burst_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch assignment from learning burst' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: exerciseSet_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch exercise set' and lower(eventcategory) = 'launch' then 1 else 0 end;;
  }
  dimension: mediaQuiz_learning_Burst_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch media quiz from learning burst' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: class_Skills_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch class skills' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: textSnippet_Learning_Burst_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch text snippet from learning burst' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: gradebook_Launches {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch gradebook' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: quiz_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch quiz' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: exerciseSet_Learning_Burst_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch exercise set learning burst' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: pred_ReportActivity_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch pred report activity' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: gameActivity_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch game activity' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: mediaQuiz_Activity_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch media quiz activity' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }
  dimension: game_Learning_Burst_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch game from learning burst' and lower(eventcategory) = 'launch' then 1 else 0 end ;;
  }

  #VIDEO CAPTURE
  dimension: videoCapture_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'videocapture' then 1 else 0 end as ;;
  }
  #APLIMOBILE
  dimension: apliaMobile_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch' and lower(eventcategory) = 'apliamobile' then 1 else 0 end;;
  }
  #aplia
  dimension: aplia_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'aplia' then 1 else 0 end;;
  }
  #alg
  dimension: alg_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'alg' then 1 else 0 end;;
  }
  #cnow.hw
  dimension: cnowhw_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'cnow.hw' then 1 else 0 end ;;
  }
  #MTSTUDYCENTER.MINDAPP
  dimension: mtstudycentermindapp_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='app-dock-launch' and lower(eventcategory) = 'mtstudycenter.mindapp' then 1 else 0 end ;;
  }
   #YSTEM+SETUP
  dimension: systemsetup_interacted {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='interacted' and lower(eventcategory) = 'system+setup' then 1 else 0 end ;;
  }

  #system
  dimension: system_interacted {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='interacted' and lower(eventcategory) = 'system' then 1 else 0 end ;;
  }
  #STUDYHUB.MT4
  dimension: studyhubmt4_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'studyhub.mt4' then 1 else 0 end;;
  }
  #CEREGO
  dimension: cerego_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'cerego' then 1 else 0 end;;
  }

  #nettutor6
  dimension: nettutor6_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'nettutor6' then 1 else 0 end;;
  }

  #sam.appification.prod
  dimension: sam_appification_prod_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'sam.appification.prod' then 1 else 0 end;;
  }

  #speechvideolibraryprod
  dimension: speechvideolibraryprod_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'speechvideolibraryprod' then 1 else 0 end;;
  }
  #nettutorlti
  dimension: nettutorlti_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch'and lower(eventcategory) = 'nettutorlti' then 1 else 0 end;;
  }
  #WEBASSIGN.BSPAGE
  dimension: webassignbspage_Launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) = 'app-dock-launch' and lower(eventCategory) = 'webassign.bspage' then 1 else 0 end;;
  }
  #milady
  dimension: milady_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'milady' then 1 else 0 end;;
  }
  #MILADY.PROCEDURAL.TRACKER
  dimension: milady_procedural_tracker_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'milady.procedural.tracker' then 1 else 0 end;;
  }
  #midapp-ab
  dimension: mindapp_ab_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'mindapp-ab' then 1 else 0 end;;
  }
  #mindapp-grove
  dimension: mindapp_grove_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'mindapp-grove' then 1 else 0 end;;
  }
  #mindapp-office-365
  dimension: mindapp_office_365_launch {
    hidden: yes
    type: number
    sql:case when lower(eventAction) ='launch' or lower(eventAction) = 'app-dock-launch'and lower(eventcategory) = 'mindapp-office-365' then 1 else 0 end;;
  }
}
