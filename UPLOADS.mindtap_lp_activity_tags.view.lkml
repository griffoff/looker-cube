view: mindtap_lp_activity_tags {
  label: "Learning Path"
  sql_table_name: UPLOADS.ZJB.MINDTAP_LP_ACTIVITY_TAGS ;;

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

#   dimension: primary_key {
#     type: number
#     sql: ${TABLE}.PRIMARY_KEY ;;
#     primary_key: yes
#   }

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

  measure: count {
    type: count
    drill_fields: [section_name]
    hidden: yes
  }
}
