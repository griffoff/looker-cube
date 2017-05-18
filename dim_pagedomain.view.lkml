view: dim_pagedomain {
  label: "Product Platform"
  sql_table_name: DW_GA.DIM_PAGEDOMAIN ;;

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

  dimension: environment {
    type: string
    sql: ${TABLE}.ENVIRONMENT ;;
    hidden: yes
  }

  dimension: loaddate {
    type: string
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  dimension: pagedomain {
    label: "Page Domain"
    type: string
    sql: ${TABLE}.PAGEDOMAIN ;;
    hidden: yes
  }

  dimension: pagedomainid {
    type: string
    sql: ${TABLE}.PAGEDOMAINID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden: yes
  }

  measure: count {
    label: "No. of product domains"
    type: count
    drill_fields: []
    hidden: yes
  }
}
