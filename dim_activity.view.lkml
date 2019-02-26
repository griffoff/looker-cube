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
        end as status,
        case when a.assigned not in (2, 3) then 1 else 0 end as available,
        a.estimatedminutes
      FROM dw_ga.dim_activity a
      ;;
      sql_trigger_value: select count(*) from dw_ga.dim_activity ;;
  }
  set: curated_fields {fields:[gradable_percent,practice_percent,notscorable_percent,unassigned_percent,APPLICATIONNAME,count_gradable,status,cengage_app,activity_app_type]}

  set: curated_fields_PM {fields:[APPLICATIONNAME,count_gradable,status]}
  set: curated_fields_WL {fields:[APPLICATIONNAME,count_gradable,status,estimated_minutes,activitysubcategory,activityid]}

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

  dimension: estimated_minutes {
    group_label: "CLA Events"
    label: "Estimated Minutes"
    description: "Pre-defined estimated time to complete an activity"
    type: number
    sql: ${TABLE}.ESTIMATEDMINUTES ;;
  }

  dimension: activityid {
    type: number
    sql: ${TABLE}.ACTIVITYID ;;
    primary_key: yes
    hidden: no
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
#     sql: Case
#             WHEN ${TABLE}.APPLICATIONNAME = "CENGAGE.READER" then "Reader"
#             WHEN ${TABLE}.APPLICATIONNAME = "MINDAPP-GROVE" and ${activitysubtype} = "media-quiz" then "Video Media/Quiz"
#             WHEN ${TABLE}.APPLICATIONNAME = "MINDAPP-GROVE" and ${activitysubtype} = "branching" then "Branching"
#           ELSE
#             ${TABLE}.APPLICATIONNAME
#           END
#           ;;

  }

  dimension: cengage_app {
    label: "first party app category"
    sql: CASE WHEN ${TABLE}.APPLICATIONNAME IN ('ADAPTIVE','APLIA','APLIAMOBILE','CNOW.HW','SAM.APPIFICATION.PROD','WEBASSIGN','WEBVIDEO.APP')
          OR ${TABLE}.APPLICATIONNAME ILIKE 'CENGAGE.%' OR ${TABLE}.APPLICATIONNAME ILIKE 'MILADY.%' OR ${TABLE}.APPLICATIONNAME ILIKE 'MINDAPP%'
          THEN 'yes'
          ELSE 'no'
          END;;
  }

  dimension: activity_app_type {
    label: "activity app category"
    sql: CASE WHEN ${TABLE}.APPLICATIONNAME  IN ('ADAPTIVE','APLIA','APLIAMOBILE','CNOW.HW','SAM.APPIFICATION.PROD','WEBASSIGN','CENGAGE.ASSIGNMENT','CENGAGE.MINDTAPCASACTIVITYPLAYER')
          THEN 'Assessment'
           WHEN ${TABLE}.APPLICATIONNAME  IN ('CENGAGE.FLASHCARD','CENGAGE.READER','CENGAGE.READER.MT4','CENGAGE.RSSFEED','FLASHNOTES','CENGAGE.RSSFEED') OR ${TABLE}.APPLICATIONNAME ilike 'DLMT%'
          THEN 'Narrative'
           WHEN ${TABLE}.APPLICATIONNAME  IN ('WEBVIDEO.APP','MOBLABGAMES','CENGAGE.MEDIA','COGLAB')
          THEN 'Media'
          ELSE 'Unknown'
          END;;
  }
