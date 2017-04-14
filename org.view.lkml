view: org {
  sql_table_name: STG_MINDTAP.ORG ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: children_integer_idx {
    type: string
    sql: ${TABLE}.CHILDREN_INTEGER_IDX ;;
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.CREATED_BY ;;
  }

  dimension: created_date {
    type: string
    sql: ${TABLE}.CREATED_DATE ;;
  }

  dimension: external_id {
    description: "This is the coursekey when related to a snapshot"
    type: string
    sql: ${TABLE}.EXTERNAL_ID ;;
    link: {
      label: "Cube - Activations"
      url: "/explore/cube/fact_activation?fields=dim_course.coursekey,fact_activation.total_noofactivations,&f[dim_course.coursekey]={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: last_modified_by {
    type: string
    sql: ${TABLE}.LAST_MODIFIED_BY ;;
  }

  dimension: last_modified_date {
    type: string
    sql: ${TABLE}.LAST_MODIFIED_DATE ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: org_type {
    type: string
    sql: ${TABLE}.ORG_TYPE ;;
  }

  dimension: parent_id {
    type: string
    sql: ${TABLE}.PARENT_ID ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      course.count,
      course_info_view.count,
      org_snapshot.count,
      snapshot.count,
      user_org_profile.count
    ]
  }
}
