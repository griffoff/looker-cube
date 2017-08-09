view: user_facts {
  label: "User"
  derived_table: {
    sql: SELECT
        userId
        ,sum(POINTS_EARNED) / nullif(sum(POINTS_POSSIBLE), 0) AS overall_score
        ,sum(CASE WHEN a.assigned = 1 THEN POINTS_EARNED END) / nullif(sum(CASE WHEN a.ASSIGNED = 1 THEN POINTS_POSSIBLE END), 0) AS gradable_score
        ,sum(CASE WHEN a.assigned != 1 THEN POINTS_EARNED END) / nullif(sum(CASE WHEN a.ASSIGNED != 1 THEN POINTS_POSSIBLE END), 0) AS nongradable_score
        ,count(CASE WHEN a.ASSIGNED = 1 THEN 1 end) AS gradable_activities_completed
        ,count(CASE WHEN a.ASSIGNED != 1 THEN 1 end) AS nongradable_activities_completed
        ,count(*) AS activities_completed
        ,avg(ATTEMPTS) AS avg_attempts
        ,avg(CASE WHEN assigned = 1 THEN ATTEMPTS end) AS avg_gradable_attempts
        ,avg(CASE WHEN assigned != 1 THEN ATTEMPTS end) AS avg_nongradable_attempts
      FROM dw_ga.FACT_ACTIVITYOUTCOMESUMMARY s
      INNER JOIN dw_ga.DIM_ACTIVITY a ON s.ACTIVITYID = a.ACTIVITYID
      GROUP BY 1
       ;;
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: overall_score {
    type: number
    sql: ${TABLE}.OVERALL_SCORE ;;
    hidden: yes
  }

  dimension: user_score_category {
    label: "User Score Category (Gradable)"
    type: tier
    tiers: [0.4, 0.7, 0.9]
    style: relational
    sql: ${gradable_score} ;;
    value_format_name: percent_0
  }

  dimension: user_score_category_non_gradable {
    label: "User Score Category (Non-Gradable)"
    type: tier
    tiers: [0.4, 0.7, 0.9]
    style: relational
    sql: ${nongradable_score} ;;
    value_format_name: percent_0
    hidden: yes
  }

  dimension: user_score_category_overall {
    label: "User Score Category (Overall)"
    type: tier
    tiers: [0.4, 0.7, 0.9]
    style: relational
    sql: ${overall_score} ;;
    value_format_name: percent_0
    hidden: yes
  }

  dimension: gradable_score {
    type: number
    sql: ${TABLE}.GRADABLE_SCORE ;;
    hidden: yes
  }

  dimension: nongradable_score {
    type: number
    sql: ${TABLE}.NONGRADABLE_SCORE ;;
    hidden: yes
  }

  dimension: gradable_activities_completed {
    label: "# Gradable activities completed"
    type: number
    sql: ${TABLE}.GRADABLE_ACTIVITIES_COMPLETED ;;
  }

  dimension: nongradable_activities_completed {
    label: "# Non gradable activities completed"
    type: number
    sql: ${TABLE}.NONGRADABLE_ACTIVITIES_COMPLETED ;;
  }

  dimension: activities_completed {
    label: "# Activities completed"
    type: number
    sql: ${TABLE}.ACTIVITIES_COMPLETED ;;
  }

  dimension: avg_attempts {
    label: "Avg # Attempts"
    type: string
    sql: ${TABLE}.AVG_ATTEMPTS ;;
  }

  dimension: avg_gradable_attempts {
    type: string
    sql: ${TABLE}.AVG_GRADABLE_ATTEMPTS ;;
    hidden: yes
  }

  dimension: avg_nongradable_attempts {
    type: string
    sql: ${TABLE}.AVG_NONGRADABLE_ATTEMPTS ;;
    hidden: yes
  }

  measure: activities_completed_by_user {
    label: "# Activities Completed"
    description: "Total number of activities completed"
    type: sum
    sql: ${activities_completed}  ;;
  }

  measure: gradable_activities_completed_by_user {
    label: "# Gradable Activities Completed"
    description: "Total number of gradable activities completed"
    type: sum
    sql: ${gradable_activities_completed}  ;;
  }

  measure: non_gradable_activities_completed_by_user {
    label: "# Non-gradable Activities Completed"
    description: "Total number of gradeable activities completed"
    type: sum
    sql: ${nongradable_activities_completed}  ;;
  }

  set: detail {
    fields: [
      userid,
      overall_score,
      gradable_score,
      nongradable_score,
      gradable_activities_completed,
      nongradable_activities_completed,
      activities_completed,
      avg_attempts,
      avg_gradable_attempts,
      avg_nongradable_attempts
    ]
  }
}
