view: user_facts {
  label: "User"
  derived_table: {
    sql: SELECT
        s.userId
        ,max(p.guid) as guid
        ,sum(POINTS_EARNED) / nullif(sum(POINTS_POSSIBLE), 0) AS overall_score
        ,sum(CASE WHEN a.assigned = 1 THEN POINTS_EARNED END) / nullif(sum(CASE WHEN a.ASSIGNED = 1 THEN POINTS_POSSIBLE END), 0) AS gradable_score
        ,sum(CASE WHEN a.assigned != 1 THEN POINTS_EARNED END) / nullif(sum(CASE WHEN a.ASSIGNED != 1 THEN POINTS_POSSIBLE END), 0) AS nongradable_score
        ,count(DISTINCT CASE WHEN a.ASSIGNED = 1 THEN s.ACTIVITYID end) AS gradable_activities_completed
        ,count(DISTINCT CASE WHEN a.ASSIGNED != 1 THEN s.ACTIVITYID end) AS nongradable_activities_completed
        ,count(DISTINCT s.ACTIVITYID) AS activities_completed
        ,avg(ATTEMPTS) AS avg_attempts
        ,avg(CASE WHEN assigned = 1 THEN ATTEMPTS end) AS avg_gradable_attempts
        ,avg(CASE WHEN assigned != 1 THEN ATTEMPTS end) AS avg_nongradable_attempts
        ,count(distinct sessionNumber) AS logins_by_user
        ,COALESCE(COUNT(distinct CASE WHEN d.datevalue > DATEADD(month, -6, CURRENT_DATE()) THEN s.courseid END), 0) as courses_6m
      FROM dw_ga.FACT_ACTIVITYOUTCOMESUMMARY s
      INNER JOIN ${dim_date.SQL_TABLE_NAME} d ON s.createddatekey = d.datekey
      INNER JOIN dw_ga.DIM_ACTIVITY a ON s.ACTIVITYID = a.ACTIVITYID
      INNER JOIN dw_ga.FACT_SESSION f ON s.USERID = f.USERID
      inner join dw_ga.dim_user u on s.userid = u.userid
      inner join dw_ga.dim_party p on u.mainpartyid = p.partyid
      GROUP BY 1
       ;;
      #datagroup_trigger: fact_activityoutcome_datagroup
      sql_trigger_value: select * from dw_ga.fact_activityoutcome ;;
  }
  set: curated_fields{
    fields: [activities_completed,activities_completed_by_user,gradable_activities_completed,gradable_activities_completed_by_user,overall_score,logins_by_user, courses_tier]
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
#     hidden: yes
    primary_key: yes
  }

  dimension: guid {
    hidden: yes
  }

  dimension: overall_score {
    type: number
    sql: ${TABLE}.OVERALL_SCORE ;;
    hidden: yes
  }

  dimension: logins_by_user {
    label: "#Login"
    type: number
    sql: ${TABLE}.logins_by_user ;;
    hidden: yes
  }

  dimension: courses_6m {hidden:yes type: number}
  dimension: courses_tier {
    label: "# Courses"
    description: "# Courses with activity in the last 6 months"
    type: tier
    tiers: [0, 1, 2, 3, 5]
    style: integer
    sql: COALESCE(${courses_6m}, 0) ;;
  }

  dimension: user_score_category {
    group_label: "Scores"
    label: "User Score Category (Gradable)"
    type: tier
    tiers: [0.5, 0.74, 0.89]
    style: relational
    sql: ${gradable_score} ;;
    value_format_name: percent_0
  }

  dimension: user_score_category_non_gradable {
    label: "User Score Category (Non-Gradable)"
    type: tier
    tiers: [0.5, 0.74, 0.89]
    style: relational
    sql: ${nongradable_score} ;;
    value_format_name: percent_0
    hidden: yes
  }

  dimension: user_score_category_overall {
    group_label: "Scores"
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
#     hidden: yes
  }

  dimension: nongradable_activities_completed {
    label: "# Non gradable activities completed"
    type: number
    sql: ${TABLE}.NONGRADABLE_ACTIVITIES_COMPLETED ;;
    hidden: yes
  }

  dimension: activities_completed {
    label: "# Activities completed"
    type: number
    sql: ${TABLE}.ACTIVITIES_COMPLETED ;;
    hidden: yes
  }

  dimension: avg_attempts {
    label: "Avg # Attempts"
    type: string
    sql: ${TABLE}.AVG_ATTEMPTS ;;
    hidden: yes
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
    description: "Total number of Non gradeable activities completed"
    type: sum
    sql: ${nongradable_activities_completed}  ;;
  }

  measure: logins_from_session_number {
    label: "Total Logins"
    description: "Total logins into the product made by the user (calculated off session number from fact_session)"
    type: sum
    sql:  ${logins_by_user} ;;
    html:
    {% if value > 45 %}
    <font color="red">{{ rendered_value }}</font>
    {% endif %}
    ;;
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
