view: dim_course {
  view_label: "Course / Section Details"
  #sql_table_name: DW_GA.DIM_COURSE ;;
  derived_table: {
    sql:
    select dc.*
          ,c.course_key as olr_course_key
          ,c."#CONTEXT_ID" as olr_context_id
          ,c.mag_acct_id
    from dw_ga.dim_course dc
    left join stg_clts.olr_courses c on dc.coursekey = c."#CONTEXT_ID";;

    sql_trigger_value: select count(*) from dw_ga.dim_course ;;
  }

  set: curated_fields {fields: [courseid, coursename, is_lms_integrated, count]}


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
      url: "/explore/cube/fact_activityoutcome?fields=dim_learningpath.lowest_level,dim_activity.activitysubcategory,fact_activityoutcome.score_avg,dim_user.count,&f[dim_course.coursekey]={{ value }}"
    }

    link: {
      label: "View Account in Magellan"
      url: "http://magellan.cengage.com/Magellan2/#/Contacts/{{ olr_courses.mag_acct_id._value }}"
    }

    link: {
      label:"View in Analytics Diagnostic Tool"
      url: "https://analytics-tools.cengage.info/diagnostictool/#/course/view/production/course-key/{{value}}"
    }

    link: {
      label: "Engagement Toolkit (Looker)"
      url: "https://cengage.looker.com/dashboards/test::engagement_toolkit?filter_course={{value}}"
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
    hidden: no
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
    type: string
    sql: ${TABLE}.STARTDATEKEY ;;
    hidden: yes
  }

  dimension: is_lms_integrated {
    label: "LMS Integrated"
    type: yesno
    sql: length(split_part(dim_course.coursekey, '-', 1)) > 15
        and array_size(split(dim_course.coursekey, '-')) >= 2
        and ${productplatformid}= 26 ;;
  }

  measure: count {
    label: "# Course Sections"
    description: "Count of course sections."
    type: count
    drill_fields: [dim_institution.institutionname, coursekey, coursename, dim_start_date.calendarmonthname, course_section_facts.total_noofactivations]
  }
}
