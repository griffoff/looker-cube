view: courseinstructor {
  label: "Course / Section Details"
  sql_table_name: DW_GA.COURSEINSTRUCTOR ;;

  dimension: coursekey {
    label: "Course Key"
    type: string
    sql: ${TABLE}.COURSEKEY ;;
    hidden: yes
  }

  dimension: instructoremail {
    group_label: "Instructor"
    label: "Instructor Email"
    type: string
    sql: ${TABLE}.INSTRUCTOREMAIL ;;
  }

  dimension: instructorid {
    label: "Instructor ID"
    type: string
    sql: ${TABLE}.INSTRUCTORID ;;
    hidden: yes
  }

  dimension: org_id {
    label: "Org ID"
    type: string
    sql: ${TABLE}.ORG_ID ;;
    hidden: yes
  }

  dimension: partyid {
    label: "Party ID"
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  dimension: role {
    group_label: "Instructor"
    label: "Instructor Role"
    type: string
    sql: ${TABLE}.ROLE ;;
  }

  dimension: snapshot_id {
    label: "Snapshot ID"
    type: string
    sql: ${TABLE}.SNAPSHOT_ID ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
