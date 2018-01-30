view: apliacontent {
  sql_table_name: STG_APLIA.APLIACONTENT ;;

  dimension: assignment_guid {
    type: string
    sql: ${TABLE}.ASSIGNMENT_GUID ;;
  }

  dimension: author_guid {
    type: string
    sql: ${TABLE}.AUTHOR_GUID ;;
  }

  dimension: average_time {
    type: string
    sql: ${TABLE}.AVERAGE_TIME ;;
  }

  dimension: content_group_id {
    type: string
    sql: ${TABLE}.CONTENT_GROUP_ID ;;
  }

  dimension: content_id {
    type: string
    sql: ${TABLE}.CONTENT_ID ;;
  }

  dimension: context_guid {
    type: string
    sql: ${TABLE}.CONTEXT_GUID ;;
  }

  dimension_group: create {
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
    sql: ${TABLE}.CREATE_DATE ;;
  }

  dimension: deleted {
    type: string
    sql: ${TABLE}.DELETED ;;
  }

  dimension_group: deleted {
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
    sql: ${TABLE}.DELETED_DATE ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: difficulty_level {
    type: string
    sql: ${TABLE}.DIFFICULTY_LEVEL ;;
  }

  dimension: guid {
    type: string
    primary_key: yes
    sql: ${TABLE}.GUID ;;
  }

  dimension_group: last_updated {
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
    sql: ${TABLE}.LAST_UPDATED ;;
  }

  dimension_group: ldts {
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
    sql: ${TABLE}.LDTS ;;
  }

  dimension: points {
    type: string
    sql: ${TABLE}.POINTS ;;
  }

  dimension: professor_note {
    type: string
    sql: ${TABLE}.PROFESSOR_NOTE ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.TITLE ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
