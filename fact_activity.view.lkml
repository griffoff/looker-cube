view: fact_activity {
  label: "Learning Path Modifications"
  sql_table_name: DW_GA.FACT_ACTIVITY ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
    hidden: yes
  }

  dimension: activityid {
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
    hidden: yes
  }

  dimension: courseid {
    type: string
    hidden: yes
    sql: ${TABLE}.COURSEID ;;
  }

  dimension: coursesnapshoteventid {
    type: string
    sql: ${TABLE}.COURSESNAPSHOTEVENTID ;;
    hidden: yes
  }

  dimension: createddatekey {
    type: string
    sql: ${TABLE}.CREATEDDATEKEY ;;
    hidden: yes
  }

  dimension: daysbeforecourseend {
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
    hidden: yes
  }

  dimension: daysfromcoursestart {
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART ;;
    hidden: yes
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension: dw_ldts {
    type: string
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: eventtypeid {
    type: string
    sql: ${TABLE}.EVENTTYPEID ;;
    hidden: yes
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
    hidden: yes
  }

  dimension: institutionid {
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
    hidden: yes
  }

  dimension: institutionlocationid {
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
    hidden: yes
  }

  dimension: learningpathid {
    type: string
    sql: ${TABLE}.LEARNINGPATHID ;;
    hidden: yes
  }

  dimension: loaddate {
    type: string
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: snapshotid {
    type: string
    sql: ${TABLE}.SNAPSHOTID ;;
    hidden: yes
  }

  dimension: timekey {
    type: string
    sql: ${TABLE}.TIMEKEY ;;
    hidden: yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  measure: count {
    label: "No. of Actions"
    type: count
    drill_fields: [dim_product.discipline, dim_institution.institutionname, dim_activity.assignment_status, dim_learningpath.lowest_level, count]
  }
}
