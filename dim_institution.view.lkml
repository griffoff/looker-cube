view: dim_institution {
  label: "Institution"
  sql_table_name: DW_GA.DIM_INSTITUTION ;;

  dimension: HED {
    label: "HED flag"
    description: "Flag to identify Higher-Ed data"
    type: string
    sql: CASE WHEN (select count(*) from looker_workshop.magellan_hed_entities h where h.entity_no = ${entity_no}) > 0 then 'HED' else 'Not HED' end ;;
  }

  dimension: HED_filter {
    label: "HED filter"
    description: "Flag to identify Higher-Ed data"
    type:  yesno
    sql: ${HED}.filterflag in (0, -1) ;;
  }

  dimension: is_external {
    label: "Real Course"
    description: "Flag to identify real courses, rather than test/demo/internal"
    type: yesno
    sql: ${TABLE}.filterflag in (0, -1) ;;
  }

  dimension: city {
    group_label: "Location"
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    group_label: "Location"
    type: string
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: postalcode {
    group_label: "Location"
    label: "Postal/Zip code"
    type: zipcode
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: region {
    group_label: "Location"
    type: string
    sql: ${TABLE}.REGION ;;
  }

  dimension: locationid {
    type: number
    sql: ${TABLE}.locationid ;;
    hidden: yes
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

  dimension: enrollmentnumber {
    label: "Enrollment number (est)"
    type: string
    hidden: yes
    sql: ${TABLE}.ENROLLMENTNUMBER ;;
  }

  dimension: entity_no {
    label: "Entity No."
    type: string
    sql: ${TABLE}.ENTITY_NO ;;
  }

  dimension: estimatedenrollmentlevel {
    label: "Enrollment level (est)"
    type: tier
    hidden: yes
    tiers: [
      50,
      100,
      500,
      1000,
      5000,
      10000
    ]
    style: integer
    sql: ${TABLE}.ESTIMATEDENROLLMENTLEVEL ;;
  }

  dimension: institutionid {
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: institutionname {
    label: "Institution name"
    type: string
    sql: ${TABLE}.INSTITUTIONNAME ;;
  }

  dimension: marketsegmentmajor {
    label: "Market Segment - Major"
    group_label: "Market Segment"
    type: string
    sql: ${TABLE}.MARKETSEGMENTMAJOR ;;
  }

  dimension: marketsegmentminor {
    label: "Market Segment - Minor"
    group_label: "Market Segment"
    type: string
    sql: ${TABLE}.MARKETSEGMENTMINOR ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.SOURCE ;;
  }

  measure: count {
    label: "# Institutions"
    type: count
    drill_fields: [institutionname]
  }

}
