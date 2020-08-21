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
    select
          DISTINCT
          dc.DW_LDID
          ,dc.DW_LDTS
          ,dc.COURSEID
          ,dc.COURSEKEY
          ,scs.course_name as COURSENAME
          ,dc.INSTITUTIONID
          ,dc.PRODUCTID
          ,to_char(scs.begin_date, 'YYYYMMDD')::int as STARTDATEKEY
          ,to_char(scs.end_date, 'YYYYMMDD')::int as ENDDATEKEY
          ,dc.FILTERFLAG
          ,dc.LEARNINGCOURSE
          ,dc.LOADDATE
          ,dc.PRODUCTPLATFORMID
          ,dc.INSTRUCTORID
          ,scs.course_cgi as CGI
          ,scs.begin_date as STARTDATE
          ,scs.end_date as ENDDATE
          ,scs.course_key as olr_course_key
          ,hcs.context_id as olr_context_id
          ,c.mag_acct_id
          ,orgs.organization
          ,orgs.cu_ct
          ,orgs.noncu_ct
          ,scs.end_date < current_date() as course_complete
          ,scs.section_product_type as product_type
          ,scs.begin_date::DATE <= CURRENT_DATE() AND scs.end_date >= CURRENT_DATE()::DATE AS active
          --,COALESCE(scs.institution_id_override, scs.institution_id) as entity_no
          ,c.entity_id_sub as entity_no
          ,c.entity_name_course
          ,scs.is_gateway_course
          ,scs.is_demo
          ,wl.language as default_language
          ,scg.lms_type
          ,scg.lms_version
          ,scg.integration_type
          ,g.lms_sync_course_scores
          ,g.lms_sync_activity_scores
    from prod.dw_ga.dim_course dc
    left join prod.stg_clts.olr_courses c on dc.coursekey = c."#CONTEXT_ID"
    left join prod.datavault.hub_coursesection hcs on dc.coursekey = hcs.context_id
    left join prod.datavault.sat_coursesection scs on hcs.hub_coursesection_key = scs.hub_coursesection_key and scs._latest
    left join orgs on dc.coursekey = orgs.context_id
                  and orgs.r = 1
    left join uploads.course_section_metadata.wa_course_language wl on hcs.context_id = wl.context_id
    left join prod.datavault.link_coursesectiongateway_coursesection lcsg on hcs.hub_coursesection_key = lcsg.hub_coursesection_key
    left join prod.datavault.sat_coursesection_gateway scg on lcsg.hub_coursesectiongateway_key = scg.hub_coursesectiongateway_key and scg._latest
    left join mindtap.prod_nb.gradebook g on dc.coursekey = g.external_id
    order by olr_course_key
    ;;
    sql_trigger_value: select count(*) from dw_ga.dim_course ;;
  }

  set: cu_explore_fields {fields:[dim_course.coursename, dim_course.enddatekey, dim_course.startdatekey, dim_course.coursekey, dim_course.mag_acct_id, dim_course.active_course_sections, dim_course.course_complete, dim_course.product_type]}
  set: marketing_fields {fields:[cu_explore_fields*]}

  dimension: default_language {description: "WebAssign course section default language"}

  dimension: lms_type {
    sql: case when ${TABLE}.lms_type is not null then ${TABLE}.lms_type
              when ${TABLE}.is_gateway_course then 'UNKNOWN'
              else 'NOT LMS INTEGRATED'
        end
     ;;
    label: "LMS Type"
  }

  dimension: lms_integration_type {
    sql: case when ${TABLE}.integration_type is not null then ${TABLE}.integration_type
              when ${TABLE}.is_gateway_course then 'UNKNOWN'
              else 'NOT LMS INTEGRATED'
        end
     ;;
    label: "LMS Integration Type"
  }

  dimension: lms_grade_sync  {
    label: "LMS Grade Sync (MindTap)"
    description: "Type of grade sync for LMS integrated MindTap courses"
    sql: case when ${TABLE}.lms_sync_course_scores then 'Course Level' when ${TABLE}.lms_sync_activity_scores then 'Activity Level' else 'None' end ;;
  }

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

  dimension: course_institution {
    hidden: no
    type: string
    sql: ${TABLE}.entity_name_course ;;
  }

  dimension: course_entity_id {
    hidden: no
    type: string
    sql: ${TABLE}.entity_no ;;
  }

  dimension: context_id {
    label: "Context ID"
    type: string
    sql: ${TABLE}.olr_context_id ;;
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

#     link: {
#       label: "View Account in Magellan"
#        url: "http://magellan.cengage.com/Magellan2/#/Contacts/{{ mag_acct_id._value }}"
#     }

    link: {
      label:"View in Analytics Diagnostic Tool"
      url: "https://analytics-tools.cengage.info/diagnostictool/#/course/view/production/course-key/{{value}}"
    }

  }

  dimension: product_type {
    description: "Course product type (4LT, APPLIA, CNOW, etc.)"
  }

  dimension: coursename {
    label: "Course Name"
    description: "Name of provisioned course"
    type: string
    sql: ${TABLE}.COURSENAME ;;

    link: {
      label:"View in Analytics Diagnostic Tool"
      url: "https://analytics-tools.cengage.info/diagnostictool/#/course/view/production/course-key/{{dim_course.coursekey._value}}"
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
    sql: ${TABLE}.enddatekey ;;
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
    sql: ${TABLE}.startdatekey ;;
    hidden: yes
  }

  dimension: is_lms_integrated {
    description: "Is this a Gateway course?"
    label: "LMS Integrated"
    type: yesno
    sql: CASE WHEN ${lms_type}='NOT LMS INTEGRATED' THEN false ELSE true END ;;
  }

  dimension: course_complete {
    label: "Is Course Finished?"
    description: "Course end date has passed"
    type: yesno
  }

  dimension: active {
    description: "If the course has started and has not finished, it is active"
    label: "Course Active"
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
    description: "Count of course sections (unique count of course key)"
    type: count_distinct
    sql: ${coursekey} ;;
    drill_fields: [dim_institution.institutionname, coursekey, coursename, dim_start_date.calendarmonthname,mindtap_lp_activity_tags.learning_path_activity_title_count, course_section_facts.total_noofactivations]
  }
}
