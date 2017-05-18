view: dim_activity {
  label: "Learning Path"
  #sql_table_name: DW_GA.DIM_ACTIVITY_V ;;
  derived_table: {
    sql:
      SELECT
        a.dw_ldid,
        a.dw_ldts,
        a.originalassigned,
        a.activityid,
        upper(( a.category )) AS category,
        upper(( a.subcategory )) AS subcategory,
        upper(( a.applicationname )) AS applicationname,
        a.url,
        a.maxtakes,
        CASE
          WHEN a.assigned = 1 THEN 'Assigned'
          WHEN a.assigned = 2 THEN 'Deleted by Cengage Employee'
          WHEN a.assigned = 3 THEN 'Marked as hidden by Instructor'
          ELSE 'Unassigned'
        END AS assigned,
        CASE
          WHEN a.scorable = 1 THEN 'Scorable'
          ELSE 'Not Scorable'
        END AS scorable,
        CASE
          WHEN a.originalassigned = 1 THEN 'Assigned'
          ELSE 'Unassigned'
        END AS originalassignedstate,
        CASE
          WHEN a.originalscorable = 1 THEN 'Scorable'
          ELSE 'Not Scorable'
        END AS originalscorablestate,
        CASE
          WHEN a.activitychangetypeid = 1 THEN 'Unassigned by Instructor'
          WHEN a.activitychangetypeid = 2 THEN 'Assigned by Instructor'
          WHEN a.activitychangetypeid = 3 THEN 'Unscorable by Instructor'
          WHEN a.activitychangetypeid = 4 THEN 'Scorable by Instructor'
          WHEN a.activitychangetypeid = 5 THEN 'Unassigned by Instructor'
          WHEN a.activitychangetypeid = 6 THEN 'Assigned by Instructor'
          WHEN a.activitychangetypeid = 7 THEN 'Unassigned by Instructor'
          WHEN a.activitychangetypeid = 8 THEN 'Assigned by Instructor'
          ELSE 'No Changes'
        END AS activitychangetype,
        a.subtype,
        a.possiblepoints,
        case when a.assigned = 1 then 'graded'
            when a.assigned in (2, 3) then 'unassigned'
            when a.scorable = 1 then 'practice'
            else 'nonscorable'
        end as status
      FROM dw_ga.dim_activity a
      ;;
      sql_trigger_value: select count(*) from dw_ga.dim_activity ;;
  }

  dimension: activitycategory {
    group_label: "Activity Category"
    label: "Activity Category (Lvl 1)"
    description: "Broad activity categories. (ex: Aplia Assignment, LAMS Lesson, Reading, Media, YouSeeU, etc.)"
    type: string
    sql: ${TABLE}.Category ;;
    drill_fields: [dim_learningpath.lowest_level]
  }

  dimension: activitysubcategory {
    group_label: "Activity Category"
    label: "Activity Category (Lvl 2)"
    description: "More specific activity subcategory (e.g Category is Assignment, subcategory is assessment and homework)"
    type: string
    sql: ${TABLE}.SubCategory ;;
  }

  dimension: activitysubtype {
    group_label: "Activity Category"
    label: "Activity Category (Lvl 3)"
    description: "Most specific activity categories. Product/discipline specific. (ex: saa, csfi, virtuallab, etc.)"
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
    label: "Possible Points (bins)"
    description: "The possible points of an activity for a coursekey grouped into bins. (ex: 5 to 10 pts, 10 to 20 pts). Is not relative to other courses. Useful when comparing activities from the same coursekey"
    type: tier
    tiers: [5, 10, 20, 50, 100]
    style: integer
    sql: ${possiblepoints} ;;
  }

  dimension: APPLICATIONNAME {
    label: "Activity Application"
    description: "The name of the application where the activity is located or created from. (ex: CNOW, Aplia, Lams, etc.)"
    type: string
    sql: ${TABLE}.APPLICATIONNAME ;;
  }

  dimension: gradable {
    group_label: "Gradable"
    label: "Gradable  (Current)"
    description: "Denotes if the activity counts as part of a grade. Activities that are: (1) gradable & scorable count towards grade, (2) NOT gradable & scorable = Practice, (3) NOT scorable & NOT gradable are not assigned."
    type: string
    #sql: ${TABLE}.ASSIGNED ;;
    sql: decode(${TABLE}.ASSIGNED, 'Assigned', 'Graded', 'Unassigned', 'Not Graded', 'Marked as hidden by Instructor', 'Unassigned', ${TABLE}.ASSIGNED);;
  }

  dimension: originallygradable {
    group_label: "Gradable"
    label: "Gradable  (Original)"
    description: "The original graded (assigned) state of an activity upon creation of the course"
    type: string
    sql: decode(${TABLE}.ORIGINALASSIGNEDSTATE, 'Assigned', 'Graded', 'Unassigned', 'Not Graded', ${TABLE}.ORIGINALASSIGNEDSTATE) ;;
  }

  dimension: gradable_status {
    group_label: "Gradable"
    label: " Gradable (Change)"
    description: "Denotes if an activity's current graded (assigned) state differs from the original graded (assigned) state due to an instructor modification"
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
    group_label: "Scorable"
    label: " Scorable (Change)"
    description: "Denotes if an activity's current scorable state differs from the original scorable state"
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
    group_label: "Scorable"
    label: " Scorable  (Current)"
    description: "Denotes the current scorable state of an activity (assigned or unassigned). Activities that are: (1) gradable & scorable count towards grade, (2) NOT gradable & scorable = Practice, (3) NOT scorable & NOT gradable are not assigned."
    type: string
    sql: ${TABLE}.SCORABLE ;;
  }

  dimension: originalscorable {
    group_label: "Scorable"
    label: "Scorable  (Original)"
    description: "The original scorable state of an activity upon creation of the course"
    type: string
    sql: ${TABLE}.ORIGINALSCORABLESTATE ;;
  }

  measure: count {
    label: "# Activities"
    description: "The count of courses containing an activity"
    type: count_distinct
    sql: ${dim_course.courseid} ;;
    drill_fields: []
  }

  measure:  count_gradable {
    label: "# Gradable activities"
    description: "No. of courses with this as a gradable activity"
    type: count_distinct
    sql: case when ${gradable} = 'Graded' then ${dim_course.courseid} end;;
    hidden:  yes
  }

  measure:  count_practice {
    label: "# Practice activities"
    description: "No. of courses with this as a practice activity"
    type: count_distinct
    sql: case when ${gradable} != 'Graded' and ${scorable} = 'Scorable' then ${dim_course.courseid} end;;
    hidden:  yes
  }

  measure:  count_notscorable {
    label: "# Non-scorable activities"
    description: "No. of courses with this as neither a practice or gradable activity"
    type: count_distinct
    sql: case when ${gradable} != 'Graded' and ${scorable} != 'Scorable' then ${dim_course.courseid} end;;
    hidden:  yes
  }

  measure:  gradable_percent {
    label: "% Gradable"
    description: "proportion of times activity was gradable"
    type: number
    sql:  ${count_gradable}/${count};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  practice_percent {
    label: "% Practice"
    description: "proportion of times activity was practice"
    type: number
    sql:  ${count_practice}/${count};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  notscorable_percent {
    label: "% Non-scorable"
    description: "proportion of times activity was not practice or gradable e.g. reading activity"
    type: number
    sql:  ${count_notscorable}/${count};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  gradable_vs_practice {
    label: "% Gradable vs Practice"
    description: "Visual representation of the proportion of times an activity was gradable vs practice"
    sql: ${gradable_percent} ;;
    html:
    <div style="position:absolute;height:100%;width:100%;border:thin solid darkgray;">
      <div style="height:6px;width: {{gradable_percent._rendered_value}};background-color: rgba(17,160,17, 0.8);text-align:center; overflow:visible" title="gradable: {{gradable_percent._rendered_value}}">&nbsp;</div>
      <div style="height:6px;width: {{practice_percent._rendered_value}};background-color: rgba(255,136,0, 0.8);text-align:center; overflow:visible" title="practice: {{practice_percent._rendered_value}}">&nbsp;</div>
    </div>
    ;;
  }

  measure:  not_practice_or_graded_percent {
    label: "% not practice or gradable"
    description: "proportion of times activity was neither practice or gradable"
    type: number
    #sql:  ${count} - (${count_practice} + ${count_practice})/${count};; --- Calculation was not adding up this is the old calculation. Below is new. Please correct if I misunderstood (Chip)
    sql:  (${count} - (${count_practice} + ${count_gradable}))/${count};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: gradable_course_user_count {
    label: "# Activations for courses where activity is graded"
    type: sum_distinct
    sql: ${fact_activation_by_course.noofactivations_base} ;;
    sql_distinct_key: ${fact_activation_by_course.courseid} ;;
    filters: {
      field: status
      value: "graded"
    }
  }

  measure: practice_course_user_count {
    label: "# Activations for courses where activity is practice"
    type: sum_distinct
    sql: ${fact_activation_by_course.noofactivations_base} ;;
    sql_distinct_key: ${fact_activation_by_course.courseid} ;;
    filters: {
      field: status
      value: "practice"
    }
  }

  measure: unassigned_course_user_count {
    label: "# Activations for courses where activity has been unassigned"
    type: sum_distinct
    sql: ${fact_activation_by_course.noofactivations_base} ;;
    sql_distinct_key: ${fact_activation_by_course.courseid} ;;
    filters: {
      field: status
      value: "unassigned"
    }
  }

  measure: nonscorable_course_user_count {
    label: "# Activations for courses where activity is not scored"
    type: sum_distinct
    type: sum_distinct
    sql: ${fact_activation_by_course.noofactivations_base} ;;
    sql_distinct_key: ${fact_activation_by_course.courseid} ;;
    filters: {
      field: status
      value: "nonscorable"
    }
  }

  measure:  unassigned_activity_percent {
    label: "% activity unassigned from Master LP"
    description: "Percent of time a given activity was removed from the master learning path by an instructor."
    type:  number
    sql: (${fact_activation_by_product.activations_for_isbn}-${fact_activation_by_course.total_noofactivations}) / ${fact_activation_by_product.activations_for_isbn} ;;
    value_format_name: percent_1
    hidden: no
  }
}
