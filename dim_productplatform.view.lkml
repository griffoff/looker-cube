view: dim_productplatform {
  label: "Product"
  sql_table_name: DW_GA.DIM_PRODUCTPLATFORM ;;

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

  dimension: is_platform {
    type: string
    sql: ${TABLE}.IS_PLATFORM ;;
    hidden: yes
  }

  dimension: productplatform {
    label: "Platform name"
    description: "MindTap, Aplia, CNOW, etc."
    type: string
    sql: COALESCE(${TABLE}.PRODUCTPLATFORM, 'UNKNOWN') ;;
  }


#   dimension: productplatform_other {
#     label: "Platform name (other)"
#     description: "MindTap, Aplia, CNOW, etc."
#     type: string
#     sql: CASE
#           WHEN COALESCE(${TABLE}.PRODUCTPLATFORM, 'UNKNOWN')
#           IN ('MindTap', 'WebAssign', 'MindTap Reader', 'Aplia', 'OWL V2', 'SAM', 'Quia', 'Cengage Unlimited')
#           THEN COALESCE(${TABLE}.PRODUCTPLATFORM, 'UNKNOWN')
#           WHEN COALESCE(${TABLE}.PRODUCTPLATFORM, 'UNKNOWN') ILIKE '%4LTR%' THEN '4LTR'
#           WHEN COALESCE(${TABLE}.PRODUCTPLATFORM, 'UNKNOWN') ILIKE '%CNOW%' THEN 'CNOW'
#           ELSE 'Other' END
#           ;;
#   }

  dimension: newproductplatform {
    label: "New Platform name"
    description: "MindTap, Aplia, CNOW, etc."
    type: string
#     sql: COALESCE(${TABLE}.PRODUCTPLATFORM, 'UNKNOWN') ;;
    sql: CASE WHEN ${TABLE}.PRODUCTPLATFORM = 'UNKNOWN' THEN ' ' ELSE ${TABLE}.PRODUCTPLATFORM END ;;
  }

  dimension: includeinactivationsreport {
    label: "Included in Activations report"
    type: yesno
    sql: ${productplatform} in ('MindTap', 'Aplia','CNOW','SAM','4LTR Online','OWL V2')
              or ${productplatform} in ('Diet Analysis Plus', 'Write Experience', 'Insite', 'Speech Studio')
              or ${productplatform} in ('OWL','SAM', 'WebAssign', 'Quia') ;;
  }

  dimension: activationsreportplatform {
    label: "Platform in Activations Report"
    type:  string
    sql: case when ${productplatform} in ('Diet Analysis Plus', 'Write Experience', 'Insite', 'Speech Studio') then 'Other platforms'
              when ${productplatform} = '4LTR Online' then '4LTR'
              else ${productplatform} end;;
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden: yes
    primary_key: yes
  }

  measure: count {
    label: "No. of product platforms"
    type: count
    drill_fields: []
    hidden: yes
  }
}
