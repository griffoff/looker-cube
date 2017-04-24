view: dim_party {
  label: "User"
  sql_table_name: DW_GA.DIM_PARTY ;;

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

  dimension: firstname {
    label: "First name"
    group_label: "PII"
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
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
    sql: ${TABLE}.GUID ;;
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
    sql: ${TABLE}.LASTNAME ;;
#     sql:
#     CASE WHEN '{{ _user_attributes["pii_visibility_enabled"] }}' = 'yes'
#     THEN ${TABLE}.LASTNAME
#     ELSE
#     MD5(${TABLE}.LASTNAME || "salt")
#     END ;;
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
    sql: ${TABLE}.MAINPARTYEMAIL ;;
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
    drill_fields: [guid]
  }
}
