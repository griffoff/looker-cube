view: dim_user {
  label: "User"
  sql_table_name: DW_GA.DIM_USER ;;
  set: curated_fields {fields:[user_role,mainpartyid,numberofvisits,productsactivated]}

  set: curated_fields_for_instructor_mod{fields:[numberofpageviews,numberofvisits,sessionviewtime,pageviewtime]}

  dimension: userid {
    label: "User Id"
    description: "Internal non PII User/Account identifier.
    A person may have multiple accounts.
    Party Id represents the identifier for a person"
    type:  number
    sql:  ${TABLE}.userid ;;
    primary_key: yes
    hidden: yes
  }

  dimension: dayssincefirstvisit {
    label: "Days since first visit"
    type: number
    sql: ${TABLE}.DAYSSINCEFIRSTVISIT ;;
  }

  dimension: weekssincefirstvisit {
    label: "Weeks since first visit"
    type: tier
    style: integer
    tiers: [
      1,
      4,
      12,
      26,
      52,
      104
    ]
    sql: ${dayssincefirstvisit} ;;
  }

  dimension: dayssincelastvisit {
    label: "Days since last visit"
    type: tier
    tiers: [
      1,
      2,
      3,
      5,
      7,
      14,
      21
    ]
    style: integer
    sql: ${TABLE}.DAYSSINCELASTVISIT ;;
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension: dw_ldts {
    type: string
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: helperpartyid {
    type: string
    sql: ${TABLE}.HELPERPARTYID ;;
    hidden: yes
  }

  dimension: helperrole {
    type: string
    sql: ${TABLE}.HELPERROLE ;;
    hidden: yes
  }

  dimension: mainpartyid {
    type: string
    sql: ${TABLE}.MAINPARTYID ;;
    hidden: yes
  }

  dimension: mainpartyrole {
    label: "User Role - Raw"
    hidden: yes
    type: string
    sql: ${TABLE}.MAINPARTYROLE ;;
  }

  dimension: user_role {
    label: "User Role"
    description: "distinguishes between Instructors, Students, TA's and Others"
    type: string
    hidden: yes #this dimension is active in dim_party
    sql:
        CASE
          WHEN ${mainpartyrole} = 'INSTRUCTOR' THEN 'Instructor'
          WHEN ${mainpartyrole} = 'STUDENT' THEN 'Student'
          WHEN ${mainpartyrole} in ('TEACHING_ASSISTANT', 'TEACHING ASSISTANT') THEN 'TA'
          ELSE 'Other'
        END ;;
    #description: "Maps the raw Role field to Instructors, TA's, and Other. See Pete, for more questions."
  }


  dimension: numberofpageviews {
    label: "Total no. of page views"
    description: "This number is inclusive of both instructor & student views "
    type: tier
    tiers: [10, 100, 1000, 5000, 10000]
    style: integer
    sql: ${TABLE}.NUMBEROFPAGEVIEWS ;;
  }

  dimension: numberofvisits {
    label: "Total no. of visits"
    description: "This number is inclusive of both instructor & student visits "
    type: tier
    tiers: [1, 10, 20, 50, 100]
    style: integer
    sql: ${TABLE}.NUMBEROFVISITS ;;
  }

  dimension: pageviewtime {
    label: "Total page view time (hh:mm:ss)"
    description: "This time is inclusive of both instructor & student views "
    type: number
    sql: ${TABLE}.PAGEVIEWTIME / 1000 / 86400;;
    value_format_name: duration_hms
  }

  dimension: productsactivated {
    label: "No. of products activated"
    description: "Number of products activated by an user"
    type: tier
    tiers: [1, 2, 3, 5, 10]
    style: integer
    sql: ${TABLE}.PRODUCTSACTIVATED ;;
  }

  dimension: sessionviewtime {
    label: "Total session view time (hh:mm:ss)"
    description: "This view time is inclusive of both instructor & student usage "
    type: number
    sql: ${TABLE}.SESSIONVIEWTIME / 1000 / 86400;;
    value_format_name: duration_hms
  }

  dimension: weekssincefirstactivated {
    label: "Weeks since first activated"
    type: tier
    style: integer
    tiers: [
      1,
      4,
      12,
      26,
      52,
      104
    ]
    sql: ${TABLE}.WEEKSSINCEFIRSTACTIVATED ;;
  }

  dimension: weekssincelastactivated {
    label: "Weeks since last activated"
    type: tier
    style: integer
    tiers: [
      1,
      4,
      12,
      26,
      52,
      104
    ]
    sql: ${TABLE}.WEEKSSINCELASTACTIVATED ;;
  }

  measure: count {
    label: "No. of user accounts"
    type: count
    drill_fields: []
    hidden: yes
  }
}
