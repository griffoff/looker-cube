view: lp_node_map {
  label: "Learning Path"
  derived_table: {
    sql:
    select distinct dl.learningpathid, f.id as node_id, n.snapshot_id
      from dw_ga.fact_activity f
      join dw_ga.dim_learningpath dl on f.learningpathid=dl.learningpathid
      join stg_mindtap.node n on f.id = n.id
      ;;
      sql_trigger_value: select count(*) from dw_ga.fact_activity ;;
  }

  dimension: learningpathid {
    type:  number
    sql: ${TABLE}.learningpathid ;;
    hidden: yes
  }

  dimension: nodeid {
    group_label: "Source Links"
    type:  number
    sql: ${TABLE}.node_id ;;
    link: {
      label: "Source - MindTap"
      url: "/explore/source/snapshot?fields=node.id,node.name,node.count,app.display_name,&f[node.id]={{ value }}"
    }
  }

  dimension: snapshotid {
    group_label: "Source Links"
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
    with lp as (
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
          ,min(coalesce(m.level1_displayorder, lp.level1_displayorder)) over (partition by lp.masternodeid) as level1_displayorder
          ,min(coalesce(m.level2_displayorder, lp.level2_displayorder)) over (partition by lp.masternodeid) as level2_displayorder
          ,min(coalesce(m.level3_displayorder, lp.level3_displayorder)) over (partition by lp.masternodeid) as level3_displayorder
          ,min(coalesce(m.level4_displayorder, lp.level4_displayorder)) over (partition by lp.masternodeid) as level4_displayorder
          ,min(coalesce(m.level5_displayorder, lp.level5_displayorder)) over (partition by lp.masternodeid) as level5_displayorder
          ,lp.learningtype
          ,lp.eventtypeid
          ,lp.origname
          ,lp.origsequence
          ,lp.parentlearningpathid
          ,lp.masternodeid
          ,f.firstdatekey
          ,f.global_avg_score
          ,case when lp.masternodeid = -1 then -1 else min(f.firstdatekey) over (partition by lp.masternodeid) end as masterfirstdatekey
          ,case when lp.masternodeid = -1
            then
                (ifnull(lp.level1_displayorder+1, 1) * 10000000) + (ifnull(lp.level2_displayorder+1, 1) * 1000000) + (ifnull(lp.level3_displayorder+1, 1) * 10000) + (ifnull(lp.level4_displayorder+1, 1) * 100) + ifnull(lp.level5_displayorder+1, 1)
            else
                (ifnull(m.level1_displayorder+1, 1) * 10000000) + (ifnull(m.level2_displayorder+1, 1) * 1000000) + (ifnull(m.level3_displayorder+1, 1) * 10000) + (ifnull(m.level4_displayorder+1, 1) * 100) + ifnull(m.level5_displayorder+1, 1)
            end as lowest_level_sort_base
          ,case when lp.masternodeid = -1
            then
                COALESCE(lp.LEVEL9,lp.LEVEL8,lp.LEVEL7,lp.LEVEL6,lp.LEVEL5,lp.LEVEL4,lp.LEVEL3,lp.LEVEL2, 'UNKNOWN')
            else
                COALESCE(m.LEVEL9,m.LEVEL8,m.LEVEL7,m.LEVEL6,m.LEVEL5,m.LEVEL4,m.LEVEL3,m.LEVEL2, 'UNKNOWN')
            end as lowest_level
      from DW_GA.DIM_LEARNINGPATH lp
      LEFT JOIN DW_GA.DIM_MASTER_NODE m  ON lp.MASTERNODEID = m.MASTERNODEID and lp.masternodeid != -1
      left join (
          select
              learningpathid
              ,min(startdatekey) as firstdatekey
              ,nullif(avg(case when SCORE > 100 then 100 when SCORE <0 then null else SCORE end / 100.0), 0) as global_avg_score
          from dw_ga.fact_activityoutcome
          group by 1
          ) f on lp.learningpathid = f.learningpathid
          --where lp.learningtype = 'Activity'
    )
    --derive the most popular day of activity, for sorting purposes (assuming the most popular day is when it is scheduled in the LP)
   ,o as (
      select
        fsu.daysfromcoursestart
        ,decode(dlp.masternodeid, -1, dlp.learningpathid, dlp.masternodeid) as lpid
        ,dense_rank() over (partition by decode(dlp.masternodeid, -1, dlp.learningpathid, dlp.masternodeid) order by count(*) desc ) as r
      from dw_ga.fact_siteusage fsu
      inner join dw_ga.dim_learningpath dlp on fsu.learningpathid = dlp.learningpathid
      where daysfromcoursestart > 0
      group by 1, 2
      order by 3, 2
    )
    ,lporder as
    (
      select daysfromcoursestart, lpid
      from o
      where r = 1
    )
    ,struct_choices as
    (
      select
          lp.learningpathid
          ,lp.lowest_level
          ,plp.learninggroup
          ,plp.learningunit
          ,case when plp.learninggroup is null then 0 else count(*) over (partition by plp.learninggroup) end as similar_items
      from lp
      inner join dw_ga.parentlearningpath plp on lp.parentlearningpathid = plp.parentlearningpathid
    )
    ,struct as
    (
      select
          learningpathid
          ,first_value(learninggroup) over (partition by lowest_level order by similar_items desc) as folder
          ,first_value(learningunit) over (partition by lowest_level order by similar_items desc) as chapter
      from struct_choices
    )
    ,node_map as
    (
      select learningpathid, max(node_id) node_id
      from ${lp_node_map.SQL_TABLE_NAME}
      group by 1
    )
    select
        lp.*
        ,min(lowest_level_sort_base) over (partition by lowest_level) as lowest_level_sort_by_data
        ,min(lporder.daysfromcoursestart) over (partition by lowest_level) as lowest_level_sort_by_usage
        ,s.folder
        ,s.chapter
        ,case when count(distinct lp.lowest_level) over (partition by s.folder) < 10
              then s.folder
              else lp.lowest_level
              end as compound_activity
        ,case when count(distinct lp.lowest_level) over (partition by s.folder) < 10
              then true
              else false
              end as is_compound_activity
        ,node_map.node_id
    from lp
    left join lporder on decode(lp.masternodeid, -1, lp.learningpathid, lp.masternodeid) = lporder.lpid
    left join struct s on lp.learningpathid = s.learningpathid
    left join node_map on lp.learningpathid = node_map.learningpathid
    order by lp.learningpathid
    ;;

    sql_trigger_value: select count(*) from dw_ga.dim_learningpath ;;
  }

  dimension: node_id {
    hidden: yes
  }

  dimension:  lowest_level_group {
    label: "Learning Path Activity Folder"
    group_label: "NEW FIELDS"
    description: "the text before ':' or blank if no colon exists in the text"
    type: string
    sql: case when array_size(split(${lowest_level}, ':')) = 2 then split_part(${lowest_level}, ':', 1) end ;;
  }

  dimension: folder {
    group_label: "NEW FIELDS"
    description: "based on existing 'parentlearningpath' - needs work to make it related to master"
  }

  dimension: chapter {
    group_label: "NEW FIELDS"
    description: "based on existing 'parentlearningpath' - needs work to make it related to master"

  }

  dimension: is_compound_activity {
    group_label: "NEW FIELDS"
    description: "'Yes' if activity is one of less than 10 activities in its parent folder"
    type: yesno
  }

  dimension: compound_activity {
    group_label: "NEW FIELDS"
    description: "Activity name or Folder name if activity is one of less than 10 activities in its parent folder"

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
    label: "Status vs Master"
    description: "Was this a core item or was it added to the snapshot"
    type: string
    sql: case when ${masternodeid} > -1 then 'Core item' else 'Added to snapshot' end ;;
  }

  dimension: learningcourse {
    label: "Course Name"
    type: string
    sql: ${TABLE}.LEARNINGCOURSE ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: level1 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL1 ;;
    order_by_field: level1_displayorder
  }

  dimension: level1_displayorder {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL1_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level2 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL2 ;;
    order_by_field: level2_displayorder
  }

  dimension: level2_displayorder {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL2_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level3 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL3 ;;
    order_by_field: level3_displayorder
  }

  dimension: level3_displayorder {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL3_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level4 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL4 ;;
    order_by_field: level4_displayorder
  }

  dimension: level4_displayorder {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL4_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level5 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL5 ;;
    order_by_field: level5_displayorder
  }

  dimension: level5_displayorder {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL5_DISPLAYORDER ;;
    hidden: yes
  }

  dimension: level6 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL6 ;;
  }

  dimension: level7 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL7 ;;
  }

  dimension: level8 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL8 ;;
  }

  dimension: level9 {
    group_label: "Levels"
    type: string
    sql: ${TABLE}.LEVEL9 ;;
  }

  dimension:  lowest_level_sort_by_usage {
    label: "Learning path sort order (by relative usage date)"
    type:  number
    hidden: yes
    sql: ${TABLE}.lowest_level_sort_by_usage ;;
    skip_drill_filter: yes
  }

  dimension:  lowest_level_sort_by_data {
    label: "Learning path sort order (by data)"
    type:  number
    hidden: yes
    sql: ${TABLE}.lowest_level_sort_by_data ;;
    skip_drill_filter: yes
  }

  dimension: lowest_level {
    label: "Learning Path Activity Title"
    type: string
    sql: ${TABLE}.lowest_level ;;
    order_by_field: lowest_level_sort_by_data

    link: {
      label: "Explore Aplia question level data this activity"
      url: "/explore/source/problem?fields=problem.problem_title,answer.avg_score,answer.count,assignment.count,course.count&f[assignment.mindlink_guid]={{ dim_activity_view_uri.ref_id._value }}"
    }
  }

  dimension:  lowest_level_category {
    label: "Learning Path Activity Group"
    description: "Categorization of learning path items into useful groups - groups are driven by product team requests"
    type: string
    sql: case
              when ${dim_activity.APPLICATIONNAME} in ('CNOW.HW', 'APLIA') then 'Assessment'

              when ${lowest_level} ilike '%Mastery Training%' then 'Mastery Training'
              when ${lowest_level} ilike '%Quiz%' then 'Quiz'
              when ${lowest_level} ilike '%Practice Test%' then 'Practice Test'
              when ${lowest_level} ilike '%COMPLETE Apply%' then 'Complete Apply'
              when ${lowest_level} ilike '%COMPLETE Research%' then 'Complete Research'
              when ${lowest_level} ilike '%START Zoom%' then 'Start Zoom'
              when ${lowest_level} ilike '%Concept Check%' then 'Concept Check'
              --CJ
              when ${lowest_level} ilike '%Visual Summary%' then 'Visual Summary'
              when ${lowest_level} ilike '%Choose your path%' then 'You Decide - Part 1'
              when ${lowest_level} ilike '%Justify your choice%' then 'You Decide - Part 2'
              when ${lowest_level} ilike '%Skill Builder%' then 'Skill Builder'
              when ${lowest_level} ilike '%Video Case%' then 'Video Cases'
              when ${lowest_level} ilike '%Case Study%' then 'Case Study'
              when ${lowest_level} ilike '%Essay%' then 'Essay'
              when ${lowest_level} ilike '%Reading%' then 'Reading'
              when ${lowest_level} ilike '%Post Test%' then 'Post Test'
              when ${lowest_level} ilike '%Real World Challenge%' then 'Real World Challenge'
              when ${lowest_level} ilike '%Exam%' then 'Exam'
              --generic
              when ${dim_activity.APPLICATIONNAME} = 'CENGAGE.READER' then 'Reading'
              when ${dim_activity.APPLICATIONNAME} = 'CENGAGE.MEDIA' then 'Media'
              when ${dim_activity.APPLICATIONNAME} = 'MINDAPP-GROVE' then 'Media Quiz'
              --when ${dim_activity.APPLICATIONNAME} in ('CNOW.HW', 'APLIA') then 'Assessment'

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
    label: "# Learning path items"
    type: count
  }

  measure:  count_gradable {
    label: "# Gradable items"
    type: sum
    sql: ${dim_activity.count_gradable};;
    hidden: yes
  }

  measure:  gradable_percent {
    label: "% Gradable"
    description: "proportion of times activity was gradable"
    type: number
    sql:  ${count_gradable}/${count};;
    value_format_name: percent_1
    hidden: yes
  }

  measure: global_avg_score {
    label: "Global Avg. Score"
    type: min
    value_format_name: percent_1
  }
}

#drill_fields: [*]
