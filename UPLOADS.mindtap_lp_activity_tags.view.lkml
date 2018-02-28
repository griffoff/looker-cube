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
        from UPLOADS.LEARNINGPATH_METADATA.TAGS_COMBINED
      )
      SELECT
          _ROW
          ,_FIVETRAN_SYNCED
          ,activity_title_key
          ,PRODUCT_FAMILY
          ,EDITION
          ,EDITION_TYPE
          ,CONCAT(activity_type, Coalesce(CONCAT(': ',NULLIF(activity_sub_type,'')),'')) as activity_usage_facts_grouping
          ,max(learning_path_activity_title) over (partition by activity_title_key) as LEARNING_PATH_ACTIVITY_TITLE
          ,case when count(distinct activity_type) over (partition by full_key) > 1 then null else InitCap(activity_type) end as activity_type
          ,case when count(distinct activity_sub_type) over (partition by full_key) > 1 then null else InitCap(activity_sub_type) end as activity_sub_type
         --,case when count(distinct activity_sub_type) over (partition by full_key) > 1 then null else activity_sub_type end as activity_sub_type
          --,case when count(distinct activity_cluster) over (partition by full_key) > 1 then null else activity_cluster end as activity_cluster
          --,case when count(distinct activity_sub_cluster) over (partition by full_key) > 1 then null else activity_sub_cluster end as activity_sub_cluster
          ,case when count(distinct activity_topic) over (partition by full_key) > 1 then null else InitCap(activity_topic) end as activity_topic
          ,case when count(distinct activity_group) over (partition by full_key) > 1 then null else InitCap(activity_group) end as activity_group
          ,case when count(distinct chapter) over (partition by full_key) > 1 then null else chapter end as chapter
          ,case when count(distinct section_number) over (partition by full_key) > 1 then null else section_number end as section_number
          ,case when count(distinct section_name) over (partition by full_key) > 1 then null else InitCap(section_name) end as section_name
          ,case when count(distinct chapter_topic) over (partition by full_key) > 1 then null else InitCap(chapter_topic) end as chapter_topic
          ,COUNT (DISTINCT learning_path_activity_title) OVER (PARTITION BY Activity_Type,Activity_sub_Type,Product_Family,Edition) AS Activity_BY_GROUP
          ,COUNT (DISTINCT learning_path_activity_title) OVER (PARTITION BY chapter,Product_Family,Edition) AS Activity_BY_Chapter
      from tags
      where n = 1
      order by product_family, edition, activity_title_key
      ;;
    sql_trigger_value:SELECT MAX(done)
                          from uploads.learningpath_metadata.FIVETRAN_AUDIT
                          where rows_updated_or_inserted > 0
                          AND UPPER(status) = 'OK';  ;;
  }
  set: curated_fields {fields:[activity_topic,activity_sub_type,activity_type,chapter,chapter_topic,section_name,section_number,edition_type,activity_by_group,activity_by_chapter,activity_usage_facts_grouping,learning_path_activity_title_count,total_activity_activations]}

  set:WL_fields  {fields:[total_activity_activations]}
#   parameter: group_picker {
#     label: "Analyse by"
#     type: unquoted
#     allowed_value: {
#       label: "Activity Type"
#       value: "activity_type"
#     }
#     allowed_value: {
#       label: "Chapter"
#       value: "chapter"
#     }
#   }
#
#   dimension: dynamic_group {
#     label: "Activity dynamic group"
#     type: string
#     sql: ${TABLE}.{% parameter group_picker %} ;;
#   }

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

  dimension: activity_topic {
    label: "04 - Activity Topic"
    group_label: "Activity Tags"
    description: "Additional field to describe links between activities.  Not used for all activities."
    type: string
    sql: ${TABLE}.ACTIVITY_TOPIC ;;
  }
