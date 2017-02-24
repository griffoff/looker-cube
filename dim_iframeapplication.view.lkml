view: dim_iframeapplication {
  label: "App Dock"
  sql_table_name: DW_GA.DIM_IFRAMEAPPLICATION ;;

  dimension: displayname {
    label: "Display Name"
    type: string
    sql: COALESCE(${TABLE}.DISPLAYNAME, ${iframeapplicationname}) ;;
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension_group: dw_ldts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: iframeapplicationid {
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: iframeapplicationname {
    label: "Application Name"
    type: string
    sql: REPLACE(REPLACE(REPLACE(REPLACE(${TABLE}.IFRAMEAPPLICATIONNAME, '_', ' '), 'LAUNCH', ''), 'VIEW', ''), 'FLASH CARDS', 'FLASHCARDS') ;;
  }

  measure: count {
    type: count
    drill_fields: [iframeapplicationname, displayname]
  }
}
