- view: dim_learningpath
  label: 'Learning Path'
  sql_table_name: DW_GA.DIM_LEARNINGPATH
  fields:

  - dimension: eventtypeid
    type: string
    sql: ${TABLE}.EVENTTYPEID
    hidden: true

  - dimension: learningcourse
    label: 'Course Name'
    type: string
    sql: ${TABLE}.LEARNINGCOURSE
    
  - dimension: learningpathid
    type: string
    sql: ${TABLE}.LEARNINGPATHID
    hidden: true
    
  - dimension: learningtype
    label: 'Type'
    type: string
    sql: ${TABLE}.LEARNINGTYPE

  - dimension: level1
    type: string
    sql: ${TABLE}.LEVEL1
    order_by_field: level1_displayorder

  - dimension: level1_displayorder
    type: string
    sql: ${TABLE}.LEVEL1_DISPLAYORDER
    hidden: true

  - dimension: level2
    type: string
    sql: ${TABLE}.LEVEL2
    order_by_field: level2_displayorder

  - dimension: level2_displayorder
    type: string
    sql: ${TABLE}.LEVEL2_DISPLAYORDER
    hidden: true

  - dimension: level3
    type: string
    sql: ${TABLE}.LEVEL3
    order_by_field: level3_displayorder

  - dimension: level3_displayorder
    type: string
    sql: ${TABLE}.LEVEL3_DISPLAYORDER
    hidden: true

  - dimension: level4
    type: string
    sql: ${TABLE}.LEVEL4
    order_by_field: level4_displayorder

  - dimension: level4_displayorder
    type: string
    sql: ${TABLE}.LEVEL4_DISPLAYORDER
    hidden: true

  - dimension: level5
    type: string
    sql: ${TABLE}.LEVEL5
    order_by_field: level5_displayorder
    
  - dimension: level5_displayorder
    type: string
    sql: ${TABLE}.LEVEL5_DISPLAYORDER
    hidden: true

  - dimension: level6
    type: string
    sql: ${TABLE}.LEVEL6

  - dimension: level7
    type: string
    sql: ${TABLE}.LEVEL7

  - dimension: level8
    type: string
    sql: ${TABLE}.LEVEL8

  - dimension: level9
    type: string
    sql: ${TABLE}.LEVEL9

  - dimension: masternodeid
    type: string
    sql: ${TABLE}.MASTERNODEID
    hidden: true

  - dimension: origname
    label: 'Original name'
    type: string
    sql: ${TABLE}.ORIGNAME
    hidden: true
  
  - dimension: origsequence
    type: string
    sql: ${TABLE}.ORIGSEQUENCE
    hidden: true

  - dimension: parentlearningpathid
    type: string
    hidden: true
    sql: ${TABLE}.PARENTLEARNINGPATHID

  - measure: count
    label: 'No. of learning path items'
    type: count
    #drill_fields: [*]

