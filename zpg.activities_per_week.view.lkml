view: activities_per_week {
  view_label: "Activities per week of course"
  sql_table_name: ZPG.ACTIVITIES_PER_WEEK ;;

  dimension: activated {
    type: yesno
    sql: ${TABLE}.ACTIVATED = 1;;
  }

  dimension_group: course_start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.COURSE_START_DATE ;;
  }

  dimension: courseid {
    type: number
    value_format_name: id
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: days_in_course {
    type: number
    sql: ${TABLE}.DAYS_IN_COURSE ;;
  }

  dimension: hed_academictermofyear_sort  {
    type: number
    sql: decode(${hed_academictermofyear}, 'Winter', 3, 'Spring', 2, 'Fall', 1) ;;
    hidden: yes
  }

  dimension: hed_academictermofyear {
    type: string
    sql: ${TABLE}.HED_ACADEMICTERMOFYEAR ;;
    order_by_field: hed_academictermofyear_sort
  }

  dimension:hed_academicterm_sort {
    type: number
    sql: (${hed_academicyear} * 100) + ${hed_academictermofyear_sort};;
    hidden: yes
  }

  dimension: hed_academicterm {
    type: string
    sql: ${TABLE}.HED_ACADEMICYEAR || ' - ' || ${TABLE}.HED_ACADEMICTERMOFYEAR ;;
    order_by_field: hed_academicterm_sort
  }

  dimension: hed_academicyear {
    type: number
    sql: ${TABLE}.HED_ACADEMICYEAR ;;
    value_format: "0000"
  }

  dimension: users_on_course {
    type: number
    sql: ${TABLE}.USERS_ON_COURSE ;;
  }

  dimension: week_of_course {
    type: number
    sql: ${TABLE}.WEEK_OF_COURSE ;;
    value_format: "\W\k 0"
  }

  dimension: in_graceperiod {
    type: yesno
    sql: ${TABLE}.IN_GRACEPERIOD = 1;;
  }

  dimension: paid {
    type: yesno
    sql: ${TABLE}.PAID = 1;;
  }

  dimension: partyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PARTYID ;;
  }

  dimension: productid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  measure: assigned_activities_completed_by_student {
    type: sum
    sql: ${TABLE}.ASSIGNED_ACTIVITIES_COMPLETED_BY_STUDENT ;;
  }

  measure: assigned_activities_completed_by_student_in_graceperiod {
    type: sum
    sql: ${TABLE}.ASSIGNED_ACTIVITIES_COMPLETED_BY_STUDENT_IN_GRACEPERIOD ;;
  }

  measure: assigned_activities_completed_by_student_in_graceperiod_percent {
    type: number
    sql: ${assigned_activities_completed_by_student_in_graceperiod} / ${total_assigned_activities_in_course} ;;
    value_format_name: percent_1
  }

  measure: assigned_activities_completed_by_student_in_graceperiod_to_date {
    type: sum
  }

  dimension: percent_assigned_activities_completed_in_graceperiod {
    type: tier
    tiers: [0.6, 0.7, 0.8, 0.9, 0.95]
    style: relational
    sql: percent_assigned_activities_completed_in_graceperiod;;
    value_format_name: percent_1
  }

  measure: total_activations {
    type: sum_distinct
    sql: ${TABLE}.TOTAL_ACTIVATIONS ;;
    sql_distinct_key: ${courseid} ;;
  }

  measure: total_activities_in_course {
    type: sum_distinct
    sql: ${TABLE}.TOTAL_ACTIVITIES_IN_COURSE ;;
    sql_distinct_key: ${courseid} ;;
  }

  measure: total_assigned_activities_in_course {
    type: sum_distinct
    sql: ${TABLE}.TOTAL_ASSIGNED_ACTIVITIES_IN_COURSE ;;
    sql_distinct_key: ${courseid} ;;
  }

  measure: total_users_on_course {
    type: sum_distinct
    sql: ${TABLE}.USERS_ON_COURSE ;;
    sql_distinct_key: ${courseid} ;;
  }

  measure: total_timespent_secs {
    label: "Total time spent"
    type: sum
    sql: ${TABLE}.TOTAL_TIMESPENT_SECS / 86400.0 ;;
    value_format: "h:mm:ss"
  }

  measure: student_count {
    type: count_distinct
    sql:  ${partyid} ;;
  }

  measure: unpaid_student_count {
    type: count_distinct
    sql:  case when not ${paid} then ${partyid} end ;;
  }

  measure: paid_student_count {
    type: count_distinct
    sql:  case when ${paid} then ${partyid} end ;;
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: no
  }
}
