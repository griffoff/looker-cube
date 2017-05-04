view: user {
  sql_table_name: STG_MINDTAP."USER" ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.CREATED_BY ;;
  }

  dimension: created_date {
    type: string
    sql: ${TABLE}.CREATED_DATE ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.EMAIL ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
  }

  dimension: fname {
    type: string
    sql: ${TABLE}.FNAME ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
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

  dimension: lname {
    type: string
    sql: ${TABLE}.LNAME ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
  }

  dimension: password {
    type: string
    sql: ${TABLE}.PASSWORD ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: source_id {
    type: string
    sql: ${TABLE}.SOURCE_ID ;;
  }

  dimension: source_name {
    type: string
    sql: ${TABLE}.SOURCE_NAME ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.USERNAME ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: is_internal {
    label: "Internal User"
    type: yesno
    sql:
             ${TABLE}.email not ilike '%cengage%.com'
          OR ${TABLE}.email not ilike '%qai%.com'
          OR ${TABLE}.email not ilike '%testaccount.com'
          OR ${TABLE}.email not ilike '%development%'
          OR ${TABLE}.EMAIL not ilike '%@nelson.com'
          OR ${TABLE}.EMAIL not ilike '%@swlearning.com'
          OR ${TABLE}.EMAIL not ilike '%@lunarlogic.com'
          OR ${TABLE}.EMAIL not ilike '%@mtx.com'
          OR ${TABLE}.EMAIL not ilike '%@mtxqa.com'
          OR ${TABLE}.EMAIL not ilike '%@henley.com'
          OR ${TABLE}.EMAIL not ilike '%@concentricsky.com'
          OR ${TABLE}.EMAIL not ilike '%@test.com'
          OR ${TABLE}.EMAIL not ilike '%@ng.com'
          OR ${TABLE}.EMAIL not ilike '%@qa4u.com'
          OR ${TABLE}.EMAIL not ilike '%@aplia.com'
          OR ${TABLE}.EMAIL not ilike '%@qainfotech.net'
          OR lower(${TABLE}.EMAIL) not in ('inst1_gateway_130514@yahoo.com','01_gtwy_instructor_30042015@gmail.com','i1_instructor_16052014@gmail.com','i9_instructor_040814@gmail.com','i19_instructor_091014@gmail.com')
      ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      fname,
      lname,
      source_name,
      username,
      activity_outcome.count,
      activity_outcome_detail.count,
      activity_outcome_detail_in_progress_v.count,
      activity_outcome_detail_v.count,
      course_users.count,
      nb_google_doc_user.count,
      student_outcome_summary.count,
      user_org_profile.count,
      user_role_v.count
    ]
  }
}
