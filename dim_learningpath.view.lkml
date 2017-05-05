view: lp_node_map {
  label: "Map to Mindtap Source"
  derived_table: {
    sql:
    select distinct dl.learningpathid, f.id as node_id, n.snapshot_id
      from dw_ga.fact_activity f
      join dw_ga.dim_learningpath dl on f.learningpathid=dl.learningpathid
      join stg_mindtap.node n on f.id = n.id
      ;;
  }

  dimension: learningpathid {
    type:  number
    sql: ${TABLE}.learningpathid ;;
    hidden: yes
  }

  dimension: nodeid {
    type:  number
    sql: ${TABLE}.node_id ;;
    link: {
      label: "Source - MindTap"
      url: "/explore/source/snapshot?fields=node.id,node.name,node.count,app.display_name,&f[node.id]={{ value }}"
    }
  }

  dimension: snapshotid {
    type:  number
    sql: ${TABLE}.snapshot_id ;;
    link: {
      label: "Source - MindTap"
      url: "/explore/source/snapshot?fields=snapshot.id,node.name,app.display_name,&f[snapshot.id]={{ value }}"
    }
  }

}

view: dim_learningpath {
  label: "Learning Path"
  #sql_table_name: DW_GA.DIM_LEARNINGPATH ;;
  derived_table: {
    sql:
    select
        lp.learningpathid
        ,lp.learningcourse
        ,coalesce(m.level1, lp.level1) as level1
        ,coalesce(m.level2, lp.level2) as level2
        ,coalesce(m.level3, lp.level3) as level3
        ,coalesce(m.level4, lp.level4) as level4
        ,coalesce(m.level5, lp.level5) as level5
        ,coalesce(m.level6, lp.level6) as level6
        ,coalesce(m.level7, lp.level7) as level7
        ,coalesce(m.level8, lp.level8) as level8
        ,coalesce(m.level9, lp.level9) as level9
        ,coalesce(m.level1_displayorder, lp.level1_displayorder) as level1_displayorder
        ,coalesce(m.level2_displayorder, lp.level2_displayorder) as level2_displayorder
        ,coalesce(m.level3_displayorder, lp.level3_displayorder) as level3_displayorder
        ,coalesce(m.level4_displayorder, lp.level4_displayorder) as level4_displayorder
        ,coalesce(m.level5_displayorder, lp.level5_displayorder) as level5_displayorder
        ,lp.learningtype
        ,lp.eventtypeid
        ,lp.origname
        ,lp.origsequence
        ,lp.parentlearningpathid
        ,lp.masternodeid
        ,f.firstdatekey
        ,case when lp.masternodeid = -1 then -1 else min(f.firstdatekey) over (partition by lp.masternodeid) end as masterfirstdatekey
        ,case when lp.masternodeid = -1
          then
              COALESCE(lp.LEVEL9,lp.LEVEL8,lp.LEVEL7,lp.LEVEL6,lp.LEVEL5,lp.LEVEL4,lp.LEVEL3,lp.LEVEL2)
          else
              COALESCE(m.LEVEL9,m.LEVEL8,m.LEVEL7,m.LEVEL6,m.LEVEL5,m.LEVEL4,m.LEVEL3,m.LEVEL2)
          end as lowest_level
    from DW_GA.DIM_LEARNINGPATH lp
    LEFT JOIN DW_GA.DIM_MASTER_NODE m  ON lp.MASTERNODEID = m.MASTERNODEID and lp.masternodeid != -1
    left join (
        select
            learningpathid, min(startdatekey) as firstdatekey
        from dw_ga.fact_activityoutcome
        group by 1
        ) f on lp.learningpathid = f.learningpathid
    ;;

    sql_trigger_value: select count(*) from dw_ga.dim_learningpath ;;
  }

  dimension: first_used_datekey {
    type: number
    sql: ${TABLE}.firstdatekey ;;
    hidden: yes
  }

  dimension: master_first_used_datekey {
    type: number
    sql: ${TABLE}.masterfirstdatekey ;;
    hidden: yes
  }

  dimension: eventtypeid {
    type: string
    sql: ${TABLE}.EVENTTYPEID ;;
    hidden: yes
  }

  dimension: snapshot_status {
    label: "Status"
    type: string
    sql: case when ${masternodeid} > -1 then 'Core item' else 'Added to snapshot' end ;;
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
    #sql: COALESCE(${TABLE}.LEVEL9,${TABLE}.LEVEL8,${TABLE}.LEVEL7,${TABLE}.LEVEL6,${TABLE}.LEVEL5,${TABLE}.LEVEL4,${TABLE}.LEVEL3,${TABLE}.LEVEL2) ;;
    sql: ${TABLE}.lowest_level ;;
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
    hidden: yes
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
