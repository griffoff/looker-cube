- view: dim_master_node
  label: 'Master Learning Path'
  sql_table_name: DW_GA.DIM_MASTER_NODE
  fields:
  
  - dimension: snapshot_status
    label: 'Status'
    type: string
    sql: case when ${masternodeid} > -1 then 'Core item' else 'Added to snapshot' end

  - dimension: level1
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level1 else 'New Item - ' || ${dim_learningpath.level1} end
    order_by_field: level1_displayorder

  - dimension: level1_displayorder
    type: string
    sql: ${TABLE}.LEVEL1_DISPLAYORDER
    hidden: true

  - dimension: level2
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level2 else 'New Item - ' || ${dim_learningpath.level2} end
    order_by_field: level2_displayorder

  - dimension: level2_displayorder
    type: string
    sql: ${TABLE}.LEVEL2_DISPLAYORDER
    hidden: true

  - dimension: level3
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level3 else 'New Item - ' || ${dim_learningpath.level3} end
    order_by_field: level3_displayorder

  - dimension: level3_displayorder
    type: string
    sql: ${TABLE}.LEVEL3_DISPLAYORDER
    hidden: true

  - dimension: level4
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level4 else 'New Item - ' || ${dim_learningpath.level4} end
    order_by_field: level4_displayorder

  - dimension: level4_displayorder
    type: string
    sql: ${TABLE}.LEVEL4_DISPLAYORDER
    hidden: true

  - dimension: level5
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level5 else 'New Item - ' || ${dim_learningpath.level5} end
    order_by_field: level5_displayorder
    
  - dimension: level5_displayorder
    type: string
    sql: ${TABLE}.LEVEL5_DISPLAYORDER
    hidden: true

  - dimension: level6
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level6 else 'New Item - ' || ${dim_learningpath.level6} end

  - dimension: level7
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level7 else 'New Item - ' || ${dim_learningpath.level7} end

  - dimension: level8
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level8 else 'New Item - ' || ${dim_learningpath.level8} end

  - dimension: level9
    type: string
    sql: case when ${masternodeid} > -1 then ${TABLE}.level9 else 'New Item - ' || ${dim_learningpath.level9} end

  - dimension: mastercoursename
    label: 'Master Course Name'
    type: string
    sql: ${TABLE}.MASTERCOURSENAME

  - dimension: masternodeid
    type: string
    sql: ${TABLE}.MASTERNODEID
    hidden: true
    primary_key: true

  - measure: count
    type: count
    drill_fields: [mastercoursename]

