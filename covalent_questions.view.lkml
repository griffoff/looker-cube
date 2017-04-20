view: mankiw_questions {
  label: "MANKIW Questions"

}

view: soa_questions {
  extends: [mankiw_questions]
  sql_table_name: dev.zpg.soa_questions ;;
  label: "SOA Questions"



}

view: all_questions {
  sql_table_name: dev.zpg.all_questions ;;
  label: "All Covalent Questions"

  set: take_details {
    fields: [coursekey, take_submissiondate_date, take_oid, normalscore_avg, timespent_avg]
  }

  set: activity_details {
    fields: [take_details*, activityuri, activity_label]
  }

  set: item_details {
    fields: [activity_details*, activityitemuri, itemName, markedtaken, scorerequired]
  }

  dimension: container_type {
    type: string
    sql: ${TABLE}.containerType ;;
  }

  dimension: activity_type {
    type: string
    sql: ${TABLE}.activity_Type ;;
  }

  dimension: activityitemuri {
    type: string
    sql: ${TABLE}.ACTIVITYITEMURI ;;
  }

  dimension: activityuri {
    type: string
    sql: ${TABLE}.ACTIVITYURI::string ;;
    link: {
      label: "View in Analytics Diagnostic Tool"
      url: "https://analytics-tools.cengage.info/diagnostictool/#/activity/view/production/uri/{{value}}"
    }
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: externalid {
    type: string
    sql: ${TABLE}.EXTERNALID ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.LABEL ;;
  }

  dimension: markedtaken {
    type: yesno
    sql: ${TABLE}.MARKEDTAKEN ;;
  }

  measure: taken {
    label: "# items completed"
    description: "No. of times an item has been completed"
    type: sum
    sql: CASE WHEN ${markedtaken} THEN 1 END ;;
    drill_fields: [item_details*]
  }

  dimension: normalscore {
    hidden: yes
    type: number
    sql: IFF(${TABLE}.SCOREREQUIRED OR ${TABLE}.MARKEDTAKEN, ${TABLE}.NORMALSCORE, NULLIF(${TABLE}.NORMALSCORE, 0)) ;;
  }

#   dimension: normalscore {
#     hidden: yes
#     type: number
#     sql: NULLIF(${TABLE}.NORMALSCORE, 0) ;;
#   }

  dimension: normalscore_bucket {
    label: "Score Bins"
    group_label: "Score"
    type: tier
    style: interval
    tiers: [0, 0.3, 0.5, 0.7, 0.9]
  }

  measure: normalscore_avg {
    label: "Avg Score"
    group_label: "Score"
    type: average
    sql: ${normalscore} ;;
    value_format_name: percent_1
    drill_fields: [coursekey, activityitemuri, label, normalscore, take_oid,take_submissiondate_date, user_oid]
  }

  measure: normalscore_min {
    label: "Min Score"
    group_label: "Score"
    type: min
    sql: ${normalscore} ;;
    value_format_name: percent_1
  }

  measure: normalscore_max {
    label: "Max Score"
    group_label: "Score"
    type: max
    sql: ${normalscore} ;;
    value_format_name: percent_1
  }

  dimension: possiblescore {
    type: number
    sql: ${TABLE}.POSSIBLESCORE ;;
  }

  dimension: score {
    hidden: yes
    type: number
    sql: ${TABLE}.SCORE ;;
  }

  dimension: scorerequired {
    label: "Requires Manual Grading"
    type: yesno
    sql: coalesce(${TABLE}.SCOREREQUIRED, false) ;;
  }

  measure: manual_grading_count {
    label: "# requiring manual grading"
    type: sum
    sql: CASE WHEN ${scorerequired} THEN 1 END ;;
  }

  measure: automatic_grading_count {
    label: "# automatically graded"
    type: sum
    sql: CASE WHEN not ${scorerequired} THEN 1 END ;;
  }

  measure: manual_grading_percent {
    label: "% requiring manual grading"
    type: number
    sql: COUNT(CASE WHEN ${scorerequired} THEN 1 END)::float / COUNT(*) ;;
    value_format_name: percent_1
  }

#   measure:  assigned {
#    TO DO
#   }

#   measure:  unassigned {
#    TO DO
#   }

  dimension: take_oid {
    type: string
    sql: ${TABLE}.TAKE_OID ;;
    link: {
      label:"View in Analytics Diagnostic Tool"
      url: "https://analytics-tools.cengage.info/diagnostictool/#/activity-take/view/production/id/{{value}}"
    }
  }

  dimension_group: take_submissiondate {
    label: "Take Submission"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.TAKE_SUBMISSIONDATE ;;
  }

  dimension: timespent {
    type: number
    sql: ${TABLE}.TIMESPENT / 86400.0 ;;
    hidden: yes
    value_format: "h:mm:ss"
  }

  measure: timespent_avg {
    label: "Time spent (avg)"
    type:  average
    sql: ${timespent} ;;
    group_label: "Time spent"
    value_format: "h:mm:ss"
  }

  measure: timespent_min {
    label: "Time spent (min)"
    type:  min
    sql: case when ${markedtaken} then ${timespent} end ;;
    group_label: "Time spent"
    value_format: "h:mm:ss"
  }

  measure: timespent_max {
    label: "Time spent (max)"
    type:  max
    sql: ${timespent} ;;
    group_label: "Time spent"
    value_format: "h:mm:ss"
  }

  dimension: timespent_bin {
    type: tier
    tiers: [0, 500, 1000, 2000, 5000, 10000]
    style: integer
    sql: ${timespent} ;;
  }

  dimension: user_oid {
    type: string
    sql: ${TABLE}.USER_OID ;;
  }

  measure: user_count {
    label: "# users"
    type: count_distinct
    sql:  ${user_oid} ;;
  }

  measure: item_count {
    label: "# items"
    type: count_distinct
    sql:  ${activityitemuri} ;;
    drill_fields: [item_details*]
  }

  measure: activity_count {
    label: "# activities"
    type: count_distinct
    sql:  ${activityuri} ;;
    drill_fields: [activity_details*]
  }

  measure: take_count {
    label: "# takes"
    type: count_distinct
    sql:  ${take_oid} ;;
    drill_fields: [take_details*]
  }

  measure:  take_count_percent {
    label: "% takes"
    type:  percent_of_total
    sql: ${take_count} ;;
  }

  measure: course_count {
    label: "# courses"
    type: count_distinct
    sql: ${coursekey} ;;
  }

  measure: count {
    type: count
    drill_fields: [coursekey, activityitemuri, label, normalscore, take_oid, take_submissiondate_date, user_oid]
  }

  dimension: id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.nextval ;;
    #sql: ${TABLE}.id ;;
  }

  measure: attempts_sum {
    label: "# attempts"
    type: sum
    sql: ${TABLE}.attempts ;;
  }

  measure: attempts_avg {
    label: "avg. attempts"
    type: average
    sql: ${TABLE}.attempts ;;
  }

  dimension: activity_creationDateKey {
    type: number
    sql: ${TABLE}.activity_creationDateKey ;;
    hidden: yes
  }

  dimension_group: creation_date {
    label: "Activity Creation"
    sql: ${TABLE}.activity_creationDate ;;
    type:  time
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
  }

  dimension: label_level0 {
    type: string
    group_label: "Item Hierarchy"
    label: "Level 0"
    sql: ${TABLE}.label_level0 ;;
  }

  dimension: label_level1 {
    type: string
    group_label: "Item Hierarchy"
    label: "Level 1"
    sql: ${TABLE}.label_level1 ;;
  }

  dimension: label_level2 {
    type: string
    group_label: "Item Hierarchy"
    label: "Level 2"
    sql: ${TABLE}.label_level2 ;;
  }

  dimension: label_level3 {
    type: string
    group_label: "Item Hierarchy"
    label: "Level 3"
    sql: ${TABLE}.label_level3 ;;
  }

  dimension: label_level4 {
    type: string
    group_label: "Item Hierarchy"
    label: "Level 4"
    sql: ${TABLE}.label_level4 ;;
  }

  dimension: label_level5 {
    type: string
    group_label: "Item Hierarchy"
    label: "Level 5"
    sql: ${TABLE}.label_level5 ;;
  }

  dimension: label_level6 {
    type: string
    group_label: "Item Hierarchy"
    label: "Level 6"
    sql: ${TABLE}.label_level6 ;;
  }

  dimension: nodeType {
    type: string
    sql: ${TABLE}.nodeType ;;
  }

  dimension: difficulty {
    type: number
    sql: ${TABLE}.difficulty ;;
  }

  dimension: itemName {
    label: "Item Name"
    type: string
    sql: coalesce(${TABLE}.itemName, ${TABLE}.label_level0, ${TABLE}.label) ;;
  }

  dimension: itemNameIsUseful {
    label: "Item name is useful"
    description: "Item name is neither blank or numeric"
    type: yesno
    sql: ${itemName} is null or try_cast(${itemName} as float) is null  ;;
  }

  dimension: problemType {
    type: string
    sql: ${TABLE}.problemType ;;
  }

  dimension: bookAbbr {
    type: string
    sql: ${TABLE}.bookAbbr ;;
  }

  dimension: bookSectionId {
    type: string
    sql: ${TABLE}.bookSectionId ;;
  }

  dimension: courseUri {
    type: string
    sql: ${TABLE}.COURSEURI ;;
    link: {
      label: "View in Analytics Diagnostic Tool"
      url: "https://analytics-tools.cengage.info/diagnostictool/#/course/view/production/uri/{{value}}"
    }
  }

  dimension: activity_label {
    type: string
    sql: ${TABLE}.ACTIVITY_LABEL ;;
  }

  measure:  correct_count {
    description: "# of times the item was completed with full marks"
    label: "# correct"
    type: sum
    sql: case when ${possiblescore} > 0 and ${normalscore} = 1 then 1 end;;
  }

  measure:  correct_users {
    description: "# of students with full marks on the item"
    label: "# students correct"
    type: count_distinct
    sql: case when ${possiblescore} > 0 and ${normalscore} = 1 then ${user_oid} end;;
  }

  measure:  users_attempted {
    description: "# of students who attempted the item"
    label: "# students attempted"
    type: count_distinct
    #sql: case when ${possiblescore} > 0 and (not ${scorerequired} or ${normalscore} > 0) then ${user_oid} end;;
    sql: case when ${possiblescore} > 0 then ${user_oid} end;;
  }

  measure:  correct_user_percent {
    description: "% of students who got full marks on the item"
    label: "% correct"
    type: number
    sql: ${correct_users} / nullif(${users_attempted}, 0);;
    value_format_name: percent_1
  }

  dimension: scorable {
    type: yesno
    sql: ${possiblescore} > 0 ;;
  }



}
