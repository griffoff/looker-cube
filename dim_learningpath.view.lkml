view: dim_learningpath {
  label: "Learning Path"
  sql_table_name: DW_GA.DIM_LEARNINGPATH ;;

  dimension: eventtypeid {
    type: string
    sql: ${TABLE}.EVENTTYPEID ;;
    hidden: yes
  }

  dimension: learningcourse {
    label: "Course Name"
    type: string
    sql: ${TABLE}.LEARNINGCOURSE ;;
  }

  dimension: learningpathid {
    type: string
    sql: ${TABLE}.LEARNINGPATHID ;;
    hidden: yes
  }

  dimension: learningtype {
    label: "Type"
    type: string
    sql: ${TABLE}.LEARNINGTYPE ;;
  }

  dimension: level1 {
    type: string
    sql: ${TABLE}.LEVEL1 ;;
    order_by_field: level1_displayorder
  }

  dimension: level1_displayorder {
    type: string
    sql: ${TABLE}.LEVEL1_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level2 {
    type: string
    sql: ${TABLE}.LEVEL2 ;;
    order_by_field: level2_displayorder
  }

  dimension: level2_displayorder {
    type: string
    sql: ${TABLE}.LEVEL2_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level3 {
    type: string
    sql: ${TABLE}.LEVEL3 ;;
    order_by_field: level3_displayorder
  }

  dimension: level3_displayorder {
    type: string
    sql: ${TABLE}.LEVEL3_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level4 {
    type: string
    sql: ${TABLE}.LEVEL4 ;;
    order_by_field: level4_displayorder
  }

  dimension: level4_displayorder {
    type: string
    sql: ${TABLE}.LEVEL4_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level5 {
    type: string
    sql: ${TABLE}.LEVEL5 ;;
    order_by_field: level5_displayorder
  }

  dimension: level5_displayorder {
    type: string
    sql: ${TABLE}.LEVEL5_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level6 {
    type: string
    sql: ${TABLE}.LEVEL6 ;;
  }

  dimension: level7 {
    type: string
    sql: ${TABLE}.LEVEL7 ;;
  }

  dimension: level8 {
    type: string
    sql: ${TABLE}.LEVEL8 ;;
  }

  dimension: level9 {
    type: string
    sql: ${TABLE}.LEVEL9 ;;
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

  dimension:  lowest_level_category {
    label: "Lowest LP Level category"
    description: "More useful categorization for awesomeness"
    type: string
    sql: case when ${lowest_level} ilike '%Mastery Training%' then 'Mastery Training'
              when ${lowest_level} ilike '%Quiz%' then 'Quiz'
              when ${lowest_level} ilike '%Practice Test%' then 'Practice Test'
              when ${lowest_level} ilike '%COMPLETE Apply%' then 'Complete Apply'
              when ${lowest_level} ilike '%COMPLETE Research%' then 'Complete Research'
              when ${lowest_level} ilike '%START Zoom%' then 'Start Zoom'
              else 'Uncategorized'
              end;;
  }

  dimension: masternodeid {
    type: string
    sql: ${TABLE}.MASTERNODEID ;;
    hidden: no
  }

  dimension: origname {
    label: "Original name"
    type: string
    sql: ${TABLE}.ORIGNAME ;;
    hidden: yes
  }

  dimension: origsequence {
    type: string
    sql: ${TABLE}.ORIGSEQUENCE ;;
    hidden: yes
  }

  dimension: parentlearningpathid {
    type: string
    hidden: yes
    sql: ${TABLE}.PARENTLEARNINGPATHID ;;
  }

  measure: count {
    label: "No. of learning path items"
    type: count
  }
}

#drill_fields: [*]
