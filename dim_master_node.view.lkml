view: dim_master_node {
  label: "Master Learning Path"
  sql_table_name: DW_GA.DIM_MASTER_NODE_V ;;

  dimension: first_used_datekey {
    type: number
    sql: ${TABLE}.firstdatekey ;;
    hidden: yes
  }

  dimension: snapshot_status {
    label: "Status"
    type: string
    sql: case when ${masternodeid} > -1 then 'Core item' else 'Added to snapshot' end ;;
  }

  dimension: level1 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level1 else 'New Item - ' || ${dim_learningpath.level1} end ;;
    order_by_field: level1_displayorder
    drill_fields: [level2, lowest_level]
  }

  dimension: level1_displayorder {
    type: string
    sql: ${TABLE}.LEVEL1_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level2 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level2 else 'New Item - ' || ${dim_learningpath.level2} end ;;
    order_by_field: level2_displayorder
    drill_fields: [level3, lowest_level]
  }

  dimension: level2_displayorder {
    type: string
    sql: ${TABLE}.LEVEL2_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level3 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level3 else 'New Item - ' || ${dim_learningpath.level3} end ;;
    order_by_field: level3_displayorder
    drill_fields: [level4, lowest_level]
  }

  dimension: level3_displayorder {
    type: string
    sql: ${TABLE}.LEVEL3_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level4 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level4 else 'New Item - ' || ${dim_learningpath.level4} end ;;
    order_by_field: level4_displayorder
    drill_fields: [level5, lowest_level]
  }

  dimension: level4_displayorder {
    type: string
    sql: ${TABLE}.LEVEL4_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level5 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level5 else 'New Item - ' || ${dim_learningpath.level5} end ;;
    order_by_field: level5_displayorder
  }

  dimension: level5_displayorder {
    type: string
    sql: ${TABLE}.LEVEL5_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level6 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level6 else 'New Item - ' || ${dim_learningpath.level6} end ;;
  }

  dimension: level7 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level7 else 'New Item - ' || ${dim_learningpath.level7} end ;;
  }

  dimension: level8 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level8 else 'New Item - ' || ${dim_learningpath.level8} end ;;
  }

  dimension: level9 {
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level9 else 'New Item - ' || ${dim_learningpath.level9} end ;;
  }

  dimension:  lowest_level_sort {
    type:  number
    hidden: no
    sql: (ifnull(${level1_displayorder}+1, 1) * 10000000) + (ifnull(${level2_displayorder}+1, 1) * 1000000) + (ifnull(${level3_displayorder}+1, 1) * 10000) + (ifnull(${level4_displayorder}+1, 1) * 100) + ifnull(${level5_displayorder}+1, 1) ;;
  }

  dimension: lowest_level {
    label: "Lowest Level"
    type: string
    sql: COALESCE(${TABLE}.LEVEL9,${TABLE}.LEVEL8,${TABLE}.LEVEL7,${TABLE}.LEVEL6,${TABLE}.LEVEL5,${TABLE}.LEVEL4,${TABLE}.LEVEL3,${TABLE}.LEVEL2) ;;
    order_by_field: lowest_level_sort
  }

  dimension: mastercoursename {
    label: "Master Course Name"
    type: string
    sql: ${TABLE}.MASTERCOURSENAME ;;
  }

  dimension: masternodeid {
    type: string
    sql: ${TABLE}.MASTERNODEID ;;
    hidden: yes
    primary_key: yes
  }

  measure: count {
    type: count
    drill_fields: [mastercoursename]
  }
}
