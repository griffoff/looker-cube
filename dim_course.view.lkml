view: dim_course {
  view_label: "Course / Section Details"
  #sql_table_name: DW_GA.DIM_COURSE ;;
  derived_table: {
    sql:
    with course_orgs as (
      select
          context_id
          ,organization
          ,count(*) as cnt
          ,SUM(CASE WHEN cu_flg ilike 'Y' then 1 ELSE 0 END ) as cu_ct
          ,SUM(CASE WHEN cu_flg ilike 'N' then 1 ELSE 0 END ) as noncu_ct
      from prod.stg_clts.activations_olr
      where organization is not null
      and in_actv_flg = 1
      group by 1, 2
    )
    ,orgs as (
      select
         context_id
         ,organization
         ,cu_ct
         ,noncu_ct
         ,row_number() over (partition by context_id order by cnt desc) as r
      from course_orgs
    )
    select dc.*
          ,c.course_key as olr_course_key
          ,c."#CONTEXT_ID" as olr_context_id
          ,c.mag_acct_id
          ,orgs.organization
          ,orgs.cu_ct
          ,orgs.noncu_ct
          ,to_char(dc.STARTDATE, 'YYYYMMDD')::int as startdatekey_new
          ,dc.enddate < current_date() as course_complete
    from prod.dw_ga.dim_course dc
    left join prod.stg_clts.olr_courses c on dc.coursekey = c."#CONTEXT_ID"
    left join orgs on dc.coursekey = orgs.context_id
                  and orgs.r = 1
    order by olr_course_key
    ;;
    sql_trigger_value: select count(*) from dw_ga.dim_course ;;
  }

  set: marketing_fields {fields:[dim_course.coursename, dim_course.enddatekey, dim_course.startdatekey, dim_course.coursekey, dim_course.mag_acct_id, active_course_sections]}
  set: cu_explore_fields {fields:[dim_course.coursename, dim_course.enddatekey, dim_course.startdatekey, dim_course.coursekey, dim_course.mag_acct_id]}

  # Attempt to classify courses into organizations (like higher ed, but activations don't always have a coursekey...
  # So this is no good

  dimension: organization {
    label: "Organization"
    hidden: yes
  }

  dimension: HED_filter {
    hidden: yes
    view_label: "** RECOMMENDED FILTERS **"
    label: "HED filter (from course)"
    description: "Flag to identify Higher-Ed data - based on data in activations feed"
    type:  yesno
    sql: ${organization} = 'Higher Ed' ;;
  }

  set: curated_fields {fields: [courseid, coursename, is_lms_integrated, count,cu_ct,noncu_ct]}


   dimension: mag_acct_id {
     hidden: yes
   }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: olr_course_key {
    hidden: yes
    type: string
    sql: ${TABLE}.olr_course_key ;;
  }

  dimension: context_id {
    label: "Context ID"
    type: string
    sql: ${TABLE}.olr_context_id ;;
    #sql: ${TABLE}.coursekey ;;
    hidden:  yes
  }

  dimension: coursekey {
    label: "Context ID"
    type: string
    sql: ${TABLE}.coursekey ;;
    description: "OLR Context ID"

    link: {
      label: "Explore Mindtap Learning Path for this Course/Section"
      url: "/explore/cube/fact_siteusage?fields=dim_learningpath.lowest_level,dim_activity.activitysubcategory,fact_activityoutcome.score_avg,dim_user.count,&f[dim_course.coursekey]={{ value }}"
    }

    link: {
      label: "View Account in Magellan"
#       url: "http://magellan.cengage.com/Magellan2/#/Contacts/{{ mag_acct_id._value }}"
    }

    link: {
      label:"View in Analytics Diagnostic Tool"
      url: "https://analytics-tools.cengage.info/diagnostictool/#/course/view/production/course-key/{{value}}"
    }

    # link: {
    #   label: "Engagement Toolkit (Looker)"
    #   url: "https://cengage.looker.com/dashboards/test::engagement_toolkit?filter_course={{value}}"
    # }

    # link: {
    #   label: "Engagement Toolkit"
    #   url: "http://dashboard.cengage.info/engtoolkit/{{value}}"
    # }

    # link: {
    #   label: "Engagement Toolkit - Discipline"
    #   url: "http://dashboard.cengage.info/engtoolkit/discipline/{{dim_product.hed_discipline._value}}"
    # }
  }

  dimension: coursename {
    label: "Course Name"
    type: string
    sql: ${TABLE}.COURSENAME ;;

    link: {
      label:"View in Analytics Diagnostic Tool"
      url: "https://analytics-tools.cengage.info/diagnostictool/#/course/view/production/course-key/{{dim_course.coursekey._value}}"
    }

    link: {
      label: "Engagement Toolkit Looker"
      url: "https://cengage.looker.com/dashboards/test::engagement_toolkit?filter_course={{dim_course.coursekey._value}}"
    }

    link: {
      label: "Engagement Toolkit"
      url: "http://dashboard.cengage.info/engtoolkit/{{value}}"
    }

    link: {
      label: "Engagement Toolkit - Discipline"
      url: "http://dashboard.cengage.info/engtoolkit/discipline/{{dim_product.hed_discipline._value}}"
    }
  }

  dimension: cu_ct {
    label: "# CU Students"
    description: "No of CU students activated for a particular course key"
    sql: ${TABLE}.cu_ct ;;
    hidden: yes
  }


  dimension: noncu_ct {
    label: "# Non CU Students"
    description: "No of Non-CU students activated for a particular course key"
    sql: ${TABLE}.noncu_ct ;;
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

  dimension: enddatekey {
    type: string
    sql: ${TABLE}.ENDDATEKEY ;;
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

  dimension: learningcourse {
    type: string
    sql: ${TABLE}.LEARNINGCOURSE ;;
    hidden: yes
  }

  dimension_group: loaddate {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden: yes
  }

  dimension: startdatekey {
    type: number
    sql: ${TABLE}.startdatekey_new ;;
    hidden: yes
  }

  dimension: is_lms_integrated {
    label: "LMS Integrated"
    type: yesno
    sql: length(split_part(dim_course.coursekey, '-', 1)) > 15
        and array_size(split(dim_course.coursekey, '-')) >= 2
        and ${productplatformid}= 26 ;;
  }

  dimension: course_complete {
    label: "Is Course Finished?"
    type: yesno
  }

  measure: active_course_sections {
    label: "# Currently Active Course Sections"
    description: "# Course sections with an end date in the future"
    type: count_distinct
    sql: CASE WHEN NOT course_complete THEN ${coursekey} END ;;
  }

  measure: count {
    label: "# Course Sections"
    description: "Count of course sections."
    type: count
    drill_fields: [dim_institution.institutionname, coursekey, coursename, dim_start_date.calendarmonthname,mindtap_lp_activity_tags.learning_path_activity_title_count, course_section_facts.total_noofactivations]
  }
}
