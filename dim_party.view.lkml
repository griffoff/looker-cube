include: "/core/internal_user_filters.view.lkml"
view: dim_party {
  label: "User"
  #sql_table_name: DW_GA.DIM_PARTY ;;
  derived_table: {
    sql:
    with tu as (
      select distinct source_id as guid
      from mindtap.prod_nb.user u
      inner join mindtap.prod_nb.user_org_profile uop on u.id = uop.user_id
      inner join mindtap.prod_nb.org o on uop.org_id = o.id
      inner join mindtap.prod_nb.org o1 on o.parent_id = o1.id
      inner join ${internal_org_filters.SQL_TABLE_NAME} internal on o1.external_id = internal.org_external_id
      --where upper(o1.name) like '%TEST%'
      --or upper(o1.name) like '%DEMO%'
--  or o.id = 501
    )
    select
      p.PARTYID
      ,p.MAINPARTYEMAIL
      ,p.GUID
      ,p.FIRSTNAME
      ,p.LASTNAME
      ,p.SOURCE
      ,case
        when tu.guid is not null then true
        when internal.rlike_filter is not null then true
        else false
        end as is_internal
        ,case
          when tu.guid is not null then true
          when upper(p.mainpartyemail) like '%CENGA%E%'
              or upper(p.mainpartyemail) like '%DEMO%'
              or upper(p.mainpartyemail) like '%TEST%'
              or upper(p.mainpartyemail) like '%QAI%'
              or upper(p.mainpartyemail) like '%TESTACCOUNT%'
              or upper(p.mainpartyemail) like '%DEVELOPMENT%'
              or upper(p.mainpartyemail) like '%SWLEARNING%'
              or upper(p.mainpartyemail) like '%LUNARLOGIC.COM'
              or upper(p.mainpartyemail) like '%MTX%.COM'
              or upper(p.mainpartyemail) like '%HENLEY.COM'
              or upper(p.mainpartyemail) like '%CONCENTRICSKY%'
              or upper(p.mainpartyemail) like '%NG.COM'
              or upper(p.mainpartyemail) like '%QA4U.COM'
              or upper(p.mainpartyemail) like '%APLIA.COM'
              or p.mainpartyemail in ('inst1_gateway_130514@yahoo.com','01_gtwy_instructor_30042015@gmail.com','i1_instructor_16052014@gmail.com','i9_instructor_040814@gmail.com','i19_instructor_091014@gmail.com')
          then true
          else false
          end as is_internal_old
          ,array_agg(distinct internal.rlike_filter) as user_matches
          ,array_agg(distinct tu.external_id) as org_matches
    from dw_ga.dim_party p
    left join tu on p.guid = tu.guid
    left join dw_ga.dim_user user on p.partyid = user.mainpartyid
    left join internal_email_filter internal on rlike(p.mainpartyemail, internal.rlike_filter, 'i')
    where p.partyID != 8063483 --null record
    group by 1, 2, 3, 4, 5, 6, 7, 8
    order by p.partyid
    ;;
    sql_trigger_value: select count(*) from dw_ga.dim_party ;;
  }
  set: curated_fields {fields:[guid,is_external,mainpartyrole,mainpartyemail,firstname,lastname]}

  set: curated_fields_for_instructor_mod {fields:[is_external]}

  set: personDetails {
    fields: [dim_course.coursekey, dim_course.coursename, guid, mainpartyemail, firstname, lastname, fact_activation.total_noofactivations, is_external, dim_user.productsactivated, course_section_facts.total_noofactivations]
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

  dimension: is_internal {
    label: "Internal User"
    type: yesno
  }

  dimension: is_internal_old {
    label: "Internal User (Old)"
    type: yesno
    hidden: yes
  }

  dimension: is_external {
    view_label: "** RECOMMENDED FILTERS **"
    label: "Real User"
    description: "Indicates a real user of the product, rather than a cengage employee"
    type: yesno
    sql: not ${TABLE}.is_internal;;
  }

  dimension: mainpartyrole {
    label: "User Role"
    description: "distinguishes between Instructors, Students, TA's and Others"
    type: string
    sql:
        CASE
          WHEN ${TABLE}.mainpartyrole = 'INSTRUCTOR' THEN 'Instructor'
          WHEN ${TABLE}.mainpartyrole = 'STUDENT' THEN 'Student'
          WHEN ${TABLE}.mainpartyrole in ('TEACHING_ASSISTANT', 'TEACHING ASSISTANT') THEN 'TA'
          ELSE 'Other'
        END ;;
  }

  dimension: firstname {
    label: "First name"
    group_label: "PII"
    type: string
    sql:
    CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes' or ${is_internal} or ${TABLE}.mainpartyrole != 'STUDENT' THEN
    ${TABLE}.FIRSTNAME
    ELSE
    MD5(${TABLE}.FIRSTNAME || 'salt')
    END ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {%elsif mainpartyrole._value != 'Student' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
  }

  dimension: guid {
    label: "SSO Guid"
    group_label: "PII"
    type: string
    sql:
    CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes' or ${TABLE}.mainpartyrole != 'STUDENT' THEN
    ${TABLE}.GUID
    ELSE
    MD5(${TABLE}.GUID || 'salt')
    END ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {%elsif mainpartyrole._value != 'Student' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
  }

  dimension: guid_raw {
    label: "SSO Guid"
    group_label: "PII"
    type: string
    sql: ${TABLE}.GUID ;;
    hidden: yes
  }

  dimension: lastname {
    label: "Last name"
    group_label: "PII"
    type: string
    #sql: ${TABLE}.LASTNAME ;;
    sql:
     CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes' or ${TABLE}.mainpartyrole != 'STUDENT' THEN
        ${TABLE}.LASTNAME
     ELSE
        MD5(${TABLE}.LASTNAME || 'salt')
     END ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {%elsif mainpartyrole._value != 'Student' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
  }

  dimension: mainpartyemail {
    group_label: "PII"
    label: "E-mail Address"
    type: string
    sql:
    CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes' or ${TABLE}.mainpartyrole != 'STUDENT' THEN
    ${TABLE}.MAINPARTYEMAIL
    ELSE
    MD5(${TABLE}.MAINPARTYEMAIL || 'salt')
    END ;;
    html:
      {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
        {{ value }}
      {%elsif mainpartyrole._value != 'Student' %}
      {{ value }}
      {% else %}
        [Masked]
      {% endif %}  ;;
  }


  dimension: partyid {
    label: "Party ID"
    description: "Internal non PII person identifier"
    type: string
    sql: ${TABLE}.PARTYID ;;
    primary_key: yes
    hidden: no
  }

  measure: count {
    label: "# Users"
    description: "This is the number of unique users that have activity related to the current context
    NOTE: The total # Users will most likely be different from the sum of # Users at a lower level (for example: at chapter level).
    This is because the same user can use each chapter and so will be counted in the # Users at chapter level,
    if there are 10 chapters and the user visited every chapter, the sum total would be 10, but the total # Users is just 1."
    type: count
    drill_fields: [personDetails*]
  }
}
