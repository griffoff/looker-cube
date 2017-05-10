view: dim_activity {
  label: "Activity"
  sql_table_name: DW_GA.DIM_ACTIVITY_V ;;

  dimension: activitycategory {
    label: "Category"
    type: string
    sql: ${TABLE}.Category ;;
    drill_fields: [dim_learningpath.lowest_level]
  }

  dimension: activitysubcategory {
    label: "Sub category"
    type: string
    sql: ${TABLE}.SubCategory ;;
  }

  dimension: activitysubtype {
    label: "Sub type"
    type: string
    sql: ${TABLE}.SubType ;;
  }

  dimension: activityid {
    type: number
    sql: ${TABLE}.ACTIVITYID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: possiblepoints {
    label: "Possible points"
    type: number
    sql: ${TABLE}.possiblepoints ;;
    hidden: yes
  }

  dimension: possiblepoints_bucket {
    label: "Possible points (bins)"
    type: tier
    tiers: [5, 10, 20, 50, 100]
    style: integer
    sql: ${possiblepoints} ;;
  }

  dimension: APPLICATIONNAME {
    label: "Application Name"
    type: string
    sql: ${TABLE}.APPLICATIONNAME ;;
  }

  dimension: gradable {
    label: "Graded"
    type: string
    #sql: ${TABLE}.ASSIGNED ;;
    sql: decode(${TABLE}.ASSIGNED, 'Assigned', 'Graded', 'Unassigned', 'Not Graded', ${TABLE}.ASSIGNED);;
  }

  dimension: originallygradable {
    label: "Originally graded"
    type: string
    sql: decode(${TABLE}.ORIGINALASSIGNEDSTATE, 'Assigned', 'Graded', 'Unassigned', 'Not Graded', ${TABLE}.ORIGINALASSIGNEDSTATE) ;;
  }

  dimension: gradable_status {
    label: "Gradable status"
    type: string
    sql: CASE
        WHEN ${gradable} != ${originallygradable} THEN
          CASE WHEN ${originallygradable} = 'Graded' THEN 'Demoted to Not Graded'
              ELSE 'Promoted to Graded'
              END
        ELSE ${originallygradable} || ' - NO CHANGE'
        END
       ;;
  }

  dimension: scorable_status {
    label: "Scorable status"
    type: string
    sql: CASE
        WHEN ${scorable} = 'Scorable' AND ${originalscorable} = 'Not Scorable' THEN 'Demoted to Not Scorable'
        WHEN ${scorable} = 'Not Scorable' AND ${originalscorable} = 'Scorable' THEN 'Promoted TO Practice'
        WHEN ${scorable} = ${originalscorable} THEN ${originalscorable} || ' - NO CHANGE'
        ELSE ${scorable}
      END
       ;;
  }

  dimension: scorable {
    label: "Scorable"
    type: string
    sql: ${TABLE}.SCORABLE ;;
  }

  dimension: originalscorable {
    label: "Originally scorable"
    type: string
    sql: ${TABLE}.ORIGINALSCORABLE ;;
  }

  measure: count {
    label: "# Activities"
    type: count_distinct
    sql: ${dim_course.courseid} ;;
    drill_fields: []
  }

  measure:  count_gradable {
    label: "# Gradable activities"
    type: count_distinct
    sql: case when ${gradable} = 'Graded' then ${dim_course.courseid} end;;
    hidden:  yes
  }

  measure:  count_practice {
    label: "# Practice activities"
    type: count_distinct
    sql: case when ${gradable} != 'Graded' and ${scorable} = 'Scorable' then ${dim_course.courseid} end;;
    hidden:  yes
  }

  measure:  gradable_percent {
    label: "% Gradable"
    description: "proportion of times activity was gradable"
    type: number
    sql:  ${count_gradable}/${count};;
    value_format_name:  percent_1
    hidden:  no
  }

  measure:  practice_percent {
    label: "% Practice"
    description: "proportion of times activity was practice"
    type: number
    sql:  ${count_practice}/${count};;
    value_format_name:  percent_1
    hidden:  no
  }

  measure:  not_practice_or_graded_percent {
    label: "% not practice/gradable"
    description: "proportion of times activity was neither practice or gradable"
    type: number
    sql:  ${count} - (${count_practice} + ${count_practice})/${count};;
    value_format_name:  percent_1
    hidden:  no
  }
}
