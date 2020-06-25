map_layer: cities {
  url: "https://github.com/drei01/geojson-world-cities/blob/master/cities.geojson"
}

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
    ,cui AS (
      SELECT
          DISTINCT entity_no, deal_type, deal_type IN ('Full School','All CL Courses') AS full_cui
          --note: some schools are CUI only for certain departments, so some students at those schools may have CUI redemptions and others regular CU - shouldn't boot out in this case or message or will create confusing experience
        FROM strategy.misc.cui_institutions_20190813
        WHERE institution_nm NOT IN ('TEXAS A&M UNIVERSITY SAN ANTONIO','LAKE LAND COLLEGE') --did not renew CU in FY20
    )
   SELECT
      i.dw_ldid, i.dw_ldts, COALESCE(i.institutionid, -1) as institutionid, i.locationid
      ,COALESCE(sis.name, i.institutionname) as institutionname
      ,sis.type as institutiontype
      ,i.marketsegmentmajor
      ,i.marketsegmentminor, i.estimatedenrollmentlevel, i.enrollmentnumber, COALESCE(sis.iso_country, i.country) as country, i.city, i.postalcode, i.region
      ,COALESCE(hi.institution_id, i.entity_no) as entity_no
     --,insti.Organization AS organization
      --,CASE WHEN insti.Organization = 'Higher Ed' THEN 'HED' ELSE 'Not HED' END as HED
      ,cui.deal_type
      ,cui.full_cui
    FROM dw_ga.dim_institution i
    --LEFT JOIN (SELECT * FROM Inst_rank WHERE institution_rank = 1 ) insti ON insti.institutionID = i.InstitutionID
    FULL JOIN prod.datavault.hub_institution hi ON i.entity_no = hi.institution_id
    LEFT JOIN prod.datavault.sat_institution_saws sis on hi.hub_institution_key = sis.hub_institution_key and sis._latest
    LEFT JOIN cui ON COALESCE(hi.institution_id, i.entity_no)::STRING = cui.entity_no::STRING
   -- left join (select distinct entity_no from looker_workshop.magellan_hed_entities) h on i.entity_no = h.entity_no
    ;;
    sql_trigger_value: select count(*) from dw_ga.dim_institution ;;
  }
  set: curated_fields {fields:[HED_filter,country,institutionname,postalcode,city]}

  set: marketing_fields { fields:[
        dim_institution.entity_no
        ,dim_institution.country
        ,dim_institution.institutionname
        ,dim_institution.city
        ,dim_institution.region
        ,dim_institution.source
        ,dim_institution.HED
        ,dim_institution.country
        ,dim_institution.HED_filter
        ,dim_institution.deal_type
        ,dim_institution.cui
        ,dim_institution.full_cui
        ,dim_institution.marketsegmentmajor
        ,dim_institution.marketsegmentminor
        ,dim_institution.organization] }

  set: CU_fields { fields:[marketing_fields*] }

#   sql_table_name: DW_GA.DIM_INSTITUTION ;;

  dimension: HED {
    label: "HED flag"
    description: "Flag to identify Higher-Ed data"
    type: string
#     hidden: yes
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
    sql: InitCap(${TABLE}.CITY) ;;
    map_layer_name: cities
  }

  dimension: country {
    group_label: "Location"
    type: string
#     sql: ${TABLE}.COUNTRY ;;
    sql: CASE WHEN LOWER(${TABLE}.COUNTRY) IN ('us','united states') THEN 'UNITED STATES' ELSE UPPER(${TABLE}.COUNTRY) END ;;
    map_layer_name: countries
  }

  dimension: postalcode {
    group_label: "Location"
    label: "Postal/Zip Code"
    type: zipcode
    sql: ${TABLE}.POSTALCODE ;;
    map_layer_name: us_zipcode_tabulation_areas
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

  dimension: organization {
    label: "Organization"
    type: string
    sql: ${TABLE}.organization ;;
  }


  dimension: estimatedenrollmentlevel {
    label: "Enrollment level (est)"
    type: tier
    hidden: yes
    tiers: [50, 100, 500, 1000, 5000, 10000]
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
    hidden: no
    sql: COALESCE(${TABLE}.MARKETSEGMENTMAJOR, 'UNKNOWN') ;;
  }

  dimension: marketsegmentminor {
    label: "Market Segment - Minor"
    group_label: "Market Segment"
    hidden: no
    type: string
    sql: COALESCE(${TABLE}.MARKETSEGMENTMINOR, 'UNKNOWN') ;;
  }

  dimension: source {
    description: "distinguishes between CLTS,Activation & OLR Courses"
    type: string
    hidden: yes
    sql: ${TABLE}.SOURCE ;;
  }

  dimension: deal_type {
    group_label: "Institutional Access"
    label: "CUI Deal type"
  }

  dimension: cui {
    group_label: "Institutional Access"
    type: yesno
    label: "CUI"
    sql: ${deal_type} IS NOT NULL ;;
  }

  dimension: full_cui {
    group_label: "Institutional Access"
    type: yesno
    label: "CUI Full Coverage"
  }

  measure: count {
    label: "# Institutions"
    description: "Count of institutions"
    type: count
    drill_fields: [institutionname]
  }

}
