view: fact_activation_appusage {
  label: "App Dock"
  sql_table_name: LOOKER_WORKSHOP.FACT_ACTIVATION_APPUSAGE ;;

  measure: clicks {
    type: sum
    sql: ${TABLE}.CLICKS ;;
  }

  dimension: pk {
    type: string
    sql: ${TABLE}.COURSEID || ${TABLE}.USERID ;;
    hidden:  yes
    primary_key: yes
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden:  yes
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden:  yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden:  yes
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden:  yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden:  yes
  }

  measure: user_count {
    label: "# Users"
    type:  count_distinct
    sql: ${userid} ;;
  }

}
