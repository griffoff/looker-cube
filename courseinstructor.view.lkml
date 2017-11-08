view: courseinstructor {
  label: "Course Instructor"
  sql_table_name: DW_GA.COURSEINSTRUCTOR ;;

  dimension: coursekey {
    label: "Course Key"
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: instructoremail {
    label: "Instructor Email"
    type: string
    sql: ${TABLE}.INSTRUCTOREMAIL ;;
  }

  dimension: instructorid {
    label: "Instructor ID"
    type: string
    sql: ${TABLE}.INSTRUCTORID ;;
  }

  dimension: org_id {
    label: "Org ID"
    type: string
    sql: ${TABLE}.ORG_ID ;;
  }

  dimension: partyid {
    label: "Party ID"
    type: string
    sql: ${TABLE}.PARTYID ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.ROLE ;;
  }

  dimension: snapshot_id {
    label: "Snapshot ID"
    type: string
    sql: ${TABLE}.SNAPSHOT_ID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
