view: dim_party {
  label: "User"
  #sql_table_name: DW_GA.DIM_PARTY ;;
  derived_table: {
    sql:
    with tu as (
      select distinct source_id as guid
  from stg_mindtap.user u
  inner join stg_mindtap.user_org_profile uop on u.id = uop.user_id
  inner join stg_mindtap.org o on uop.org_id = o.id
  inner join stg_mindtap.org o1 on o.parent_id = o1.id
  where upper(o1.name) like '%TEST%'
  or upper(o1.name) like '%DEMO%'
--  or o.id = 501
    )
    select
      p.*
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
        end as Is_Internal
    from dw_ga.dim_party p
    left join tu on p.guid = tu.guid
    ;;
    sql_trigger_value: select count(*) from dw_ga.dim_party ;;
  }

  set: personDetails {
    fields: [dim_course.coursekey, dim_course.coursename, guid, mainpartyemail, firstname, lastname, fact_activation.total_noofactivations, is_external, dim_user.productsactivated, fact_activation_by_course.total_noofactivations]
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
    sql: ${TABLE}.is_internal;;
  }

  dimension: is_external {
    label: "Real User"
    description: "Indicates a real user of the product, rather than a cengage employee"
    type: yesno
    sql: not ${TABLE}.is_internal;;
  }

  dimension: firstname {
    label: "First name"
    group_label: "PII"
    type: string
    sql:
    CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes' or ${is_internal} THEN
    ${TABLE}.FIRSTNAME
    ELSE
    MD5(${TABLE}.FIRSTNAME || 'salt')
    END ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
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
    CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes' THEN
    ${TABLE}.GUID
    ELSE
    MD5(${TABLE}.GUID || 'salt')
    END ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
  }

  dimension: lastname {
    label: "Last name"
    group_label: "PII"
    type: string
    #sql: ${TABLE}.LASTNAME ;;
    sql:
     CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes' THEN
        ${TABLE}.LASTNAME
     ELSE
        MD5(${TABLE}.LASTNAME || 'salt')
     END ;;
    html:
    {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
    {{ value }}
    {% else %}
    [Masked]
    {% endif %}  ;;
  }

  dimension: mainpartyemail {
    group_label: "PII"
    label: "e-mail address"
    type: string
    sql:
    CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes' THEN
    ${TABLE}.MAINPARTYEMAIL
    ELSE
    MD5(${TABLE}.MAINPARTYEMAIL || 'salt')
    END ;;
    html:
      {% if _user_attributes["pii_visibility_enabled"]  == 'yes' %}
        {{ value }}
      {% else %}
        [Masked]
      {% endif %}  ;;
  }


  dimension: partyid {
    label: "Party Id"
    description: "Internal non PII person identifier"
    type: string
    sql: ${TABLE}.PARTYID ;;
    primary_key: yes
    hidden: no
  }

  measure: count {
    label: "No. of people"
    type: count
    drill_fields: [personDetails*]
  }
}
