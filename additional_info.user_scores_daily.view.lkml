view: user_scores_daily {
  view_label: "User"
  derived_table: {
    sql:
    select
        1+datediff(day, dc.startdate, to_timestamp(ao.created_date, 3)) as day_of_course
        ,dc.courseid || '.' || dp.partyid || '.' || day_of_course as pk
        ,u.source_id as sso_guid
        ,dc.courseid
        ,dp.partyid
        ,ao.points_earned / nullif(ao.points_possible, 0)::float as daily_score
    from mindtap.prod_nb.activity_outcome ao
    inner join mindtap.prod_nb.user u on ao.user_id = u.id
    inner join mindtap.prod_nb.snapshot s on ao.snapshot_id = s.id
    inner join mindtap.prod_nb.org o on s.org_id = o.id
    inner join dw_ga.dim_course dc on o.external_id = dc.coursekey
    inner join dw_ga.dim_party dp on u.source_id = dp.guid
    ;;
    sql_trigger_value: select count(*) from stg_mindtap.activity_outcome_summary ;;
  }

  dimension: courseid {hidden:yes}
  dimension: partyid {hidden:yes}
  dimension: day_of_course {}
  dimension: sso_guid {hidden:yes}
  dimension: pk {hidden:yes primary_key:yes}
  dimension: daily_score {group_label: "Scores" label: "Daily Activity Score (In MindTap)"}
  dimension: daily_score_category {
    group_label: "Scores"
    label: "Daily Activity Score Category (In MindTap)"
    type: tier
    tiers: [0.5, 0.74, 0.89]
    style: relational
    sql: ${daily_score} ;;
    value_format_name: percent_0
  }
  measure: daily_score_avg {
    group_label: "Scores"
    label: "Daily Activity Score (Avg)"
    type: average
    sql: ${daily_score} ;;
    value_format_name: percent_1
  }
}
