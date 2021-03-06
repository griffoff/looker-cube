view: dim_course {
  view_label: "Course / Section Details"
  #sql_table_name: DW_GA.DIM_COURSE ;;
  derived_table: {
    sql:
      WITH course_orgs AS (
                        SELECT context_id
                             , organization
                             , count(*) AS cnt
                             , SUM(CASE WHEN cu_flg ILIKE 'Y' THEN 1 ELSE 0 END) AS cu_ct
                             , SUM(CASE WHEN cu_flg ILIKE 'N' THEN 1 ELSE 0 END) AS noncu_ct
                        FROM prod.stg_clts.activations_olr
                        WHERE organization IS NOT NULL
                          AND in_actv_flg = 1
                        GROUP BY 1, 2
                      )
     , orgs AS (
                 SELECT context_id
                      , organization
                      , cu_ct
                      , noncu_ct
                      , row_number() OVER (PARTITION BY context_id ORDER BY cnt DESC) AS r
                 FROM course_orgs
               )
     , el AS (
               SELECT context_id
                    , (sel.cu_enabled OR iac_isbn13 IN ('0000357700006', '0000357700013', '0000357700020')) AS cui
                    , NOT cui AS ia
                    , ROW_NUMBER() OVER (PARTITION BY context_id ORDER BY sel.begin_date DESC) = 1 AS latest
               FROM prod.datavault.hub_coursesection hcs
                    INNER JOIN prod.datavault.sat_coursesection scs
                               ON hcs.hub_coursesection_key = scs.hub_coursesection_key AND scs._latest
                    INNER JOIN prod.datavault.link_coursesection_eltosectionmapping lecsm
                               ON hcs.hub_coursesection_key = lecsm.hub_coursesection_key
                    INNER JOIN PROD.DATAVAULT.LINK_ENTERPRISELICENSE_ELTOSECTIONMAPPING lelsm
                               on lelsm.HUB_ELTOSECTIONMAPPING_KEY = lecsm.HUB_ELTOSECTIONMAPPING_KEY
                    INNER JOIN prod.datavault.sat_enterpriselicense sel
                               ON lelsm.hub_enterpriselicense_key = sel.hub_enterpriselicense_key
                                 AND sel._latest
                                 AND scs.begin_date BETWEEN sel.begin_date AND sel.end_date
                                -- AND sel.end_date > current_date()
                                -- AND sel.begin_date <= current_date()
                    INNER JOIN prod.datavault.sat_eltosectionmapping secsm
                               ON lecsm.hub_eltosectionmapping_key = secsm.hub_eltosectionmapping_key
                                 AND secsm._latest
                                 --AND NOT secsm.deleted
             )
     , lms AS (
              SELECT hcs.hub_coursesection_key
                   , COALESCE(scg.lms_type, a.kind) AS lms_type
                   , 'v' || NULLIF(scg.lms_version, '') AS lms_version
                   , scg.integration_type
                   , LEAD(1)
                          OVER (PARTITION BY hcs.hub_coursesection_key ORDER BY COALESCE(scg.created_at, a.created_at) DESC) IS NULL AS latest
                    , scg.canvas_course_id
                    , scg.lms_context_id
                    , scg.lis_course_source_id
             FROM prod.datavault.hub_coursesection hcs
                   LEFT JOIN prod.datavault.link_coursesectiongateway_coursesection lcsg
                             ON hcs.hub_coursesection_key = lcsg.hub_coursesection_key
                   LEFT JOIN prod.datavault.sat_coursesection_gateway scg
                             ON lcsg.hub_coursesectiongateway_key = scg.hub_coursesectiongateway_key AND scg._latest
                   LEFT JOIN webassign.wa_app_v4net.sections s ON hcs.context_id = s.olr_context_id
                   LEFT JOIN webassign.wa_app_v4net.courses crs ON crs.id = s.course
                   LEFT JOIN webassign.wa_app_v4net.schools sch ON sch.id = crs.school
                   LEFT JOIN webassign.wa_app_v4net.partner_applications a ON a.school_id = sch.id
              WHERE scg.lms_type IS NOT NULL
              OR a.kind IS NOT NULL
             )
      SELECT DISTINCT
             dc.dw_ldid
           , dc.dw_ldts
           , dc.courseid
           , dc.coursekey
           , scs.course_name AS coursename
           , dc.institutionid
           , dc.productid
           , to_char(scs.begin_date, 'YYYYMMDD')::INT AS startdatekey
           , to_char(scs.end_date, 'YYYYMMDD')::INT AS enddatekey
           , dc.filterflag
           , dc.learningcourse
           , dc.loaddate
           , dc.productplatformid
           , dc.instructorid
           , scs.course_cgi AS cgi
           , scs.begin_date AS startdate
           , scs.end_date AS enddate
           , scs.course_key AS olr_course_key
           , hcs.context_id AS olr_context_id
           , scs.created_on as createddate
           , c.mag_acct_id
           , c.isbn
           , orgs.organization
           , orgs.cu_ct
           , orgs.noncu_ct
           , scs.end_date < current_date() AS course_complete
           , scs.section_product_type AS product_type
           , scs.begin_date::DATE <= CURRENT_DATE() AND scs.end_date >= CURRENT_DATE()::DATE AS active
             --,COALESCE(scs.institution_id_override, scs.institution_id) as entity_no
           , COALESCE(e.entity_no::STRING
                      , NULLIF(e2.entity_no, '-1')::STRING
                      , en.entity_no::STRING
                      , NULLIF(c.entity_id_sub, 'NOT FOUND')::STRING
                      , c.entity_no::STRING) as entity_no
           , c.entity_name_course
           , scs.is_gateway_course
           , scs.is_demo
           , scs.course_master
           , coalesce(scs.deleted,false) as deleted
           , wl.language AS default_language
           , UPPER(DECODE(lms.lms_type, 'BB', 'Blackboard', lms.lms_type)) as lms_type
           , lms.lms_version
           , lms.integration_type
           , lms.canvas_course_id
           , lms.lms_context_id
           ,lms.lis_course_source_id
           , lms.lms_type IS NOT NULL AND g.lms_sync_course_scores AS lms_sync_course_scores
           , lms.lms_type IS NOT NULL AND g.lms_sync_activity_scores AS lms_sync_activity_scores
           , COALESCE(el.cui, FALSE) as cui
           , COALESCE(el.ia, FALSE) as ia
      FROM prod.dw_ga.dim_course dc
           LEFT JOIN prod.stg_clts.olr_courses c ON dc.coursekey = c."#CONTEXT_ID"
           LEFT JOIN prod.stg_clts.entities e ON c.entity_id_sub = e.entity_no
           LEFT JOIN prod.stg_clts.entities e2 ON c.entity_no = e2.entity_no
           LEFT JOIN (
                    SELECT
                      institution_nm, entity_no, ROW_NUMBER() OVER (PARTITION BY institution_nm ORDER BY enrollment_no DESC) = 1 AS best
                    FROM prod.stg_clts.entities
                      ) en ON UPPER(c.entity_name_course) = UPPER(en.institution_nm)
           LEFT JOIN prod.datavault.hub_coursesection hcs ON dc.coursekey = hcs.context_id
           LEFT JOIN prod.datavault.sat_coursesection scs ON hcs.hub_coursesection_key = scs.hub_coursesection_key AND scs._latest
           LEFT JOIN orgs ON dc.coursekey = orgs.context_id AND orgs.r = 1
           LEFT JOIN uploads.course_section_metadata.wa_course_language wl ON hcs.context_id = wl.context_id
           LEFT JOIN lms ON hcs.hub_coursesection_key = lms.hub_coursesection_key AND lms.latest
           LEFT JOIN mindtap.prod_nb.gradebook g ON dc.coursekey = g.external_id
           LEFT JOIN el ON dc.coursekey = el.context_id AND el.latest
      ORDER BY olr_course_key
    ;;
    sql_trigger_value: select count(*) from dw_ga.dim_course ;;
  }

  set: cu_explore_fields {fields:[dim_course.coursename, dim_course.enddatekey, dim_course.startdatekey, dim_course.coursekey, dim_course.mag_acct_id, dim_course.active_course_sections, dim_course.course_complete, dim_course.product_type]}
  set: marketing_fields {fields:[cu_explore_fields*]}

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, year]

    sql: ${TABLE}.createddate ;;
  }
  dimension: deleted {
    description: "OLR course section has been deleted"
    type: yesno
  }

  dimension: course_master {
    description: "Is a Master Course"
    type: string
  }

  dimension: isbn {
    description: "OLR Course ISBN"
  }

  dimension: default_language {description: "WebAssign course section default language"}

  dimension: lms_type {
    group_label: "LMS Integration"
    sql: case when ${TABLE}.lms_type is not null then ${TABLE}.lms_type
              when ${TABLE}.is_gateway_course then 'UNKNOWN LMS'
              else 'NOT LMS INTEGRATED'
        end
     ;;
    label: "LMS Type"
  }

  dimension: lms_integration_type {
    group_label: "LMS Integration"
    sql: case when ${TABLE}.integration_type is not null then ${TABLE}.integration_type
              when ${TABLE}.lms_type is not null then 'UNKNOWN INTEGRATION TYPE'
              when ${TABLE}.is_gateway_course then 'UNKNOWN LMS'
              else 'NOT LMS INTEGRATED'
        end
     ;;
    label: "LMS Integration Type"
  }

  dimension: lms_grade_sync  {
    group_label: "LMS Integration"
    label: "LMS Grade Sync (MindTap)"
    description: "Type of grade sync for LMS integrated MindTap courses"
    case: {
      when: {sql:NOT ${is_lms_integrated};; label:"N/A"}
      when: {sql:${TABLE}.lms_sync_course_scores;; label:"Course Level"}
      when: {sql:${TABLE}.lms_sync_activity_scores;; label:"Activity Level"}
      when: {sql:NOT ${TABLE}.lms_sync_activity_scores AND NOT ${TABLE}.lms_sync_course_scores ;; label:"No score sync"}
      else: "Non Mindtap LMS"
    }
  }

  dimension: is_lms_integrated {
    group_label: "LMS Integration"
    description: "Is this a Gateway course?"
    label: "LMS Integrated"
    type: yesno
    sql: ${lms_type}!='NOT LMS INTEGRATED' ;;
  }

  dimension: product_platform {
    hidden: yes
    type: string
    case: {
      when: { sql: ${product_type} = 'MTC';; label: "MindTap"}
      when: { sql: ${product_type} = 'APLIA';; label: "Aplia"}
      when: { sql: ${product_type} = 'WA';; label: "WebAssign"}
      when: { sql: ${product_type} = 'MTS';; label: "MindTap Schools"}
      when: { sql: ${product_type} = 'CNOW';; label: "CNOW"}
      when: { sql: ${product_type} = 'CNOWV8';; label: "CNOW"}
      when: { sql: ${product_type} = 'OWL';; label: "OWL V2"}
      when: { sql: ${product_type} = 'SAM';; label: "SAM"}
      when: { sql: ${product_type} = 'NATGEO';; label: "National Geographic"}
      when: { sql: ${product_type} = '' OR ${product_type} IS NULL;; label: "UNKNOWN"}
      when: { sql: ${product_type} = '4LT';; label: "4LTR Online"}
      when: { sql: ${product_type} = 'WA3P';; label: "WebAssign"}
      when: { sql: ${product_type} =  'DEV-MATH';; label: "Dev-Math"}
      when: { sql: ${product_type} = '4LTV1';; label: "4LTR Online"}
      when: { sql: ${product_type} = 'LO-OPENNOW';; label: "OpenNow"}
      when: { sql: ${product_type} = 'CSFI';; label: "CSFI"}
      when: { sql: ${product_type} = 'MT4';; label: "MindTap"}
      when: { sql: ${product_type} = 'LO';; label: "Learning Objects"}
      when: { sql: ${product_type} = 'MALCOLM';; label: "Middle Product"}
      else: "Other"
    }
  }

  dimension: cui {group_label: "Institutional License" label: "CUI" type:yesno}
  dimension: ia {group_label: "Institutional License" label: "IA" type:yesno}
  dimension: institutional_license_type {group_label: "Institutional License" type:string
    case: {
      when: {sql: ${cui};; label: "CUI"}
      when: {sql: ${ia};; label: "IA"}
      else: "No License"
      }
    }

  measure: course_count_cui {
    group_label: "Institutional License"
    label: "# CUI Course Sections"
    type:count_distinct
    sql: IFF(${cui}, ${coursekey}, NULL);;
  }

  measure: course_count_ia {
    group_label: "Institutional License"
    label: "# IA Course Sections"
    type:count_distinct
    sql: IFF(${ia}, ${coursekey}, NULL);;
  }

  measure: course_count_no_license {
    group_label: "Institutional License"
    label: "# Course Sections with No Institutional License"
    type:count_distinct
    sql: IFF(NOT (${cui} or ${ia}), ${coursekey}, NULL);;
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
    hidden: no
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

  dimension: canvas_course_id {
    label: "Canvas Course ID"
    type: string
    sql: ${TABLE}.canvas_course_id ;;
    hidden: no
  }

  dimension: lms_context_id {
    label: "LMS Context ID"
    type: string
    sql: ${TABLE}.lms_context_id ;;
    hidden: no
  }

  dimension: lis_course_source_id {
    label: "SIS Course ID"
    type: string
    sql: ${TABLE}.lis_course_source_id ;;
    hidden: no
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
    sql: COALESCE(${TABLE}.cu_ct, 0) ;;
    hidden: yes
  }


  dimension: noncu_ct {
    label: "# Non CU Students"
    description: "No of Non-CU students activated for a particular course key"
    sql: COALESCE(${TABLE}.noncu_ct, 0) ;;
    hidden: yes
  }

  dimension: class_size {
    type: number
    sql: ${cu_ct} + ${noncu_ct} ;;
  }

  dimension: class_size_bucket {
    label: "Class size (buckets)"
    type: tier
    tiers: [10, 30, 50, 100, 200, 500, 1000]
    style: relational
    sql: ${class_size} ;;
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
