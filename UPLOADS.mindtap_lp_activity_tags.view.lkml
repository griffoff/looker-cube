view: mindtap_lp_activity_tags {
  label: "Learning Path"
  # sql_table_name: UPLOADS.GOOGLE_SHEETS.LPUPLOAD ;;
  derived_table: {
    sql:
      with tags as (
        select
          lower(regexp_replace(LEARNING_PATH_ACTIVITY_TITLE, '[\\W\\s]', '')) as activity_title_key
          ,Product_Family || Edition || LEARNING_PATH_ACTIVITY_TITLE as full_key
          ,*
          ,row_number() over (partition by product_family, edition, activity_title_key
                                          order by _fivetran_synced desc, case when activity_type is null then 1 else 0 end, length(LEARNING_PATH_ACTIVITY_TITLE)) as n
        from UPLOADS.GOOGLE_SHEETS.LPUPLOAD
      )
      SELECT
          _ROW
          ,_FIVETRAN_SYNCED
          ,activity_title_key
          ,PRODUCT_FAMILY
          ,EDITION
          ,EDITION_TYPE
          ,LEARNING_PATH_ACTIVITY_TITLE
          ,case when count(distinct activity_type) over (partition by full_key) > 1 then null else activity_type end as activity_type
          ,case when count(distinct activity_sub_type) over (partition by full_key) > 1 then null else activity_sub_type end as activity_sub_type
         --,case when count(distinct activity_sub_type) over (partition by full_key) > 1 then null else activity_sub_type end as activity_sub_type
          ,case when count(distinct activity_cluster) over (partition by full_key) > 1 then null else activity_cluster end as activity_cluster
          ,case when count(distinct activity_sub_cluster) over (partition by full_key) > 1 then null else activity_sub_cluster end as activity_sub_cluster
          ,case when count(distinct activity_topic) over (partition by full_key) > 1 then null else activity_topic end as activity_topic
          ,case when count(distinct activity_group) over (partition by full_key) > 1 then null else activity_group end as activity_group
          ,case when count(distinct chapter) over (partition by full_key) > 1 then null else chapter end as chapter
          ,case when count(distinct section_number) over (partition by full_key) > 1 then null else section_number end as section_number
          ,case when count(distinct section_name) over (partition by full_key) > 1 then null else section_name end as section_name
          ,case when count(distinct chapter_topic) over (partition by full_key) > 1 then null else chapter_topic end as chapter_topic
          ,COUNT (DISTINCT learning_path_activity_title) OVER (PARTITION BY Activity_Type,Product_Family,Edition) AS Activity_BY_GROUP
      from tags
      where n = 1
      order by product_family, edition, activity_title_key
      ;;
    sql_trigger_value:SELECT COUNT(*) FROM UPLOADS.GOOGLE_SHEETS.LPUPLOAD   ;;
  }

  parameter: group_picker {
    label: "Analyse by"
    type: unquoted
    allowed_value: {
      label: "Activity Type"
      value: "activity_type"
    }
    allowed_value: {
      label: "Chapter"
      value: "chapter"
    }
  }

  dimension: dynamic_group {
    label: "Activity dynamic group"
    type: string
    sql: ${TABLE}.{% parameter group_picker %} ;;
  }

# samples below
# TheBody’sUseofGlucose
# replace(replace(learning_path_activity_title, ' ', ''),'''','') as activity_title_key
# regexp_replace(replace(LEARNING_PATH_ACTIVITY_TITLE,'’',''), '[\\W\\s]', '') as activity_title_key

  dimension: activity_title_key {
    label: "Activity Title Key - LPUPLOADS"
    hidden: no
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
    hidden: yes
  }

  dimension: _row {
    type: number
    sql: ${TABLE}._ROW ;;
    primary_key: yes
    hidden: yes
  }

  dimension: activity_cluster {
    label: "04 - Activity Cluster"
    group_label: "Activity Tags (pilot)"
    description: "Field to enable links between activities not defined by chapter or activity type.  Validating need for this field (limited use).  Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.ACTIVITY_CLUSTER ;;
  }

  dimension: activity_sub_cluster {
    label: "05 - Activity Sub-Cluster"
    group_label: "Activity Tags (pilot)"
    description: "Additional field to enable links between activities not defined by chapter or activity type.  Validating need for this field (limited use). Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.ACTIVITY_SUB_CLUSTER ;;
  }

  dimension: activity_sub_type {
    label: "03 - Activity Sub-Type"
    group_label: "Activity Tags (pilot)"
    description: "Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.ACTIVITY_SUB_TYPE ;;
  }

  dimension: activity_type {
    label: "02 - Activity Type"
    group_label: "Activity Tags (pilot)"
    description: "Describes primary content/activity type (e.g. Mastery Training or Video Case).  Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.ACTIVITY_TYPE ;;
  }

  dimension: chapter {
    label: "00 - Chapter"
    group_label: "Activity Tags (pilot)"
    description: "Chapter number as defined in the learning path.  Chapter 0 contains all 'getting started' and intro activities.  Not available for most product families - part of pilot analytics project"
    type: number
    sql: ${TABLE}.CHAPTER ;;
    order_by_field: chapter_sort
  }

  dimension: chapter_sort {
    hidden: yes
    type: number
    sql:  case when ${chapter} ilike 'appendix' then 9999 else coalesce(try_cast(${chapter} as int), -1) end;;
  }

  dimension: chapter_topic {
    label: "01 - Chapter Topic"
    group_label: "Activity Tags (pilot)"
    description: "Description of chapter content; ideally to be used to analyze content across products within a discipline or course area. Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.CHAPTER_TOPIC ;;
  }

  dimension: learning_path_activity_title {
    group_label: "Activity Tags (pilot)"
    description: "Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.LEARNING_PATH_ACTIVITY_TITLE ;;
    hidden: yes
  }
  dimension: product_family {
    group_label: "Activity Tags (pilot)"
    description: "Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.PRODUCT_FAMILY ;;
    hidden: yes
  }

  dimension: edition_number {
    group_label: "Activity Tags (pilot)"
    description: "Not available for most product families - part of pilot analytics project"
    type: number
    sql: ${TABLE}.EDITION ;;
    hidden: yes
  }

  dimension: section_name {
    label: "07 - Section Name"
    group_label: "Activity Tags (pilot)"
    description: "Unit or Section name, if applicable.  Not available for most product families - part of pilot analytics project."
    type: string
    sql: ${TABLE}.SECTION_NAME ;;
  }

  dimension: section_number {
    label: "06 - Section Number"
    group_label: "Activity Tags (pilot)"
    description: "Unit or Section section, if applicable.  Not available for most product families - part of pilot analytics project."
    type: string
    sql: ${TABLE}.SECTION_NUMBER ;;
  }

  dimension: edition_type {
    label: "Edition Type"
    group_label: "Activity Tags (pilot)"
    description: "Used to identify CUSTOM or ENHANCED editions as compared to the STANDARD edition"
    type: string
    sql: ${TABLE}.EDITION_TYPE ;;
  }


  dimension: activity_by_group {
#     label: "# Activities (unique from external tagging)"
#     type: count_distinct
#     sql: ${learning_path_activity_title} ;;
}

dimension: activity_group {
  label: "Activity Group"
  group_label: "Activity Tags (pilot)"
  description:  "WIP dimension...looking for ways to aggregate videos/media, assessment items, etc."
  type: string
  sql: ${TABLE}.ACTIVITY_GROUP ;;
}

dimension: activity_topic {
  label: "Activity Topic"
  group_label: "Activity Tags (pilot)"
  description: "WIP dimension...looking to align topics/themes across products/titles (e.g. 'Anxiety' which may be the topic of chapter 1 in book X and chapter 3 in book Y)"
  type: string
  sql:  ${TABLE}.ACTIVITY_TOPIC ;;
}

dimension: Concat_activity_sub_type {
    label: "10 - Activity + Sub-Type"
    group_label: "Activity Tags (pilot)"
    description: "Not available for most product families - part of pilot analytics project"
    type: string
    sql:CONCAT(CONCAT(activity_type,' '), Coalesce(activity_sub_type,'')) ;;
  }

measure: learning_path_activity_title_count {
  label: "# Activities (unique from external tagging)"
  type: count_distinct
  sql: ${learning_path_activity_title} ;;
}

measure: count {
  type: count
  drill_fields: [section_name]
  hidden: yes
}

  measure:  total_activity_activations{
    label: "total activity activations"
    type: number
    # Simply count rows where there are activations
    # - this works because an explore should be joined to course_seection_facts for every row
    #   ,so we are NOT counting courses, we are counting rows that have a valid course_section_facts record, and this in turn means that it must have activations
    #   To be more explicit you could do COUNT(CASE WHEN ${course_section_facts.totalnoofactivations} THEN 1 END)
    sql:  COUNT(${course_section_facts.courseid}) ;;
#     type:  number
#     sql:  ${mindtap_lp_activity_tags.learning_path_activity_title_count} * ${course_section_facts.course_count} ;;
    drill_fields: [dim_course.coursekey,chapter,activity_type,learning_path_activity_title,dim_activity.status,course_section_facts.total_noofactivations]
  }



}
