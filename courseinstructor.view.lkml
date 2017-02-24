view: courseinstructor {
  sql_table_name: DW_GA.COURSEINSTRUCTOR ;;

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: instructoremail {
    type: string
    sql: ${TABLE}.INSTRUCTOREMAIL ;;
  }

  dimension: instructorid {
    type: string
    sql: ${TABLE}.INSTRUCTORID ;;
  }

  dimension: org_id {
    type: string
    sql: ${TABLE}.ORG_ID ;;
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.ROLE ;;
  }

  dimension: snapshot_id {
    type: string
    sql: ${TABLE}.SNAPSHOT_ID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
