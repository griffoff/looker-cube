view: assignment {
  sql_table_name: STG_APLIA.ASSIGNMENT ;;

  dimension: available_after_seconds {
    type: string
    sql: ${TABLE}.AVAILABLE_AFTER_SECONDS ;;
  }

  dimension: available_before_seconds {
    type: string
    sql: ${TABLE}.AVAILABLE_BEFORE_SECONDS ;;
  }

  dimension: available_yn {
    type: string
    sql: ${TABLE}.AVAILABLE_YN ;;
  }

  dimension: bonus_yn {
    type: string
    sql: ${TABLE}.BONUS_YN ;;
  }

  dimension: context_guid {
    type: string
    sql: ${TABLE}.CONTEXT_GUID ;;
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

  dimension_group: display {
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
    sql: ${TABLE}.DISPLAY_DATE ;;
  }

  dimension_group: due {
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
    sql: ${TABLE}.DUE_DATE ;;
  }

  dimension: exclude_yn {
    type: string
    sql: ${TABLE}.EXCLUDE_YN ;;
  }

  dimension: external_points_poss {
    type: string
    sql: ${TABLE}.EXTERNAL_POINTS_POSS ;;
  }

  dimension: gradebook_group_id {
    type: string
    sql: ${TABLE}.GRADEBOOK_GROUP_ID ;;
  }

  dimension: guid {
    type: string
    sql: ${TABLE}.GUID ;;
  }

  dimension: in_mindtap_learning_path_yn {
    type: string
    sql: ${TABLE}.IN_MINDTAP_LEARNING_PATH_YN ;;
  }

  dimension: internal_link_url {
    type: string
    sql: ${TABLE}.INTERNAL_LINK_URL ;;
  }

  dimension: is_mindtap_autosubmitted_yn {
    type: string
    sql: ${TABLE}.IS_MINDTAP_AUTOSUBMITTED_YN ;;
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

  dimension: link_url {
    type: string
    sql: ${TABLE}.LINK_URL ;;
  }

  dimension: mindlink_guid {
    type: string
    sql: ${TABLE}.MINDLINK_GUID ;;
  }

  dimension_group: regrade {
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
    sql: ${TABLE}.REGRADE_DATE ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: section_guid {
    type: string
    sql: ${TABLE}.SECTION_GUID ;;
  }

  dimension: sort_order_num {
    type: string
    sql: ${TABLE}.SORT_ORDER_NUM ;;
  }

  dimension: textbookpart_id {
    type: string
    sql: ${TABLE}.TEXTBOOKPART_ID ;;
  }

  dimension: time_limit {
    type: string
    sql: ${TABLE}.TIME_LIMIT ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.TITLE ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  dimension: visible_yn {
    type: string
    sql: ${TABLE}.VISIBLE_YN ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
