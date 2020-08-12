view: full_student_course_metrics {
  label: "Data Science - Student Course Metrics"
  sql_table_name: DEV.DATAMINING.FULL_STUDENT_COURSE_METRICS ;;

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: recency_raw {
    type: number
    sql: ${TABLE}.RECENCY ;;
  }

  dimension: recency_tier {
    type: tier
    style: relational
    tiers: [
      0.001,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.7,
      0.8,
      0.9,
      1
    ]
    sql: ${TABLE}.RECENCY ;;
  }

  dimension: duration_base {
    label: "Duration (excluding zero)"
    group_label: "Base Measures"
    type: number
    sql: NULLIF(${TABLE}.DURATION, 0) ;;
  }

  measure: pct {
    type: percent_of_total
    sql: ${count} ;;
  }

  measure: duration {
    label: "Avg. Duration"
    type: average
    sql: ${duration_base} ;;
  }

  measure: duration_total {
    type: sum
    sql: ${duration_base} ;;
  }

  measure: duration_per_login {
    label: "Avg. Session Time"
    type: average
    sql: (${duration_base} / ${login_count_base}) ;;
    value_format: "0.00"
  }

  measure: duration_per_active_day {
    label: "Avg. active duration"
    type: average
    sql: (${duration_base} / ${frequency_base}) ;;
    value_format: "0.00"
  }

  dimension: Active_Days_base {
    label: "Active_Days  (excluding zero)"
    group_label: "Base Measures"
    type: number
    sql: NULLIF(${TABLE}.Active_days_Logins, 0) ;;
  }

  measure: Active_Days {
    type: average
    sql: ${Active_Days_base} ;;
  }

  measure: Active_Days_total {
    type: sum
    sql: ${Active_Days_base} ;;
  }

  measure: duration_percent_of_total {
    label: "Duration (% of total)"
    group_label: "% of Total"
    type: percent_of_total
    sql: ${duration_total} ;;
    value_format: "0.00\%"
  }

  dimension: flashcard_base {
    label: "Flashcard (excluding zero)"
    group_label: "Base Measures"
    type: number
    sql: NULLIF(${TABLE}.FLASHCARD_COUNT, 0) ;;
  }

  measure: flashcard_count {
    type: average
    sql: ${flashcard_base} ;;
  }

  measure: flashcard_total {
    type: sum
    sql: ${flashcard_base} ;;
  }

  measure: flashcard_percent_of_total {
    label: "Flashcards (% of total)"
    group_label: "% of Total"
    type: percent_of_total
    sql: ${flashcard_total} ;;
    value_format: "0.00\%"
  }

  dimension: search_count_base {
    label: "Search Count (excluding zero)"
    group_label: "Base Measures"
    type: number
    sql: NULLIF(${TABLE}.search_COUNT, 0) ;;
  }

  dimension: frequency_base {
    type: number
    sql: NULLIF(${TABLE}.FREQUENCY,0) ;;
  }

  measure: search_count {
    type: average
    sql: ${search_count_base} ;;
  }

  measure: search_total {
    type: sum
    sql: ${search_count_base} ;;
  }

  measure: search_percent_of_total {
    label: "Search (% of total)"
    group_label: "% of Total"
    type: percent_of_total
    sql: ${search_total} ;;
    value_format: "0.00\%"
  }

  measure: frequency {
    type: average
    sql: ${TABLE}.FREQUENCY ;;
  }

  measure: gap_week {
    type: average
    sql: ${TABLE}.GAP_WEEK ;;
  }

  dimension: highlight_count_base {
    label: "Highlight Count (excluding zero)"
    group_label: "Base Measures"
    type: number
    sql: NULLIF(${TABLE}.HIGHLIGHT_COUNT, 0) ;;
  }

  measure: highlight_count {
    type: average
    sql: ${highlight_count_base} ;;
  }

  measure: highlight_total {
    type: sum
    sql: ${highlight_count_base} ;;
  }

  measure: highlight_percent_of_total {
    label: "Highlight (% of total)"
    group_label: "% of Total"
    type: percent_of_total
    sql: ${highlight_total} ;;
    value_format: "0.00\%"
  }

  measure: intensity {
    type: average
    sql: ${TABLE}.INTENSITY ;;
  }

  dimension: login_count_base {
    label: "Login Count (excluding zero)"
    group_label: "Base Measures"
    type: number
    sql: NULLIF(${TABLE}.LOGIN_COUNT, 0) ;;
  }

  measure: login_count {
    type: average
    sql: ${login_count_base} ;;
  }

  measure: login_total {
    type: sum
    sql: ${login_count_base} ;;
  }

  measure: login_percent_of_total {
    label: "Logins (% of total)"
    group_label: "% of Total"
    type: percent_of_total
    sql: ${login_total} ;;
    value_format: "0.00\%"
  }

  dimension: octant {
    type: string
    sql: ${TABLE}.OCTANT ;;
  }

  dimension: pages_read_base {
    label: "Pages Read Count (excluding zero)"
    group_label: "Base Measures"
    type: number
    sql: NULLIF(${TABLE}.PAGES_READ, 0) ;;
  }

  measure: pages_read {
    type: average
    sql: ${pages_read_base} ;;
  }

  measure: pages_read_total {
    type: sum
    sql: ${pages_read_base} ;;
  }

  measure: pages_read_percent_of_total {
    label: "Pages Read (% of total)"
    group_label: "% of Total"
    type: percent_of_total
    sql: ${pages_read} ;;
    value_format: "0.00\%"
  }

  dimension: reading_count_base {
    label: "Reader Count (excluding zero)"
    group_label: "Base Measures"
    type: number
    sql: NULLIF(${TABLE}.READING_COUNT, 0) ;;
  }

  measure: reading_count {
    type: average
    sql: ${reading_count_base} ;;
  }

  measure: reading_total {
    type: sum
    sql: ${reading_count_base} ;;
  }

  measure: reading_percent_of_total {
    label: "Reading (% of total)"
    group_label: "% of Total"
    type: percent_of_total
    sql: ${reading_total} ;;
    value_format: "0.00\%"
  }

  measure: recency {
    type: average
    sql: ${TABLE}.RECENCY ;;
  }

  measure: score {
    label: "Avg. Weekly Score"
    group_label: "Scores"
    type: average
    sql: ${TABLE}.SCORE ;;
  }

  measure: Final_score {
    label: "Final Score"
    group_label: "Scores"
    type: average
    sql: ${TABLE}.final_score ;;
    value_format: "0.00%"
    html: {% if full_student_course_metrics.final_type_of_student._value == 'good' %}
        <font color="darkgreen">{{ rendered_value }}</font>
      {% elsif full_student_course_metrics.final_type_of_student._value == 'average' %}
        <font color="goldenrod">{{ rendered_value }}</font>
      {% elsif full_student_course_metrics.final_type_of_student._value == 'below-average' %}
        <font color="darkred">{{ rendered_value }}</font>
      {% else %}
        <font color="silver">{{ rendered_value }}</font>
      {% endif %}
      ;;
  }

  dimension: type_of_student {
    label: "Type of Student"
    type: string
    sql: ${TABLE}.Weekly_TYPE_OF_STUDENT ;;
  }

  dimension: type_of_student_sort {
    type: number
    hidden: yes
    sql: case when Weekly_TYPE_OF_STUDENT = 'good' then 1 when Weekly_TYPE_OF_STUDENT = 'average' then 2 when Weekly_TYPE_OF_STUDENT = 'below-average' then 3 when Weekly_TYPE_OF_STUDENT = 'no-grade' then 4 when Weekly_TYPE_OF_STUDENT = 'no-interactions' then 5 end ;;
  }

  dimension: final_type_of_student {
    type: string
    sql: ${TABLE}.Final_TYPE_OF_STUDENT ;;
    order_by_field: final_type_of_student_sort
  }

  dimension: final_type_of_student_sort {
    type: number
    hidden: yes
    sql: case when final_type_of_Student = 'good' then 1 when final_type_of_Student = 'average' then 2 when final_type_of_Student = 'below-average' then 3 end ;;
  }

  dimension: initial_type_of_student {
    type: string
    sql: ${TABLE}.Initial_Type_of_Student ;;
    order_by_field: initial_type_of_student_sort
  }

  dimension: initial_type_of_student_sort {
    type: number
    hidden: yes
    sql: case when initial_type_of_student = 'good' then 1 when initial_type_of_student = 'average' then 2 when initial_type_of_student = 'below-average' then 3 when initial_type_of_student = 'no-grade' then 4 when initial_type_of_student = 'no-interactions' then 5 end ;;
  }

  dimension: week1_initial_type_of_student {
    type: string
    sql: ${TABLE}.week1_initial_type_of_student ;;
    order_by_field: week1_initial_type_of_student_sort
  }

  dimension: week1_initial_type_of_student_sort {
    type: number
    hidden: yes
    sql: case when week1_initial_type_of_student = 'good' then 1 when week1_initial_type_of_student = 'average' then 2 when week1_initial_type_of_student = 'below-average' then 3 when week1_initial_type_of_student = 'no-grade' then 4 when week1_initial_type_of_student = 'no-interactions' then 5 end ;;
  }

  dimension: Students_Who_End_Up {
    type: string
    sql: ${TABLE}.final_label ;;
  }

  dimension: user_guid {
    type: string
    sql: ${TABLE}.USER_GUID ;;
    hidden: yes
  }

  dimension: weeksname {
    label: "Week of Course"
    type: string
    sql: ${TABLE}.WEEKSNAME ;;
    order_by_field: weeksnamesort
  }

  dimension: weeksnamesort {
    label: "Week No."
    type: number
    sql: split_part(weeksname, ' ', 2)::int ;;
  }

  measure: count {
    type: count
    drill_fields: [weeksname]
  }

  measure: count_Students {
    type: count_distinct
    sql: ${TABLE}.user_guid ;;
  }

  dimension: highlight_diff {
    label: "Highlights: Good vs Below Average"
    group_label: "Diffs: Good vs Below Average"
    type: number
    sql: case when avg(case when Final_TYPE_OF_STUDENT = 'below-average' then highlight_count end) > 0 then (avg(case when Final_TYPE_OF_STUDENT = 'good' then nullif(highlight_count,0) end)/avg(case when Final_TYPE_OF_STUDENT = 'below-average' then nullif(highlight_count,0) end))-1 else 0 end ;;
    value_format: "0.0%"
  }

  dimension: login_diff {
    label: "Logins: Good vs Below Average"
    group_label: "Diffs: Good vs Below Average"
    type: number
    sql: case when avg(case when Final_TYPE_OF_STUDENT = 'below-average' then login_count end) > 0 then ( avg(case when Final_TYPE_OF_STUDENT = 'good' then nullif(login_count,0) end)/avg(case when Final_TYPE_OF_STUDENT = 'below-average' then nullif(login_count,0) end) )-1     else 0 end ;;
    value_format: "0.0%"
  }

  dimension: Active_diff {
    label: "Active: Good vs Below Average"
    group_label: "Diffs: Good vs Below Average"
    type: number
    sql: case when avg(case when Final_TYPE_OF_STUDENT = 'below-average' then Active_days_Logins end) > 0 then ( avg(case when Final_TYPE_OF_STUDENT = 'good' then nullif(Active_days_Logins,0) end)/avg(case when Final_TYPE_OF_STUDENT = 'below-average' then nullif(Active_days_Logins,0) end) )-1     else 0 end ;;
    value_format: "0.0%"
  }

  #- measure: flashcard_count_diff
  #  label: 'Flashcards: Good vs Below Average'
  #  group_label: 'Diffs: Good vs Below Average'
  #  type: number
  #  group_label: 'Final Good/Final Below-Average'
  #  sql: case when avg(case when Final_TYPE_OF_STUDENT = 'below-average' then flashcard_count end) > 0 then  (avg(case when Final_TYPE_OF_STUDENT = 'good' then nullif(flashcard_count,0) end)/avg(case when Final_TYPE_OF_STUDENT = 'below-average' then nullif(flashcard_count,0) end))-1 else 0 end
  #  value_format: 0.0%

  dimension: reading_count_diff {
    type: number
    label: "Reading: Good vs Below Average"
    group_label: "Diffs: Good vs Below Average"
    sql: case when avg(case when Final_TYPE_OF_STUDENT = 'below-average' then reading_count end) > 0 then  (avg(case when Final_TYPE_OF_STUDENT = 'good' then nullif(reading_count,0) end)/avg(case when Final_TYPE_OF_STUDENT = 'below-average' then nullif(reading_count,0) end))-1 else 0 end ;;
    value_format: "0.0%"
  }

  #- measure: search_count_diff
  #  type: number
  #  label: 'Searches Good vs Below Avg'
  #  group_label: 'Final Outcome Good vs Below-Average'
  #  sql: case when avg(case when Final_TYPE_OF_STUDENT = 'below-average' then search_count end) > 0 then  (avg(case when Final_TYPE_OF_STUDENT = 'good' then nullif(search_count,0) end)/avg(case when Final_TYPE_OF_STUDENT = 'below-average' then nullif(search_count,0) end))-1 else 0 end
  #  value_format: 0.0%
  dimension: active_days_count_D_F_G {
    type: number
    label: "Degraded from Good: Active"
    group_label: "Degraders Usage Difference: Initial Good"
    sql: avg(case when Final_TYPE_OF_STUDENT != 'good' and Initial_Type_of_Student = 'good' then Active_days_Logins end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('below-average', 'average') and Initial_Type_of_Student = 'good' then Active_days_Logins end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: flashcard_count_D_F_G {
    type: number
    label: "Degraded from Good: Flashcard"
    group_label: "Degraders Usage Difference: Initial Good"
    sql: avg(case when Final_TYPE_OF_STUDENT != 'good' and Initial_Type_of_Student = 'good' then flashcard_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('below-average', 'average') and Initial_Type_of_Student = 'good' then flashcard_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: highlight_diff_D_F_G {
    type: number
    label: "Degraded from Good: Highlights"
    group_label: "Degraders Usage Difference: Initial Good"
    sql: avg(case when Final_TYPE_OF_STUDENT != 'good' and Initial_Type_of_Student = 'good' then highlight_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('below-average', 'average') and Initial_Type_of_Student = 'good' then highlight_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: search_count_D_F_G {
    type: number
    label: "Degraded from Good: Search"
    group_label: "Degraders Usage Difference: Initial Good"
    sql: avg(case when Final_TYPE_OF_STUDENT != 'good' and Initial_Type_of_Student = 'good' then search_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('below-average', 'average') and Initial_Type_of_Student = 'good' then search_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: login_D_F_G {
    type: number
    label: "Degraded from Good: Login"
    group_label: "Degraders Usage Difference: Initial Good"
    sql: avg(case when Final_TYPE_OF_STUDENT != 'good' and Initial_Type_of_Student = 'good' then login_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('below-average', 'average') and Initial_Type_of_Student = 'good' then login_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: reading_count_D_F_G {
    type: number
    label: "Degraded from Good: Reading"
    group_label: "Degraders Usage Difference: Initial Good"
    sql: avg(case when Final_TYPE_OF_STUDENT != 'good' and Initial_Type_of_Student = 'good' then reading_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('below-average', 'average') and Initial_Type_of_Student = 'good' then reading_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: active_days_diff_G_BA_numerator {
    type: number
    label: "Improved to Good: Active Numerator"
    group_label: "Improvers Usage Difference: Final Good"
    description: "Difference in usage for students who started with not good scores but ended up with a final good score, compared to those who started the same but did not end up with a good final score: (final type = good, initial_type != good) vs (final_type not good or average, initial type != good)"
    sql: avg(case when Final_TYPE_OF_STUDENT = 'good' and Initial_Type_of_Student != 'good' then Active_days_Logins end) ;;
    value_format: "0.0%"
  }

  dimension: active_days_diff_G_BA_denominator {
    type: number
    label: "Improved to Good: Active Denominator"
    group_label: "Improvers Usage Difference: Final Good"
    description: "Difference in usage for students who started with not good scores but ended up with a final good score, compared to those who started the same but did not end up with a good final score: (final type = good, initial_type != good) vs (final_type not good or average, initial type != good)"
    sql: avg(case when Final_TYPE_OF_STUDENT not in ('good', 'average') and Initial_Type_of_Student != 'good' then Active_days_Logins end) ;;
    value_format: "0.0%"
  }

  dimension: active_days_diff_G_BA {
    type: number
    label: "Improved to Good: Active"
    group_label: "Improvers Usage Difference: Final Good"
    description: "Difference in usage for students who started with not good scores but ended up with a final good score, compared to those who started the same but did not end up with a good final score: (final type = good, initial_type != good) vs (final_type not good or average, initial type != good)"
    sql: ${active_days_diff_G_BA_numerator}/nullif(${active_days_diff_G_BA_denominator},0) -1 ;;
    value_format: "0.0%"
  }

  dimension: highlight_diff_G_BA {
    type: number
    label: "Improved to Good: Highlights"
    group_label: "Improvers Usage Difference: Final Good"
    description: "Difference in usage for students who started with not good scores but ended up with a final good score, compared to those who started the same but did not end up with a good final score: (final type = good, initial_type != good) vs (final_type not good or average, initial type != good)"
    sql: avg(case when Final_TYPE_OF_STUDENT = 'good' and Initial_Type_of_Student != 'good' then highlight_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('good', 'average') and Initial_Type_of_Student != 'good' then highlight_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: search_count_G_BA {
    type: number
    label: "Improved to Good: Search"
    group_label: "Improvers Usage Difference: Final Good"
    sql: avg(case when Final_TYPE_OF_STUDENT = 'good' and Initial_Type_of_Student != 'good' then search_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('good', 'average') and Initial_Type_of_Student != 'good' then search_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: login_G_BA {
    type: number
    label: "Improved to Good: Login"
    group_label: "Improvers Usage Difference: Final Good"
    sql: avg(case when Final_TYPE_OF_STUDENT = 'good' and Initial_Type_of_Student != 'good' then login_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('good', 'average') and Initial_Type_of_Student != 'good' then login_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: flashcard_count_G_BA {
    type: number
    label: "Improved to Good: Flashcard"
    group_label: "Improvers Usage Difference: Final Good"
    sql: avg(case when Final_TYPE_OF_STUDENT = 'good' and Initial_Type_of_Student != 'good' then flashcard_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('good', 'average') and Initial_Type_of_Student != 'good' then flashcard_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: reading_count_G_BA {
    type: number
    label: "Improved to Good: Reading"
    group_label: "Improvers Usage Difference: Final Good"
    sql: avg(case when Final_TYPE_OF_STUDENT = 'good' and Initial_Type_of_Student != 'good' then reading_count end)/nullif(avg(case when Final_TYPE_OF_STUDENT not in ('good', 'average') and Initial_Type_of_Student != 'good' then reading_count end), 0) -1 ;;
    value_format: "0.0%"
  }

  dimension: good_count {
    type: number
    sql: sum(case when Final_TYPE_OF_STUDENT = 'good' then 1 end) ;;
  }

  measure: cntr {
    type: count
  }

  dimension: below_average_count {
    type: number
    sql: sum(case when Final_TYPE_OF_STUDENT = 'below-average' then 1 end) ;;
  }

  dimension: Weekly_Good_Count {
    type: number
    alias: [WGood]
    sql: sum(case when Weekly_TYPE_OF_STUDENT = 'good' then 1 end) ;;
  }

  dimension: Weekly_Below_Average_Count {
    type: number
    alias: [WBelowAverage]
    sql: sum(case when Weekly_TYPE_OF_STUDENT = 'below-average' then 1 end) ;;
  }
}
