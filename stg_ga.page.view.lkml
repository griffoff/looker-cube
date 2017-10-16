view: page {
  sql_table_name: STG_GA.PAGE ;;

  dimension: event_date_time {
    type: string
    sql: ${TABLE}.EVENT_DATE_TIME ;;
  }

  dimension: eventtimestamp {
    type: number
    sql: ${TABLE}.EVENTTIMESTAMP ;;
  }

  dimension: eventtype {
    type: string
    sql: ${TABLE}.EVENTTYPE ;;
  }

  dimension: pageeventindex {
    type: number
    sql: ${TABLE}.PAGEEVENTINDEX ;;
  }

  dimension: pageinstanceid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PAGEINSTANCEID ;;
  }

  dimension: pagelocation {
    type: string
    sql: ${TABLE}.PAGELOCATION ;;
  }

  dimension: pagelocationdomain {
    type: string
    sql: ${TABLE}.PAGELOCATIONDOMAIN ;;
  }

  dimension: pagetitle {
    type: string
    sql: ${TABLE}.PAGETITLE ;;
  }

  dimension: pageviewtime {
    type: number
    sql: ${TABLE}.PAGEVIEWTIME ;;
  }

  dimension: sessionnumber {
    type: number
    sql: ${TABLE}.SESSIONNUMBER ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