#
#   dimension: _app_type {
#     label: "first party app category"
#     sql: CASE WHEN ${APPLICATIONNAME} IN ('ADAPTIVE','APLIA','APLIAMOBILE','CNOW.HW','SAM.APPIFICATION.PROD','WEBASSIGN','WEBVIDEO.APP','CENGAGE.ASSIGNMENT','CENGAGE.MINDTAPCASACTIVITYPLAYER')
#           THEN 'Assessment'
#           CASE WHEN ${APPLICATIONNAME} IN ('CENGAGE.FLASHCARD','CENGAGE.READER','CENGAGE.READER.MT4','CENGAGE.RSSFEED','FLASHNOTES','CENGAGE.RSSFEED') OR ${APPLICATIONNAME} ilike 'DLMT%'
#           THEN 'Narrative'
#           CASE WHEN ${APPLICATIONNAME} IN ('WEBVIDEO.APP','MOBLABGAMES','CENGAGE.MEDIA','COGLAB')
#           THEN 'Media'
#           ELSE 'Unknown'
#           END;;
#   }

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
    label: "# Courses with this Activity"
    description: "The count of courses containing an activity"
    type: count_distinct
    sql: ${dim_course.courseid} ;;
  }

  measure:  count_gradable_activity {
    label: "# Gradable activities"
    description: "No. of gradable activities"
    type: count
    filters: {
      field: gradable
      value: "Graded"
    }
  }

  measure:  count_gradable {
    label: "# Gradable courses"
    description: "No. of courses with this as a gradable activity"
#    sql: case when ${gradable} = 'Graded' then ${dim_course.courseid} end;;
#     hidden:  yes
    type: count_distinct
    sql: ${dim_course.courseid} ;;
    filters: {
      field: status
      value: "graded"
    }
  }

  measure:  count_unassigned {
    label: "# Unassigned courses"
    description: "No. of courses where this activity is unavailable"
    type: count_distinct
#    sql: case when ${gradable} = 'Graded' then ${dim_course.courseid} end;;
#     hidden:  yes
    sql: ${dim_course.courseid} ;;
    filters: {
      field: status
      value: "unassigned"
    }
  }

  measure:  count_practice {
    label: "# Practice courses"
    description: "No. of courses with this as a practice activity"
    type: count_distinct
#    sql: case when ${gradable} != 'Graded' and ${scorable} = 'Scorable' then ${dim_course.courseid} end;;
#     hidden:  yes
    sql: ${dim_course.courseid} ;;
    filters: {
      field: status
      value: "practice"
    }
  }

  measure:  count_notscorable {
    label: "# Non-scorable courses"
    description: "No. of courses with this as neither a practice or gradable activity"
    type: count_distinct
#     sql: case when ${gradable} != 'Graded' and ${scorable} != 'Scorable' then ${dim_course.courseid} end;;
#    hidden:  yes
    sql: ${dim_course.courseid} ;;
    filters: {
      field: status
      value: "nonscorable"
     }
  }

  measure:  gradable_percent {
    group_label: "% Calcs - Course Level"
    label: "% Gradable - course level"
    description: "Percent of courses where a given activity was gradable"
    type: number
#     sql:  ${count_gradable}/${count};;
    sql:  ${count_gradable}/${denominator_course_percent_calcs};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  practice_percent {
    group_label: "% Calcs - Course Level"
    label: "% Practice - course level"
    description: "Percent of courses where a given activity was scorable but did not count towards a student's grade"
    type: number
#     sql:  ${count_practice}/${count};;
    sql:  ${count_practice}/${denominator_course_percent_calcs};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  notscorable_percent {
    group_label: "% Calcs - Course Level"
    label: "% Non-scorable - course level"
    description: "Percent of courses where a given activity was not practice or gradable (e.g. reading activity)"
    type: number
#     sql:  ${count_notscorable}/${count};;
    sql:  ${count_notscorable}/${denominator_course_percent_calcs};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  unassigned_percent {
    group_label: "% Calcs - Course Level"
    label: "% Unavailable - course level"
    description: "Percent of courses where a given activity not available
    (either it was removed/hidden or the course was created from a master without this activity)"
    type: number
#     sql:  ${count_notscorable}/${count};;
    sql:  ${count_unassigned}/${denominator_course_percent_calcs};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  not_practice_or_graded_percent {
    label: "% Not practice or gradable"
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

  measure:  unassigned_activity_percent {
    label: "% Activity unassigned from Master LP"
    description: "Percent of time a given activity was removed from the master learning path by an instructor."
    type:  number
    sql: (${product_facts.activations_for_isbn}-${course_section_facts.total_noofactivations}) / nullif(${product_facts.activations_for_isbn}, 0) ;;
    value_format_name: percent_1
    hidden: yes
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
    drill_fields: [institutionDetails*]
  }

  measure: denominator_course_percent_calcs {
    #sql: nullif((${count_gradable}+${count_practice}+${count_notscorable}),0) ;;
    type: count_distinct
    sql: ${dim_course.courseid} ;;
#     hidden: yes
  }

  measure:  gradable_exposure_percent {
    group_label: "% Calcs - Student Exposure"
    label: "% Gradable - student level"
    description: "Percent of student exposed to a given activity marked gradable by an instructor (counts towards student grade)"
    type: number
#     sql:  ${count_gradable}/nullif(${count}, 0);;
    sql:  ${gradable_course_user_count}/nullif(${denominator_student_exposure_percent_calcs}, 0) ;;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  practice_exposure_percent {
    group_label: "% Calcs - Student Exposure"
    label: "% Practice - student level"
    description: "Percent of students exposed to a given activity marked as practice by an instructor (scoreable but does not count torwards student's grade)"
    type: number
#     sql:  ${count_practice}/${count};;
    sql:  ${practice_course_user_count}/${denominator_student_exposure_percent_calcs} ;;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  notscorable_exposure_percent {
    group_label: "% Calcs - Student Exposure"
    label: "% Non-scorable - student level"
    description: "Percent of students exposed to a given activity that an instructor has deemed not scoreable (e.g. a reading activity)"
    type: number
#     sql:  ${count_notscorable}/${count};;
    sql:  ${nonscorable_course_user_count}/${denominator_student_exposure_percent_calcs};;
    value_format_name:  percent_1
    hidden:  no
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

  measure:  unassigned_exposure_percent {
    group_label: "% Calcs - Student Exposure"
    label: "% Unavailable - student level"
    description: "Percent of students not exposed to a given activity"
    type: number
#     sql:  ${count_notscorable}/${count};;
    sql:  ${unassigned_course_user_count}/${denominator_student_exposure_percent_calcs};;
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

  dimension: status {
    label: "Activity Status"
    description: "
    “Graded” = Student gets a score (scorable) and the score counts towards his/her grade (gradable)
    “Practice” = Student gets a score (scorable) but the activity does NOT count towards his/her grade (not gradable)
    “Non-scorable” = Students cannot get a score for the activity (typically videos and readings)
    “Unassigned” = activity was removed from the student’s learning path
    "
    hidden: no
#     type: string
#     case: {
#       when: {
#         label: "Graded"
#         sql: ${TABLE}.status = 'graded' ;;
#       }
#       when: {
#         label: "Practice"
#         sql: ${TABLE}.status = 'practice' ;;
#       }
#       when: {
#         label: "Non-scorable"
#         sql: ${TABLE}.status = 'nonscorable' ;;
#       }
#       when: {
#         label: "Unassigned"
#         sql: ${TABLE}.status = 'unassigned' ;;
#       }
#     }
    sql: ${TABLE}.status ;;
  }

  dimension: available {
    hidden: yes
    type: string
    sql: ${TABLE}.available ;;
  }

  dimension: activitychangetype {
    label: "Status Change Description"
    hidden: yes
  }

  set:  institutionDetails {
    fields: [dim_institution.institutionname, dim_eventtype.eventtypename, status, originallygradable, gradable, originalscorable, scorable, dim_course.count, course_section_facts.total_noofactivations]
  }

  measure: gradable_course_user_count {
    label: "# Activations for courses where activity is graded"
    type: sum_distinct
    sql: ${course_section_facts.noofactivations_base} ;;
    sql_distinct_key: ${course_section_facts.courseid} ;;
    filters: {
      field: status
      value: "graded"
    }
    drill_fields: [institutionDetails*]
  }

  measure: practice_course_user_count {
    label: "# Activations for courses where activity is practice"
    type: sum_distinct
    sql: ${course_section_facts.noofactivations_base} ;;
    sql_distinct_key: ${course_section_facts.courseid} ;;
    filters: {
      field: status
      value: "practice"
    }
    drill_fields: [institutionDetails*]
  }

  measure: nonscorable_course_user_count {
    label: "# Activations for courses where activity is not scored"
    type: sum_distinct
    sql: ${course_section_facts.noofactivations_base} ;;
    sql_distinct_key: ${course_section_facts.courseid} ;;
    filters: {
      field: status
      value: "nonscorable"
    }
    drill_fields: [institutionDetails*]
  }

  measure: unassigned_course_user_count {
    label: "# Activations for courses where activity has been unassigned"
    type: sum_distinct
    sql: ${course_section_facts.noofactivations_base} ;;
    sql_distinct_key: ${course_section_facts.courseid} ;;
    filters: {
      field: status
      value: "unassigned"
    }
    drill_fields: [institutionDetails*]
  }

  measure: denominator_student_exposure_percent_calcs {
    #sql: nullif((coalesce(${gradable_course_user_count},0)+coalesce(${practice_course_user_count},0)+coalesce(${nonscorable_course_user_count},0)),0) ;;
    type: sum_distinct
    sql: ${course_section_facts.noofactivations_base} ;;
    sql_distinct_key: ${course_section_facts.courseid} ;;
#     hidden: yes
  }

  measure: available_course_user_count {
    label: "# Activations for courses where activity is available"
    type: sum_distinct
    sql: ${course_section_facts.noofactivations_base} ;;
    sql_distinct_key: ${course_section_facts.courseid} ;;
    filters: {
      field: available
      value: "1"
    }
    drill_fields: [institutionDetails*]
  }

#   measure: course_user_count {
#     label: "# Activations for courses where activity should have been available"
#     type: number
#     sql: ${course_section_facts.noofactivations_base} ;;
#     sql_distinct_key: ${course_section_facts.courseid} ;;
#     drill_fields: [institutionDetails*]
#   }

#   measure: percent_exposure {
#     label: "% Exposed"
#     type: number
#     description: "% of students to whom this item was in the learning path, of all the students on courses where this item was in the master"
#     sql: ${available_course_user_count} / nullif(${course_user_count}, 0) ;;
#     value_format_name: percent_1
#     html:
#     <div style="width:100%;">
#     <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
#     </div>
#     ;;
#   }

  measure: percent_usage {
    label: "% Usage"
    type: number
    description: "% of students who did this, of all the students who where exposed to this"
    sql: greatest(${fact_siteusage.usercount}, ${fact_activityoutcome.usercount}) / nullif(${available_course_user_count}, 0) ;;
    value_format_name: percent_1
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }

#   measure: percent_completed {
#     label: "% Completed"
#     type: number
#     description: "% of students who completed this, of all the students who where exposed to this"
#     sql: ${fact_activityoutcome.usercount_withscore} / nullif(${available_course_user_count}, 0) ;;
#     value_format_name: percent_1
#     html:
#     <div style="width:100%;">
#     <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
#     </div>
#     ;;
#   }

  measure: percent_usage_of_gradable {
    label: "% Usage (of gradable)"
    type: number
    description: "% of students who did this, of all the students who where on courses where this was gradable"
    sql: ${fact_siteusage.usercount} / nullif(${gradable_course_user_count}, 0) ;;
    value_format_name: percent_1
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>
    ;;
  }


}
