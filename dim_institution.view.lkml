view: dim_institution {
  label: "Institution"
  derived_table: {
    sql:
    with Inst_rank as (
    SELECT
      DISTINCT
      ROW_NUMBER() OVER(Partition BY InstitutionID order by NoOFactivations DESC) as institution_rank
      ,InstitutionID
      ,Organization
      ,NoOfActivations
    FROM ${fact_activation.SQL_TABLE_NAME} -- looker_scratch.LR$JJ1J9IMSWA6J99O7DN51G_fact_activation
    WHERE InstitutionID != -1 and courseID != -1
    AND Organization !='UNKNOWN'
    order by 1,2,3 desc
    )
        select
          i.*
          ,case when insti.Organization = 'Higher Ed' then 'HED' else 'Not HED' end as HED
        from dw_ga.dim_institution i
        left join (SELECT * FROM Inst_rank WHERE institution_rank = 1 ) insti ON insti.institutionID = i.InstitutionID
       -- left join (select distinct entity_no from looker_workshop.magellan_hed_entities) h on i.entity_no = h.entity_no
        ;;
        sql_trigger_value: select count(*) from dw_ga.dim_institution ;;
  }
  set: curated_fields {fields:[HED_filter,country,institutionname,postalcode,city]}

#   sql_table_name: DW_GA.DIM_INSTITUTION ;;

  dimension: HED {
    label: "HED flag"
    description: "Flag to identify Higher-Ed data"
    type: string
    hidden: yes
  }

  dimension: HED_filter {
    view_label: "** RECOMMENDED FILTERS **"
    label: "HED filter"
    description: "Flag to identify Higher-Ed data"
# hidden: yes
    type:  yesno
    sql: ${HED} = 'HED' ;;
  }

  dimension: city {
    group_label: "Location"
    label: "City"
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    group_label: "Location"
    type: string
#     sql: ${TABLE}.COUNTRY ;;
    sql: CASE WHEN LOWER(${TABLE}.COUNTRY) IN ('us','united states') THEN 'UNITED STATES' ELSE UPPER(${TABLE}.COUNTRY) END ;;
  }

  dimension: postalcode {
    group_label: "Location"
    label: "Postal/Zip Code"
    type: zipcode
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: region {
    group_label: "Location"
    type: string
    map_layer_name: us_states
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
    label: "Institution Name"
    type: string
    sql: ${TABLE}.INSTITUTIONNAME ;;
  }

  dimension: marketsegmentmajor {
    label: "Market Segment - Major"
    group_label: "Market Segment"
    type: string
    hidden: yes
    sql: ${TABLE}.MARKETSEGMENTMAJOR ;;
  }

  dimension: marketsegmentminor {
    label: "Market Segment - Minor"
    group_label: "Market Segment"
    hidden: yes
    type: string
    sql: ${TABLE}.MARKETSEGMENTMINOR ;;
  }

  dimension: source {
    description: "distinguishes between CLTS,Activation & OLR Courses"
    type: string
    sql: ${TABLE}.SOURCE ;;
  }

  measure: count {
    label: "# Institutions"
    description: "Count of institutions"
    type: count
    drill_fields: [institutionname]
  }

}
