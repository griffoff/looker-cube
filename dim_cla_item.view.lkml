view: dim_cla_item {
  label: "CLA Events"
  derived_table: {
    sql: with alltables as (
          select metadata_Item_type,CGI,ASSESSMENT_TYPE,SUB_FOLDER_1::String as Folder from UPLOADS.wl_metadata_atelier_master.MASTER_CGIDESC
          UNION ALL
          select metadata_Item_type,CGI,ASSESSMENT_TYPE,SUB_FOLDER_1::String from UPLOADS.wl_metadata_rutas_master.MASTER_CGIDESC
          UNION ALL
          select metadata_Item_type,CGI,ASSESSMENT_TYPE,FOLDER_1::String from UPLOADS.wl_metadata_plazas_master.MASTER_CGIDESC
          UNION ALL
          select metadata_Item_type,CGI,ASSESSMENT_TYPE,FOLDER_1::String from UPLOADS.wl_metadata_juntos_master.MASTER_CGIDESC
          UNION ALL
          select metadata_Item_type,CGI,ASSESSMENT_TYPE,FOLDER_1::String from UPLOADS.wl_metadata_horizons_master.MASTER_CGIDESC
         )
         Select * from alltables a
         left join PROD.DW_GA.DIM_CLA_ITEM i
         on a.CGI = i.SUBACTIVITYCGI
       ;;
  }

  dimension: metadata_item_type {
    type: string
    sql: LOWER(${TABLE}.METADATA_ITEM_TYPE) ;;
  }

  dimension: cgi {
    type: string
    sql: ${TABLE}.CGI ;;
  }

  dimension: assessment_type {
    type: string
    sql: LOWER(${TABLE}.ASSESSMENT_TYPE) ;;
  }

  dimension: folder {
    type: string
    sql: ${TABLE}.FOLDER ;;
  }

  dimension: activitycgi {
    type: string
    hidden: yes
    sql: ${TABLE}.ACTIVITYCGI ;;
  }

  dimension: cla_itemid {
    type: number
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.CLA_ITEMID ;;
  }

  dimension: cla_itemname {
    label: "Item Name"
    description: "To be added"
    type: string
    sql: ${TABLE}.CLA_ITEMNAME ;;
  }

  dimension: dw_ldid {
    type: number
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.DW_LDID ;;
  }

  dimension: dw_ldts {
    type: string
    hidden: yes
    sql: ${TABLE}.DW_LDTS ;;
  }

  dimension: learningpathid {
    type: number
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.LEARNINGPATHID ;;
  }

  dimension: subactivitycgi {
    type: string
    hidden: yes
    sql: ${TABLE}.SUBACTIVITYCGI ;;
  }

  dimension: subactivitytype {
    type: string
    sql: ${TABLE}.SUBACTIVITYTYPE ;;
  }

  measure: count {
    type: count
    drill_fields: [cla_itemname]
  }
}
