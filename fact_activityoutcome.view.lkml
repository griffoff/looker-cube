view: fact_activityoutcome {
  label: "Learning Path"
  sql_table_name: DW_GA.FACT_ACTIVITYOUTCOME ;;

  dimension: rowid {
    type: number
    sql: ${TABLE}.ROWID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: id {
    type: number
    sql: ${TABLE}.ID ;;
    hidden: yes
  }

  dimension: activityid {
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
    hidden: yes
  }

  dimension: attemptcompleted {
    type: string
    sql: ${TABLE}.ATTEMPTCOMPLETED ;;
    hidden: yes
  }

  dimension: autosubmitted {
    label: "Auto submitted"
    type: string
    hidden: yes
    sql: ${TABLE}.AUTOSUBMITTED ;;
  }

  dimension: completed {
    type: string
    sql:  CASE
              WHEN ${TABLE}.COMPLETED = 'true' THEN 'Completed'
              WHEN ${TABLE}.COMPLETED = 'false' THEN 'Started (Not Completed)'
          ELSE 'Not Attempted'
          END;;
  }

  dimension: completeddatekey {
    type: string
    sql: ${TABLE}.COMPLETEDDATEKEY ;;
    hidden: yes
  }

  dimension: course_weight {
    type: number
    sql: ${TABLE}.COURSE_WEIGHT ;;
    hidden: yes
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: daysbeforecourseend {
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
    hidden: yes
  }

  dimension: daysfromcoursestart {
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART ;;
    hidden: yes
  }

  dimension: daysleftbeforeduedate {
    type: string
    sql: ${TABLE}.DAYSLEFTBEFOREDUEDATE ;;
    hidden: yes
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension_group: dw_ldts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
    hidden: yes
  }

  dimension: institutionid {
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
    hidden: yes
  }

  dimension: institutionlocationid {
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
    hidden: yes
  }

  dimension: latestflag {
    type: string
    sql: ${TABLE}.LATESTFLAG ;;
    hidden: yes
  }

  dimension: learningpathid {
    type: string
    sql: ${TABLE}.LEARNINGPATHID ;;
    hidden: yes
  }

  dimension_group: loaddate {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  measure: nooffails {
    label: "Total no. of fails"
    type: sum
    sql: ${TABLE}.NOOFFAILS ;;
    hidden: yes
  }

  measure: noofpasses {
    label: "Total no. of passes"
    type: sum
    sql: ${TABLE}.NOOFPASSESS ;;
    hidden: yes
  }

  measure: passpercent {
    label: "Pass percentage"
    type: number
    sql: ${noofpasses} / NULLIF(NVL(${noofpasses}, 0) + NVL(${nooffails}, 0), 0) ;;
    value_format: "0.0\%"
    hidden: yes
  }

  dimension: nooftakes_bucket {
    label: "No. of Takes Buckets"
    type: tier
    tiers: [1, 2, 3, 5, 10]
    style: integer
    hidden: yes
    sql: ${TABLE}.NOOFTAKES ;;
  }

  measure: nooftakes_avg {
    label: "Avg. no. of Takes"
    type: average
    hidden: yes
    sql: ${TABLE}.nooftakes::float ;;
    value_format_name: decimal_1
  }

  measure: nooftakes_sum {
    label: "# of Takes"
    type: sum
    hidden: yes
    sql: ${TABLE}.nooftakes::int ;;
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  measure: points_earned {
    type: number
    sql: ${TABLE}.POINTS_EARNED ;;
    hidden: yes
  }

  measure: points_possible {
    type: number
    sql: ${TABLE}.POINTS_POSSIBLE ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: score {
    type: number
    sql: case when ${TABLE}.SCORE > 100 then 100 when ${TABLE}.SCORE <0 then null else ${TABLE}.SCORE end / 100.0 ;;
    hidden: yes
  }

  measure: score_avg {
    label: "Score (avg)"
    type: average
    sql: ${score} ;;
    value_format_name: percent_1
    html: {% if value >= 0.9 %}
       {% assign intensity = value | minus: 0.9 | divided_by: 0.1 %}
       {% assign color="17, 160, 17" %}
       {% assign fontcolor="white" %}
      {% elsif value >= 0.7 %}
       {% assign intensity = value | minus: 0.7 | divided_by: 0.2 %}
       {% assign color="255,248,71" %}
       {% assign fontcolor="black" %}
      {% else %}
       {% assign intensity = 0.7 | minus: value | divided_by: 0.7 %}
       {% assign color="211,6,6" %}
       {% assign fontcolor="white" %}
      {% endif %}
      {% if intensity < 0.5 %}
        {% assign intensity = 0.5%}
      {% endif %}
      <div style="width:100%;">
        <div style="width: {{score_dev_upper._rendered_value}}; border-right: thin solid darkgray;">
          <div style="width: {{rendered_value}};background-color: rgba({{color}}, {{intensity}});text-align:center; color: {{fontcolor}}; overflow:visible"
                title="avg score: {{rendered_value}}
    +1 std.dev: {{score_dev_upper._rendered_value}}
    -1 std.dev: {{score_dev_lower._rendered_value}}">
            <span style="width: {{score_dev_lower._rendered_value}}; border-right: thin solid darkgray;"></span>
              {{rendered_value}}
          </div>
        </div>
      </div>
      ;;
  }

  measure: score_dev {
    label: "Score (std dev)"
    type: number
    hidden: yes
    sql: STDDEV(${score}) ;;
    value_format_name: percent_1
  }

  measure: score_dev_lower {
    hidden: yes
    type: number
    sql: ${score_avg} - ${score_dev};;
    value_format_name: percent_1
  }

  measure: score_dev_upper {
    hidden: yes
    type: number
    sql: ${score_avg} + ${score_dev} ;;
    value_format_name: percent_1
  }

  measure: score_max {
    label: "Score (max)"
    type: max
    hidden: yes
    sql: ${score} ;;
    value_format_name: percent_1
  }

  measure: score_min {
    label: "Score (min)"
    type: min
    hidden: yes
    sql: ${score} ;;
    value_format_name: percent_1
  }

  dimension: startdatekey {
    type: string
    sql: ${TABLE}.STARTDATEKEY ;;
    hidden: yes
  }

  dimension_group: takeendtime {
    label: "Take End Time"
    type: time
    hidden: yes
    timeframes: [time, date, week, month]
    sql: ${TABLE}.TAKEENDTIME ;;
  }

  dimension: takestartdate {
    label: "Take Start Time"
    type: date
    sql: ${TABLE}.TAKESTARTTIME::date ;;
    hidden: yes
  }

  dimension_group: takestarttime {
    label: "Take Start Time"
    type: time
    hidden: yes
    timeframes: [time, date, week, month]
    sql: ${TABLE}.TAKESTARTTIME ;;
  }

  dimension: timeduration {
    type: number
    # sql: COALESCE(NULLIF(${TABLE}.TIMEDURATION, 0), ${TABLE}.TIMESPENT) /1000.0 ;;
    sql: NULLIF(${TABLE}.TIMESPENT, 0) /1000.0 ;;
    hidden: yes
  }

  measure: duration {
    type: average
    # sql: COALESCE(NULLIF(${TABLE}.TIMEDURATION, 0), ${TABLE}.TIMESPENT) /1000.0 ;;
    sql: NULLIF(${TABLE}.TIMEDURATION /1000.0, 0)/86400.0 ;;
    value_format: "h:mm:ss"
    hidden: yes
  }

  measure: timespent {
    label: "Avg. Time spent"
    type: average
    sql: NULLIF(${TABLE}.TIMESPENT /1000.0, 0)/86400.0 ;;
    value_format: "h:mm:ss"
    hidden: yes
  }

  measure: timeduration_avg {
    label: "Avg. Duration"
    type: average
    hidden: yes
    sql: ${timeduration}/86400.0 ;;
    value_format: "h:mm:ss"
  }

  dimension: timeduration_bucket {
    label: "Duration Buckets"
    type: tier
    hidden: yes
    tiers: [0, 5, 15, 30, 60]
    style: relational
    sql: ${TABLE}.TIMEDURATION/60.0 ;;
    value_format: "0 \m\i\n\s"
  }

  dimension: timekey {
    type: string
    sql: ${TABLE}.TIMEKEY ;;
    hidden: yes
  }

  dimension: user_weight {
    label: "Weight"
    type: number
    sql: ${TABLE}.USER_WEIGHT ;;
    hidden: yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  measure: usercount {
    type: count_distinct
    sql: case when ${score} >= 0 then (${TABLE}.USERID) end ;;
    label: "# of users completed"
  }

  measure: count {
    type: count
    drill_fields: [id]
    hidden: yes
  }
}
