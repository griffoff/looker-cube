view: activity {
  label: "Activity"
  sql_table_name: STG_MINDTAP.ACTIVITY;;

dimension: ldts {
  type: string
  label: "LDTS"
  sql: ${TABLE}.LDTS;;
}

dimension: rsrc {
  type: string
  label: "RSRC"
  sql: ${TABLE}.RSRC;;
}

dimension: id {
  type: string
  label: "ID"
  sql: ${TABLE}.ID;;
}

dimension: activity_type {
  type: string
  label: "Activity Type"
  sql: ${TABLE}.ACTIVITY_TYPE;;
}

dimension: app_id {
  type: string
  label: "App ID"
  sql: ${TABLE}.APP_ID;;
}

dimension: is_gradable {
  type: string
  label: "Is Gradable"
  sql: ${TABLE}.IS_GRADABLE;;
}

dimension: launch_action {
  type: string
  label: "Launch Action"
  sql: ${TABLE}.LAUNCH_ACTION;;
}

dimension: launch_parameters {
  type: string
  label: "Launch Paramters"
  sql: ${TABLE}.LAUNCH_PARAMETERS;;
}

dimension: ref_id {
  type: string
  label: "Ref ID"
  sql: ${TABLE}.REF_ID;;
}

dimension: search_uri {
  type: string
  label: "Search URI"
  sql: ${TABLE}.SEARCH_URI;;
}

dimension: app_activity_id {
  type: string
  label: "App Activity ID"
  sql: ${TABLE}.APP_ACTIVITY_ID;;
}

dimension: view_uri {
  type: string
  label: "View URI"
  sql: ${TABLE}.VIEW_URI;;
}

dimension: index_uri {
  type: string
  label: "Index URI"
  sql: ${TABLE}.INDEX_URI;;
}

dimension: max_score {
  type: string
  label: "Max Score"
  sql: ${TABLE}.MAX_SCORE;;
}

dimension: score_strategy {
  type: string
  label: "Score Strategy"
  sql: ${TABLE}.SCORE_STRATEGY;;
}

dimension: max_takes {
  type: string
  label: "Max Takes"
  sql: ${TABLE}.MAX_TAKES;;
}

dimension: inline_launch_params {
  type: string
  label: "Inline Launch Params"
  sql: ${TABLE}.INLINE_LAUNCH_PARAMS;;
}

dimension: is_student_started {
  type: string
  label: "Is Student Started"
  sql: ${TABLE}.IS_STUDENT_STARTED;;
}

dimension: is_scorable {
  type: string
  label: "Is Scorable"
  sql: ${TABLE}.IS_SCORABLE;;
}

dimension: is_timed {
  type: string
  label: "Is Timed"
  sql: ${TABLE}.IS_TIMED;;
}

dimension: manually_graded {
  type: string
  label: "Manually Graded"
  sql: ${TABLE}.MANUALLY_GRADED;;
}

dimension: duration {
  type: string
  label: "Duration"
  sql: ${TABLE}.DURATION;;
}

dimension: subtype {
  type: string
  label: "Subtype"
  sql: ${TABLE}.SUBTYPE;;
}

measure: count {
  label: "Count"
  type: count_distinct
  sql:  ${id} ;;

}

}
