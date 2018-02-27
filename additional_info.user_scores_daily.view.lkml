view: user_scores_daily {
  view_label: "User"
  derived_table: {
    sql:
    with course_user as (
      select
        ao.snapshot_id
        ,ao.user_id
        ,max(1+datediff(day, dc.startdate, to_timestamp(ao.created_date, 3))) as user_last_day_of_course
      from mindtap.prod_nb.activity_outcome ao
      inner join mindtap.prod_nb.snapshot s on ao.snapshot_id = s.id
      inner join mindtap.prod_nb.org o on s.org_id = o.id
      inner join dw_ga.dim_course dc on o.external_id = dc.coursekey
    --  where dc.coursekey = '477253243512284895110399620-0B2F95DE23FAF48C76EF1FFF744F6AE8E3D3E139304960D7BC1173E00F69FF82'
      group by 1, 2
    )
    ,course as (
      select
        snapshot_id
        ,max(user_last_day_of_course) as last_day_of_course
      from course_user
      group by 1
    )
    ,all_days as (
      select seq4() as day_of_course
      from table(generator(rowcount => 500))
    )
    ,course_user_days as (
      select u.snapshot_id, u.user_id, day_of_course
      from course_user u
      inner join course c on u.snapshot_id = c.snapshot_id
      inner join all_days d on day_of_course between 1 and c.last_day_of_course
    )
    ,activities as (
      select
        ao.snapshot_id
        ,ao.user_id
        ,a.is_gradable
        ,ao.points_possible
        ,case when ao.points_earned > ao.points_possible then ao.points_possible else ao.points_earned end as points_earned
        ,1+datediff(day, dc.startdate, to_timestamp(ao.created_date, 3)) as day_of_course
      from mindtap.prod_nb.activity_outcome ao
      inner join mindtap.prod_nb.activity a on ao.activity_id = a.id
      inner join mindtap.prod_nb.snapshot s on ao.snapshot_id = s.id
      inner join mindtap.prod_nb.org o on s.org_id = o.id
      inner join dw_ga.dim_course dc on o.external_id = dc.coursekey
    )
    select
        d.day_of_course
        ,dc.courseid || '.' || dp.partyid || '.' || d.day_of_course as pk
        ,u.source_id as sso_guid
        ,dc.courseid
        ,dp.partyid
        ,sum(ao.points_earned) as daily_points_earned
        ,sum(ao.points_possible) as daily_points_possible
        ,daily_points_earned / nullif(daily_points_possible, 0)::float as daily_score
        ,sum(daily_points_earned) over (partition by sso_guid order by d.day_of_course rows unbounded preceding) as to_date_points_earned
        ,sum(daily_points_possible) over (partition by sso_guid order by d.day_of_course rows unbounded preceding) as to_date_points_possible
        ,to_date_points_earned / nullif(to_date_points_possible, 0)::float as to_date_score
        ,sum(case when d.day_of_course < 15 then daily_points_earned end) over (partition by sso_guid) as week2_points_earned
        ,sum(case when d.day_of_course < 15 then daily_points_possible end) over (partition by sso_guid) as week2_points_possible
        ,week2_points_earned / nullif(week2_points_possible, 0)::float as week2_score
        ,sum(case when d.day_of_course < 8 then daily_points_earned end) over (partition by sso_guid) as week1_points_earned
        ,sum(case when d.day_of_course < 8 then daily_points_possible end) over (partition by sso_guid) as week1_points_possible
        ,week1_points_earned / nullif(week1_points_possible, 0)::float as week1_score
    from course_user_days d
    inner join mindtap.prod_nb.user u on d.user_id = u.id
    inner join dw_ga.dim_party dp on u.source_id = dp.guid
    inner join mindtap.prod_nb.snapshot s on d.snapshot_id = s.id
    inner join mindtap.prod_nb.org o on s.org_id = o.id
    inner join dw_ga.dim_course dc on o.external_id = dc.coursekey
    left join activities ao on d.snapshot_id = ao.snapshot_id
                            and d.user_id = ao.user_id
                            and ao.day_of_course = d.day_of_course
                            and ao.is_gradable
    group by 1, 2, 3, 4, 5
    order by courseid, partyid, d.day_of_course
    ;;
    sql_trigger_value: select count(*) from stg_mindtap.activity_outcome_summary ;;
  }

  dimension: courseid {hidden:yes}
  dimension: partyid {hidden:yes}
  dimension: day_of_course {}
  dimension: sso_guid {hidden:yes}
  dimension: pk {hidden:yes primary_key:yes}

  dimension: daily_points_earned {group_label: "Scores" label: "Daily Points Earned (In MindTap)" hidden:yes}
  dimension: daily_points_possible {group_label: "Scores" label: "Daily Points Possible (In MindTap)" hidden:yes}
  dimension: daily_score {group_label: "Scores" label: "Daily Score (In MindTap)" sql: round(${TABLE}.daily_score, 3);;}
  dimension: daily_score_category {
    group_label: "Scores"
    label: "Daily Score Category (In MindTap)"
    type: tier
    tiers: [0.5, 0.74, 0.89]
    style: relational
    sql: ${daily_score} ;;
    value_format_name: percent_0
  }
  measure: daily_score_avg {
    group_label: "Scores"
    label: "Daily Score (Avg)"
    type: average
    sql: ${daily_score} ;;
    value_format_name: percent_1
  }
  dimension: to_date_points_earned {group_label: "Scores" label: "Points Earned To Date (In MindTap)" hidden:yes}
  dimension: to_date_points_possible {group_label: "Scores" label: "Points Possible To Date (In MindTap)" hidden:yes}
  dimension: to_date_score {group_label: "Scores" label: "Score to Date (In MindTap)" sql: round(${TABLE}.to_date_score, 3) ;; value_format_name: percent_1}
  dimension: to_date_score_category {
    group_label: "Scores"
    label: "Score to Date Category (In MindTap)"
    type: tier
    tiers: [0.5, 0.74, 0.89]
    style: relational
    sql: ${to_date_score} ;;
    value_format_name: percent_0
  }
  measure: to_date_score_avg {
    group_label: "Scores"
    label: "Score to Date (Avg)"
    type: average
    sql: ${to_date_score} ;;
    value_format_name: percent_1
  }
  dimension: week2_points_earned {group_label: "Scores" label: "week2 Points Earned (In MindTap)" hidden:yes}
  dimension: week2_points_possible {group_label: "Scores" label: "week2 Points Possible (In MindTap)" hidden:yes}
  dimension: week2_score {group_label: "Scores" label: "Week 2 Score (In MindTap)" sql: round(${TABLE}.week2_score, 3);;}
  dimension: week2_score_category {
    group_label: "Scores"
    label: "Week 2 Score Category (In MindTap)"
    description: "Score to Date within the first 2 weeks"
    type: tier
    tiers: [0.5, 0.74, 0.89]
    style: relational
    sql: ${to_date_score} ;;
    value_format_name: percent_0
  }

  dimension: week1_points_earned {group_label: "Scores" label: "Week 1 Points Earned (In MindTap)" hidden:yes}
  dimension: week1_points_possible {group_label: "Scores" label: "Week 1 Points Possible (In MindTap)" hidden:yes}
  dimension: week1_score {group_label: "Scores" label: "Week 1 Score (In MindTap)" sql: round(${TABLE}.week1_score, 3);;}
  dimension: week1_score_category {
    group_label: "Scores"
    label: "Week 1 Score Category (In MindTap)"
    description: "Score to Date within the first week"
    type: tier
    tiers: [0.5, 0.74, 0.89]
    style: relational
    sql: ${to_date_score} ;;
    value_format_name: percent_0
  }

  measure: student_count {
    label: "# Students"
    type: count_distinct
    sql: ${sso_guid} ;;
  }

  measure: corr_week2_to_final {
    group_label: "Scores"
    label: "Correlation of week2 Score to Final Score"
    type: number
    sql: corr(${user_final_scores.final_score}, ${week2_score}) ;;
  }

  dimension: week2_score_vs_final_score {
    type: number
    group_label: "Scores"
    label: "Score Improvement from Week 2"
    description: "Difference between week2 Score and Final Score"
    sql: ${user_final_scores.final_score} - ${week2_score} ;;
    value_format_name: percent_1
  }

  dimension: week2_score_vs_final_score_category {
    group_label: "Scores"
    label: "Week 2 Score Improvement Category"
    type: tier
    tiers: [-0.5, -0.2, -0.1, 0.1, 0.2, 0.5]
    sql: ${week2_score_vs_final_score} ;;
    style: relational
    value_format_name: percent_0
  }

  dimension: week1_score_vs_final_score {
    type: number
    group_label: "Scores"
    label: "Score Improvement from Week 1"
    description: "Difference between week2 Score and Final Score"
    sql: ${user_final_scores.final_score} - ${week1_score} ;;
    value_format_name: percent_1
  }

  dimension: week1_score_vs_final_score_category {
    group_label: "Scores"
    label: "Week 1 Score Improvement Category"
    type: tier
    tiers: [-0.5, -0.2, -0.1, 0.1, 0.2, 0.5]
    sql: ${week1_score_vs_final_score} ;;
    style: relational
    value_format_name: percent_0
  }
}
