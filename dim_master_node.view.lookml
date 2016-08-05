- view: dim_master_node
  sql_table_name: DW_GA.DIM_MASTER_NODE
  fields:

  - dimension: level1
    type: string
    sql: ${TABLE}.LEVEL1

  - dimension: level1_displayorder
    type: string
    sql: ${TABLE}.LEVEL1_DISPLAYORDER

  - dimension: level2
    type: string
    sql: ${TABLE}.LEVEL2

  - dimension: level2_displayorder
    type: string
    sql: ${TABLE}.LEVEL2_DISPLAYORDER

  - dimension: level3
    type: string
    sql: ${TABLE}.LEVEL3

  - dimension: level3_displayorder
    type: string
    sql: ${TABLE}.LEVEL3_DISPLAYORDER

  - dimension: level4
    type: string
    sql: ${TABLE}.LEVEL4

  - dimension: level4_displayorder
    type: string
    sql: ${TABLE}.LEVEL4_DISPLAYORDER

  - dimension: level5
    type: string
    sql: ${TABLE}.LEVEL5

  - dimension: level5_displayorder
    type: string
    sql: ${TABLE}.LEVEL5_DISPLAYORDER

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

  - dimension: mastercoursename
    type: string
    sql: ${TABLE}.MASTERCOURSENAME

  - dimension: masternodeid
    type: string
    sql: ${TABLE}.MASTERNODEID

  - measure: count
    type: count
    drill_fields: [mastercoursename]

