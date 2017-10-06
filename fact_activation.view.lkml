view: fact_activation {
  view_label: "Activations"
  #sql_table_name: ZPG_ACTIVATIONS.DW_GA.FACT_ACTIVATION ;;
  derived_table: {
    sql:
      with activation_orgs as (
        select
            actv_code
            ,organization
            ,count(*) as cnt
        from stg_clts.activations_olr
        where organization is not null
        and in_actv_flg = 1
        group by 1, 2
      )
      ,orgs as (
        select
           actv_code
           ,organization
           ,row_number() over (partition by actv_code order by cnt desc) as r
        from activation_orgs
      )
      select a.*, orgs.organization
      from DW_GA.FACT_ACTIVATION a
      left join orgs on a.activationcode = orgs.actv_code
                    and orgs.r = 1
      order by courseid, activationdatekey, activationregionid;;

      sql_trigger_value: select count(*) from DW_GA.FACT_ACTIVATION ;;
  }


  set: coursedetails {
    fields: [dim_course.coursekey, activationcode]
  }

  set: ALL_FIELDS {
    fields: [courseid,avg_noofactivations,course_count,institution_count,noofactivations_base,total_noofactivations,institutionid]
  }

  dimension: organization {
    label: "Organization"
  }

  dimension: HED_filter {
    view_label: "** RECOMMENDED FILTERS **"
    label: "HED filter (from activation)"
    description: "Flag to identify Higher-Ed data - based on data in activations feed"
    type:  yesno
    sql: ${organization} = 'Higher Ed' ;;
  }

  dimension: activationcode {
    type: string
    sql: ${TABLE}.ACTIVATIONCODE ;;
    hidden: yes
  }

  dimension: activationcodeuser {
    type: string
    sql: ${TABLE}.ACTIVATIONCODE_USER ;;
    hidden: yes
    primary_key: yes
  }

  dimension: activationdatekey {
    hidden: yes
    type: string
    sql: ${TABLE}.ACTIVATIONDATEKEY ;;
  }

  dimension: activationtypeid {
    hidden: yes
    type: string
    sql: ${TABLE}.ACTIVATIONTYPEID ;;
  }

  dimension: courseid {
    hidden: yes
    type: string
    sql: ${TABLE}.COURSEID ;;
  }

  dimension: daysbeforecourseend {
    hidden: yes
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
  }

  dimension: daysfromcoursestart {
    hidden: yes
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART ;;
  }

  dimension: dw_ldid {
    hidden: yes
    type: string
    sql: ${TABLE}.DW_LDID ;;
  }

  dimension_group: dw_ldts {
    hidden: yes
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
    hidden:  yes
  }

  dimension: institutionid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
  }

  dimension: institutionlocationid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
  }

  dimension_group: loaddate {
    hidden: yes
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
  }

  dimension: noofactivations_base {
    type: number
    sql: ${TABLE}.NOOFACTIVATIONS ;;
    hidden: yes
  }

  measure: total_noofactivations {
    label: "Total Activations"
    description: "Represents the total number of activations associated with the query structure set up in Looker and the selected filtering criteria.

      Example: if you set up Looker to look at completed learning path activities, the measure 'Total Activations' will indicated how many accounts completed a given activity
      and NOT how many accounts 'saw' or could have completed a given activity.

      Meaning, 'Total Activations' cannot be used as a denominator for any '% of activation' calculations."
    type: sum
    sql: ${noofactivations_base} ;;
    drill_fields: [coursedetails*]
  }

  measure: avg_noofactivations {
    label: "Avg. Activations"
    type: average
    sql: ${noofactivations_base} ;;
    drill_fields: [coursedetails*]
    hidden:  yes
  }

  dimension: partyid {
    hidden: yes
    type: string
    sql: ${TABLE}.PARTYID ;;
  }

  dimension: productid {
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCTID ;;
  }

  dimension: productplatformid {
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
  }

  dimension: userid {
    hidden: yes
    type: string
    sql: ${TABLE}.USERID ;;
  }

  dimension: activationfilterid {
    hidden: yes
    type: number
    sql: ${TABLE}.ACTIVATIONFILTERID ;;
  }

  dimension: activationregionid {
    hidden: yes
    type: number
    sql: ${TABLE}.ACTIVATIONREGIONID ;;
  }

  measure: user_count {
    label: "# Users Activated"
    description: "Distinct count of users (GUIDs) with at least 1 activations based on user-selected filtering criteria.
      This number should be less than or equal to the total activations measure as users may have more than one activation
      for the user-selected filtering criteria (e.g. they use MindTap for multiple courses)"
    type: count_distinct
    sql:${userid} ;;
  }

  measure: user_percent_of_total {
    label: "# Users % of total"
    type: percent_of_total
    sql: ${user_count} ;;
    hidden: yes
  }

  measure: institution_count {
    label: "# Institutions with activations"
    description: "Distinct count of institutions with at least 1 activation based on user-selected filtering criteria.
      Useful as a high-level measure."
    type: count_distinct
    sql: case when ${TABLE}.NOOFACTIVATIONS > 0 then ${dim_institution.institutionid} end ;;
  }

  measure: course_count_including_no_activations {
    label: "# Course sections"
    description: "Distinct count of course keys regardless of number of activations based on user-selected filtering criteria.
    Useful as a high-level measure."
    type: count_distinct
    sql: ${courseid} ;;
  }

  dimension: activations_per_course {
    hidden:  yes
    type: number
    sql:  ${course_section_facts.noofactivations_base} ;;
  }

  measure: course_count {
    label: "# Course sections with activations"
    description: "Distinct count of course keys with at least 1 activation based on user-selected filtering criteria.
      Useful as a high-level measure."
    type: count_distinct
    sql: ${courseid} ;;
  }

  measure: course_count_minimum_activations {
    label: "# Course sections with at least 5 activations"
    description: "Distinct count of course keys with at least 5 activation based on user-selected filtering criteria.
    Useful as a high-level measure."
    type: count_distinct
    sql: case when ${activations_per_course} >= 5 then ${courseid} end ;;
  }
}
