view: user_final_scores {
  view_label: "User"
  derived_table: {
    sql:
    select
        dc.courseid || '.' || dp.partyid as pk
        ,dc.courseid
        ,dp.partyid
        ,sos.points_earned / sos.points_possible::float as final_score
    from stg_mindtap.student_outcome_summary sos
    inner join stg_mindtap.user u on sos.user_id = u.id
    inner join stg_mindtap.snapshot s on sos.snapshot_id = s.id
    inner join stg_mindtap.org o on s.org_id = o.id
    inner join dw_ga.dim_course dc on o.external_id = dc.coursekey
    inner join dw_ga.dim_party dp on u.source_id = dp.guid
    ;;
    sql_trigger_value: select count(*) from stg_mindtap.student_outcome_summary ;;
  }

  dimension: courseid {hidden:yes}
  dimension: partyid {hidden:yes}
  dimension: pk {hidden:yes primary_key:yes}
  dimension: final_score {label: "Course Final Score (In MindTap)"}
}
