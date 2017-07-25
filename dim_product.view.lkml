view: dim_product {
  label: "Product"
  #sql_table_name: DW_GA.DIM_PRODUCT ;;
  derived_table: {
    sql: select *,
CASE
               WHEN dw_ga.dim_product.PUBLICATIONGROUP in ('Career Ed', 'SWEP') THEN
                    CASE
                        WHEN dw_ga.dim_product.MINORSUBJECTMATTER = 'Office Management' THEN 'Course Tech Office Management'
                        WHEN dw_ga.dim_product.MINORSUBJECTMATTER = 'Health Admin and Management' THEN 'Health Information Management'
                        ELSE dw_ga.dim_product.MINORSUBJECTMATTER
                        END
               WHEN dw_ga.dim_product.PRODUCTFAMILY = 'MT CRMS Literature' THEN 'Literature'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES in ('CT-Networking', 'CT-Prog/PC/HD', 'CT-Revealed Series') THEN 'Creative and Technical'
                --??
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'CPG-Networking Security' then 'Creative and Technical'
                --??
               WHEN dw_ga.dim_product.PUBLICATIONSERIES like 'CT-%' THEN 'Computing'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES like '%History%'
                  OR dw_ga.dim_product.COURSEAREA = 'History: U.S. Survey' THEN 'History'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Composition' THEN 'English'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES like 'Biology%' THEN 'Biology'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Human Resources Management' THEN 'Management'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Health Sciences' THEN 'Sports/Health/Recreat/Leisure'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Intro Poli Sci' THEN 'Political Science'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'FreshmanOrient/College Success' THEN 'Freshman Orientation/College'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Nutrition' THEN 'Life Sciences'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'General Business' THEN 'Business'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Not Specified' THEN
                    dw_ga.dim_product.MAJORSUBJECTMATTER
                    /*
                    CASE
                    WHEN dim_product.MAJORSUBJECTMATTER = 'Accross Cengage Disciplines' THEN 'Other ' || dim_product.PUBLICATIONGROUP
                    ELSE dim_product.MAJORSUBJECTMATTER
                    END
                    */
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Applied Math' THEN 'Applied Math-SMT'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Earth Science' THEN 'Earth Sciences'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Milady - Cosmetology' THEN 'Cosmetology'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'UNKNOWN' THEN 'Not Specified'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES in ('Civil Engineering', 'General Engineering') then 'PGR 142-' || dim_product.PUBLICATIONSERIES
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Religion' then 'Religion & Phenomena'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Mass Communication' then 'Communication Arts'
               WHEN dw_ga.dim_product.PUBLICATIONSERIES = 'Literature/Upper Level English' then 'Literature'
               ELSE dw_ga.dim_product.PUBLICATIONSERIES
        END
        as discipline_rollup
      ,dense_rank() over (partition by productfamily order by nullif(edition, '-')::int desc) as latest
    from dw_ga.dim_product
    order by productid;;
    sql_trigger_value: select count(*) from dw_ga.dim_product ;;
  }

  dimension: course {
    label: "Course Name"
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.COURSE ;;
  }

  dimension: authors {
    type: string
    label: "Authors"
    group_label: "Product Details"
    sql: ${TABLE}.AUTHORS ;;
  }

  dimension: edition {
    type: string
    label: "Edition"
    group_label: "Product Details"
    sql: ${TABLE}.EDITION ;;
  }

  dimension: majorsubjectmatter {
    type: string
    label: "Major Subject Matter"
    group_label: "Subject Matter"
    sql: ${TABLE}.MAJORSUBJECTMATTER ;;
  }

  dimension: minorsubjectmatter {
    type: string
    label: "Minor Subject Matter"
    group_label: "Subject Matter"
    sql: ${TABLE}.MINORSUBJECTMATTER ;;
  }

  dimension: mediatype {
    label: "Media Type"
    group_label: "Categories"
    hidden: yes
    type: string
    sql: ${TABLE}.MEDIATYPE ;;
  }

  dimension: productfamily {
    type: string
    label: "Product Family"
    group_label: "Categories"
    sql: ${TABLE}.PRODUCTFAMILY ;;
  }

  dimension: publicationgroup {
    type: string
    label: "Publication Group"
    group_label: "Publication Categories"
    sql: ${TABLE}.PUBLICATIONGROUP ;;
  }

  dimension: techproductcode {
    type: string
    hidden: yes
    label: "Tech Product Code"
    group_label: "Categories"
    sql: ${TABLE}.TECHPRODUCTCODE ;;
  }

  dimension: techproductdescription {
    label: "Tech Product Description"
    group_label: "Categories"
    hidden: yes
    type: string
    sql: ${TABLE}.TECHPRODUCTDESCRIPTION ;;
  }

  dimension: coursearea {
    type: string
    label: "Course Area"
    group_label: "Categories"
    sql: ${TABLE}.COURSEAREA ;;
  }

  dimension: publicationseries {
    type: string
    label: "Publication Series"
    group_label: "Publication Categories"
    sql: ${TABLE}.PUBLICATIONSERIES ;;
  }
  dimension: discipline {
    type: string
    label: "Discipline"
   group_label: "Categories"
   sql: ${TABLE}.discipline_rollup;;
    #sql: ${publicationseries};;

    link: {
      label: "Engagement Toolkit"
      url: "http://dashboard.cengage.info/engtoolkit/discipline/{{value}}"
    }

    drill_fields: [productfamily]
  }

  measure: discipline_rank {
    label: "Discipline - Rank"
    group_label: "Categories"
    type: string
    sql: row_number() over (order by SUM(noofactivations) desc) ;;
    hidden: yes
  }
#
#   dimension: discipline_rank_tier  {
#     label: "Discipline - Rank (tiers)"
#     group_label: "Categories"
#     type: tier
#     style: interval
#     tiers: [10, 20, 50]
#     sql: row_number() over (order by SUM(noofactivations) desc) ;;
#   }

  measure: discipline_rank_2 {
    label: "Discipline - Rank 2"
    group_label: "Categories"
    type: string
    sql:
      CASE
      WHEN row_number() over (order by SUM(noofactivations) desc)
      <20 THEN '0-20'
      WHEN row_number() over (order by SUM(noofactivations) desc)
      <80 THEN '20-80'
      ELSE '>80'
      END

      ;;
    hidden: yes
  }


  dimension: discipline_old {
    type: string
    hidden: yes
    label: "Discipline (Old)"
    group_label: "Categories"
    sql: ${TABLE}.DISCIPLINE ;;

   link: {
      label: "Engagement Toolkit"
      url: "http://dashboard.cengage.info/engtoolkit/discipline/{{hed_discipline._value}}"
    }
  }

  dimension: coursearea_pt {
    type: string
    hidden: yes
    label: "Course Area (Pubtrack)"
    group_label: "Pubtrack Categories"
    sql: ${TABLE}.COURSEAREA_PT ;;
  }

  dimension: discipline_pt {
    type: string
    hidden: yes
    label: "Discipline (Pubtrack)"
    group_label: "Pubtrack Categories"
    sql: ${TABLE}.DISCIPLINE_PT ;;
  }

  dimension: division_cd {
    label: "Division Code"
    group_label: "Sales Division"
    type: string
    sql: ${TABLE}.DIVISION_CD ;;
  }

  dimension: division_de {
    type: string
    label: "Division Description"
    group_label: "Sales Division"
    sql: ${TABLE}.DIVISION_DE ;;
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

  dimension: iac_isbn {
    description: "IAC ISBN is the core ISBN for a given product/title.  If you need ISBN for usage data, ideally use this value.
      However, the raw data source has IAC ISBN data gaps for a small percentage of products; if this impacts your analysis, utilize ISBN13."
    type: string
    label: "IAC ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.IAC_ISBN ;;
  }

  dimension: isbn10 {
    description: "Do not use for analysis.  ISBN10 dimension is available to help confirm what the correct IAC ISBN or ISBN13 should be."
    type: string
    label: "ISBN10"
    group_label: "ISBN"
    sql: ${TABLE}.ISBN10 ;;
  }

  dimension: isbn13 {
    description: "ISBN13 can be used for ISBN-level analysis if necessary.  IAC ISBN is preferred, but due to some limited gaps in IAC ISBN data,
      ISBN13 may be required as a substitute.  No ISBN13 gaps have been found as of July 2017."
    type: string
    label: "ISBN13"
    group_label: "ISBN"
    sql: ${TABLE}.ISBN13 ;;
  }

  dimension: mindtap_isbn {
    description: "Do not use for analysis.  Mindtap ISBN dimension is available to help confirm what the correct IAC ISBN or ISBN13 should be."
    type: string
    label: "Mindtap ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.MINDTAP_ISBN ;;
  }

  dimension: pac_isbn {
    description: "Do not use for analysis.  PAC ISBN dimension is available to help confirm what the correct IAC ISBN or ISBN13 should be."
    type: string
    label: "PAC ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.PAC_ISBN ;;
  }

  dimension: public_coretext_isbn {
    description: "Do not use for analysis.  CoreText ISBN dimension is available to help confirm what the correct IAC ISBN or ISBN13 should be."
    type: string
    label: "Public CoreText ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.PUBLIC_CORETEXT_ISBN ;;
  }

  dimension: editionrecency {
    label: "Edition List"
    description: "Relative edition index - latest edition is always 1, the previous edition 2, and so on.
    e.g.
    - Product Family X has editions 001, 002, 003
    - Edition List will be 3, 2, 1
    "
    type: number
    group_label: "Product Details"
    sql: ${TABLE}.latest ;;
  }

  dimension: islatestedition {
    label: "Current Edition"
    description: "Flag that can be used as a filter to only look at the latest edition of a given product."
    type: yesno
    group_label: "Product Details"
    #sql: ${TABLE}.ISLATESTEDITION ;;
    sql: ${editionrecency} = 1 ;;
  }

  dimension_group: loaddate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  dimension: product {
    type: string
    label: "Product Name"
    group_label: "Product Details"
    sql: ${TABLE}.PRODUCT ;;
  }

  dimension: product_skey {
    type: string
    sql: ${TABLE}.PRODUCT_SKEY ;;
    hidden: yes
  }

  dimension: title {
    type: string
    label: "Product Title"
    group_label: "Product Details"
    sql: ${TABLE}.TITLE ;;
  }

  dimension: titleshort {
    type: string
    label: "Product Title (Short)"
    group_label: "Product Details"
    sql: ${TABLE}.TITLESHORT ;;
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    primary_key: yes
    hidden: yes
  }



  measure: count {
    label: "No. of Products"
    description: "Count of the number of products included in a given view.
    This measure is only relevant at a high-level (e.g. for an institution).  At a low (e.g. course key) level, this measure has limited value."
    type: count
    drill_fields: []
  }
}
