view: user_final_scores {
  view_label: "User"
  derived_table: {
    sql:
    select distinct
        dc.courseid || '.' || dp.partyid as pk
        ,u.source_id as sso_guid
        ,dc.coursekey
        ,dc.courseid
        ,dp.partyid
        ,sos.points_earned / nullif(sos.points_possible, 0)::float as final_score
    from mindtap.prod_nb.student_outcome_summary sos
    inner join mindtap.prod_nb.user u on sos.user_id = u.id
    inner join mindtap.prod_nb.snapshot s on sos.snapshot_id = s.id
    inner join mindtap.prod_nb.org o on s.org_id = o.id
    inner join dw_ga.dim_course dc on o.external_id = dc.coursekey
    inner join dw_ga.dim_party dp on u.source_id = dp.guid
    where not sos._fivetran_deleted
    and final_score is not null
    ;;
    sql_trigger_value: select count(*) from stg_mindtap.student_outcome_summary ;;
  }

  dimension: courseid {hidden:yes}
  dimension: partyid {hidden:yes}
  dimension: sso_guid {hidden:yes}
  dimension: pk {hidden:yes primary_key:yes}
  dimension: final_score {group_label: "Scores" label: "Course Final Score (In MindTap)" sql: round(${TABLE}.final_score, 3);;}
  dimension: final_score_category {
    group_label: "Scores"
    label: "Course Final Score Category (In MindTap)"
    type: tier
    tiers: [0.5, 0.74, 0.89]
    style: relational
    sql: ${final_score} ;;
    value_format_name: percent_0
  }
  measure: final_score_avg {
    group_label: "Scores"
    label: "Course Final Score (Avg)"
    type: average
    sql: ${final_score} ;;
    value_format_name: percent_1
  }
}