#
#   dimension: activity_sub_cluster {
#     label: "05 - Activity Sub-Cluster"
#     group_label: "Activity Tags"
#     description: "Additional field to enable links between activities not defined by chapter or activity type.  Validating need for this field (limited use). Not available for most product families - part of pilot analytics project"
#     type: string
#     sql: ${TABLE}.ACTIVITY_SUB_CLUSTER ;;
#   }

  dimension: activity_sub_type {
    label: "03 - Activity Sub-Type"
    group_label: "Activity Tags"
    description: "Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.ACTIVITY_SUB_TYPE ;;
  }

  dimension: activity_type {
    label: "02 - Activity Type"
    group_label: "Activity Tags"
    description: "Describes primary content/activity type (e.g. Mastery Training or Video Case).  Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.ACTIVITY_TYPE ;;
  }

  dimension: chapter {
    label: "00 - Chapter"
    group_label: "Activity Tags"
    description: "Chapter number as defined in the learning path.  Chapter 0 contains all 'getting started' and intro activities.  Not available for most product families - part of pilot analytics project"
    type: number
    sql: ${TABLE}.CHAPTER ;;
    order_by_field: chapter_sort
    link: {
      label: "# Activity Types in a Chapter"
      url: "/explore/cube/fact_siteusage?fields=mindtap_lp_activity_tags.activity_type,mindtap_lp_activity_tags.learning_path_activity_title_count,
      &f[mindtap_lp_activity_tags.chapter]={{ value }},&f[dim_product.productfamily_edition]={{_filters['dim_product.productfamily_edition'] | url_encode}}"
    }
  }

  dimension: chapter_sort {
    hidden: yes
    type: number
    sql:  case when ${chapter} ilike 'appendix' then 9999 else coalesce(cast(${chapter} AS INT), -1) end;;
  }

  dimension: chapter_topic {
    label: "01 - Chapter Topic"
    group_label: "Activity Tags"
    description: "Description of chapter content; ideally to be used to analyze content across products within a discipline or course area. Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.CHAPTER_TOPIC ;;
  }

  dimension: learning_path_activity_title {
    group_label: "Activity Tags"
    description: "Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.LEARNING_PATH_ACTIVITY_TITLE ;;
    hidden: yes
  }
  dimension: product_family {
    group_label: "Activity Tags"
    description: "Not available for most product families - part of pilot analytics project"
    type: string
    sql: ${TABLE}.PRODUCT_FAMILY ;;
    hidden: yes
  }

  dimension: edition_number {
    group_label: "Activity Tags"
    description: "Not available for most product families - part of pilot analytics project"
    type: number
    sql: ${TABLE}.EDITION ;;
    hidden: yes
  }

  dimension: section_name {
    label: "07 - Section Name"
    group_label: "Activity Tags"
    description: "Unit or Section name, if applicable.  Not available for most product families - part of pilot analytics project."
    type: string
    sql: ${TABLE}.SECTION_NAME ;;
  }

  dimension: section_number {
    label: "06 - Section Number"
    group_label: "Activity Tags"
    description: "Unit or Section Number, if applicable.  Not available for most product families - part of pilot analytics project."
    type: string
    sql: ${TABLE}.SECTION_NUMBER ;;
  }

  dimension: edition_type {
    label: "Edition Type"
    group_label: "Activity Tags"
    description: "Used to identify CUSTOM or ENHANCED editions as compared to the STANDARD edition"
    type: string
    sql: ${TABLE}.EDITION_TYPE ;;
    hidden: yes
  }


  dimension: activity_by_group {
     label: "# Unique Activities By Type (dimension)"
#     type: count_distinct
#     sql: ${learning_path_activity_title} ;;
}

dimension: activity_by_chapter {
label: "# Unique Activities By Chapter (dimension)"
description: "Provides the number of activities in a given chapter as a dimension that can be used to categorize, cut or filter data"
}

# measure: activity_by_group_measure {
#   label: " # Unique Activities By Type (measure)"
#   description: "Number of activities in a given Activity Type as a measure that can be summed/aggregated"
#   type: number
#   sql: ${activity_by_group} ;;
#   }

dimension: activity_group {
  label: "Activity Group"
  group_label: "Activity Tags"
  description:  "WIP dimension...looking for ways to aggregate videos/media, assessment items, or elements across titles etc.  Comes from the LP Tagging Google Sheet"
  type: string
  sql: ${TABLE}.ACTIVITY_GROUP ;;
}

