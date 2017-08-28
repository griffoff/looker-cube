view: ipeds {
  view_label: "Institution"
  sql_table_name: UPLOADS.ZPG.IPEDS ;;
  set: curated_fields {
    fields: []
  }

  dimension: full_time_undergraduate_enrollment_drvef_2015_ {
    label: "Full time undergrad enrollment level"
    group_label: "IPEDS"
    type: number
    sql: ${TABLE}.FULL_TIME_UNDERGRADUATE_ENROLLMENT_DRVEF_2015_ ;;
  }

  dimension: institution_name {
    label: "Institution Name"
    group_label: "IPEDS"
    type: string
    sql: ${TABLE}.INSTITUTION_NAME ;;

  }

  dimension: institution_size_category_hd_2015_ {
    label: "Institution size category"
    group_label: "IPEDS"
    type: number
    sql: ${TABLE}.INSTITUTION_SIZE_CATEGORY_HD_2015_ ;;
  }

  dimension: sector_of_institution_hd_2015_ {
    label: "Sector Id"
    group_label: "IPEDS"
    type: number
    sql: ${TABLE}.SECTOR_OF_INSTITUTION_HD_2015_ ;;
    hidden: yes
  }

  dimension: sector_of_institution_variable_name {
    label: "Sector"
    group_label: "IPEDS"
    type: string
    sql: ${TABLE}.SECTOR_OF_INSTITUTION_VARIABLE_NAME ;;
  }

  dimension: state_abbreviation_hd_2015_ {
    label: "State"
    group_label: "IPEDS"
    type: string
    sql: ${TABLE}.STATE_ABBREVIATION_HD_2015_ ;;
  }

  dimension: unit_id {
    label: "Full time undergrad enrollment level"
    group_label: "Unit Id"
    type: number
    sql: ${TABLE}.UNIT_ID ;;
    hidden: yes
    primary_key: yes
  }

  measure: count {
    type: count
    drill_fields: [institution_name, sector_of_institution_variable_name]
    hidden: yes
  }
}