# dimension: activity_topic {
#   label: "Activity Topic"
#   group_label: "Activity Tags"
#   description: "WIP dimension...looking to align topics/themes across products/titles (e.g. 'Anxiety' which may be the topic of chapter 1 in book X and chapter 3 in book Y)"
#   type: string
#   sql:  ${TABLE}.ACTIVITY_TOPIC ;;
# }

# dimension: concat_activity_sub_type {
#     label: "10 - Activity + Sub-Type"
#     group_label: "Activity Tags"
#     description: "Not available for most product families - part of pilot analytics project"
#     type: string
#     sql:CONCAT(${activity_type}, Coalesce(CONCAT(': ',NULLIF(${activity_sub_type},'')),'')) ;;
#   }

dimension: activity_usage_facts_grouping {
#   hidden: yes
  group_label: "Activity Tags"
  label: "Activity Type + Subtype"
  description: "Concatenation of Activity Type and Activity Subtype used in most default templates."
  sql: ${TABLE}.activity_usage_facts_grouping ;;
  link: {
    label: "Usage of Specific Activities Titles"
    url: "/explore/cube/fact_siteusage?fields=mindtap_lp_activity_tags.activity_usage_facts_grouping,mindtap_lp_activity_tags.chapter,mindtap_lp_activity_tags.learning_path_activity_title,dim_activity.originallygradable,fact_siteusage.percent_of_activations,
    &f[mindtap_lp_activity_tags.activity_usage_facts_grouping]={{ value }},&f[dim_product.productfamily_edition]={{_filters['dim_product.productfamily_edition'] | url_encode}},&f[fact_siteusage.percent_of_activations]=%3E0"
  }
  link: {
    label: "# Activities in each chapter"
    url: "/explore/cube/fact_siteusage?fields=mindtap_lp_activity_tags.activity_usage_facts_grouping,mindtap_lp_activity_tags.chapter,mindtap_lp_activity_tags.learning_path_activity_title_count_fordrilldowns,
    &f[mindtap_lp_activity_tags.activity_usage_facts_grouping]={{ value }},&f[dim_product.productfamily_edition]={{_filters['dim_product.productfamily_edition'] | url_encode}}"
    }
  link: {
    label: "Usage Breakdown By Gradable Status"
    url: "/explore/cube/fact_siteusage?fields=mindtap_lp_activity_tags.activity_usage_facts_grouping,dim_activity.status,fact_siteusage.percent_of_activations,
    &f[mindtap_lp_activity_tags.activity_usage_facts_grouping]={{ value }},&f[dim_product.productfamily_edition]={{_filters['dim_product.productfamily_edition'] | url_encode}}"
  }

}

measure: learning_path_activity_title_count {
  label: "# Activities (unique from external tagging)"
  description: "Number of activities rolled up to an activity type through external tagging exercise"
  type: count_distinct
  sql: ${learning_path_activity_title} ;;
}

  measure: learning_path_activity_title_count_fordrilldowns{
    label: "# Activities Accessed"
    hidden: yes
    type: count_distinct
    sql: ${learning_path_activity_title} ;;
  }

measure: count {
  type: count
  drill_fields: [section_name]
  hidden: yes
}

  measure:  total_activity_activations{
    label: "Activity Availability"
    description: "# of total activities times courses."
    type: number
    # Simply count rows where there are activations
    # - this works because an explore should be joined to course_seection_facts for every row
    #   ,so we are NOT counting courses, we are counting rows that have a valid course_section_facts record, and this in turn means that it must have activations
    #   To be more explicit you could do COUNT(CASE WHEN ${course_section_facts.totalnoofactivations} THEN 1 END)
    sql:  COUNT(${course_section_facts.courseid}) ;;
#     type:  number
#     sql:  ${mindtap_lp_activity_tags.learning_path_activity_title_count} * ${course_section_facts.course_count} ;;
#     drill_fields: [dim_course.coursekey,chapter,activity_type,learning_path_activity_title,dim_activity.status,course_section_facts.total_noofactivations],courseinstructor.instructoremail
    drill_fields: [dim_institution.institutionname,courseinstructor.instructorid,activity_usage_facts_grouping,chapter,learning_path_activity_title,course_section_facts.total_noofactivations,fact_siteusage.percent_of_activations]
  }



}
