view: dim_product {
  label: "Product"
  #sql_table_name: DW_GA.DIM_PRODUCT ;;
  derived_table: {
    sql:
    with products as (
      select *,
            CASE
                 WHEN p.PUBLICATIONGROUP in ('Career Ed', 'SWEP') THEN
                      CASE
                          WHEN p.MINORSUBJECTMATTER = 'Office Management' THEN 'Course Tech Office Management'
                          WHEN p.MINORSUBJECTMATTER = 'Health Admin and Management' THEN 'Health Information Management'
                          ELSE p.MINORSUBJECTMATTER
                          END
                 WHEN p.PRODUCTFAMILY = 'MT CRMS Literature' THEN 'Literature'
                 WHEN p.PUBLICATIONSERIES in ('CT-Networking', 'CT-Prog/PC/HD', 'CT-Revealed Series') THEN 'Creative and Technical'
                  --??
                 WHEN p.PUBLICATIONSERIES = 'CPG-Networking Security' then 'Creative and Technical'
                  --??
                 WHEN p.PUBLICATIONSERIES like 'CT-%' THEN 'Computing'
                 WHEN p.PUBLICATIONSERIES like '%History%'
                    OR p.COURSEAREA = 'History: U.S. Survey' THEN 'History'
                 WHEN p.PUBLICATIONSERIES = 'Composition' THEN 'English'
                 WHEN p.PUBLICATIONSERIES like 'Biology%' THEN 'Biology'
                 WHEN p.PUBLICATIONSERIES = 'Human Resources Management' THEN 'Management'
                 WHEN p.PUBLICATIONSERIES = 'Health Sciences' THEN 'Sports/Health/Recreat/Leisure'
                 WHEN p.PUBLICATIONSERIES = 'Intro Poli Sci' THEN 'Political Science'
                 WHEN p.PUBLICATIONSERIES = 'FreshmanOrient/College Success' THEN 'Freshman Orientation/College'
                 WHEN p.PUBLICATIONSERIES = 'Nutrition' THEN 'Life Sciences'
                 WHEN p.PUBLICATIONSERIES = 'General Business' THEN 'Business'
                 WHEN p.PUBLICATIONSERIES = 'Not Specified' THEN
                      p.MAJORSUBJECTMATTER
                      /*
                      CASE
                      WHEN p.MAJORSUBJECTMATTER = 'Accross Cengage Disciplines' THEN 'Other ' || p.PUBLICATIONGROUP
                      ELSE p.MAJORSUBJECTMATTER
                      END
                      */
                 WHEN p.PUBLICATIONSERIES = 'Applied Math' THEN 'Applied Math-SMT'
                 WHEN p.PUBLICATIONSERIES = 'Earth Science' THEN 'Earth Sciences'
                 WHEN p.PUBLICATIONSERIES = 'Milady - Cosmetology' THEN 'Cosmetology'
                 WHEN p.PUBLICATIONSERIES = 'UNKNOWN' THEN 'Not Specified'
                 WHEN p.PUBLICATIONSERIES in ('Civil Engineering', 'General Engineering') then 'PGR 142-' || p.PUBLICATIONSERIES
                 WHEN p.PUBLICATIONSERIES = 'Religion' then 'Religion & Phenomena'
                 WHEN p.PUBLICATIONSERIES = 'Mass Communication' then 'Communication Arts'
                 WHEN p.PUBLICATIONSERIES = 'Literature/Upper Level English' then 'Literature'
                 ELSE p.PUBLICATIONSERIES
          END
          as discipline_rollup
        ,nullif(edition, '-')::int as edition_number
        ,dense_rank() over (partition by productfamily order by edition_number desc) as latest
        ,concat(concat(productfamily,' - '),edition) as productfamily_edition
      from prod.dw_ga.dim_product p
    )
    ,ranking_d as (
      SELECT
        p.discipline_rollup
        ,COALESCE(SUM(fact_activation.NOOFACTIVATIONS), 0) AS discipline_activations
        ,COALESCE(SUM(CASE WHEN  d.datevalue >= dateadd(month, -6, CURRENT_DATE()) THEN fact_activation.NOOFACTIVATIONS END), 0) AS discipline_activations_6m
      FROM products p
      LEFT JOIN ${fact_activation.SQL_TABLE_NAME} AS fact_activation ON p.PRODUCTID = fact_activation.PRODUCTID
      LEFT JOIN ${dim_date.SQL_TABLE_NAME} d on fact_activation.activationdatekey = d.datekey
      GROUP BY 1
    )
    ,ranking_f as (
      SELECT
        p.productfamily
        ,COALESCE(SUM(fact_activation.NOOFACTIVATIONS), 0) AS family_activations
        ,COALESCE(SUM(CASE WHEN  d.datevalue >= dateadd(month, -6, CURRENT_DATE()) THEN fact_activation.NOOFACTIVATIONS END), 0) AS family_activations_6m
      FROM products p
      LEFT JOIN ${fact_activation.SQL_TABLE_NAME} AS fact_activation ON p.PRODUCTID = fact_activation.PRODUCTID
      LEFT JOIN ${dim_date.SQL_TABLE_NAME} d on fact_activation.activationdatekey = d.datekey
      GROUP BY 1
    )
    select
      p.*
      ,rf.family_activations
      ,rf.family_activations_6m
      ,rd.discipline_activations
      ,rd.discipline_activations_6m
      ,DENSE_RANK() OVER (ORDER BY rd.discipline_activations DESC) AS discipline_rank
      ,DENSE_RANK() OVER (ORDER BY rf.family_activations DESC) AS family_rank
      ,DENSE_RANK() OVER (ORDER BY rd.discipline_activations_6m DESC) AS discipline_rank_6m
      ,DENSE_RANK() OVER (ORDER BY rf.family_activations_6m DESC) AS family_rank_6m
    from products p
    left join ranking_d rd on p.discipline_rollup = rd.discipline_rollup
    left join ranking_f rf on p.productfamily = rf.productfamily
    order by productid
    ;;
    sql_trigger_value: select count(*) from dw_ga.dim_product ;;
  }

  # parameter: no_of_groups {
  #   label: "Select a number of groups"
  #   description: "Select a number of groups to split the records into
  #   the Assigned Group dimension will display a number between 1 and the number of groups chosen for every record in your dataset"
  #   type: unquoted
  #   allowed_value: {
  #     label: "No split, all records in the same group"
  #     value: "1"
  #   }
  #   allowed_value: {
  #     label: "Split the dataset into 2 different groups"
  #     value: "2"
  #   }
  #   allowed_value: {
  #     label: "Split the dataset into 3 different groups"
  #     value: "3"
  #   }
  #   allowed_value: {
  #     label: "Split the dataset into 4 different groups"
  #     value: "4"
  #   }
  #   default_value: "1"
  #   view_label: "** MODELLING TOOLS **"
  #   required_fields: [assigned_group]
  # }

  # dimension: assigned_group {
  #   label: "Assigned Group"
  #   description: ""
  #   sql: uniform(1, {% parameter no_of_groups %}, random()) ;;
  #   # calculation to make this number the same for a given guid
  #   # Both versions require a known GUID field, the examples use a hard coded one which will need to be changed
  #   # VERSION 1
  #   # this version based on the guid itself, so may not be evenly distributed
  #   # sql: (mod(abs(hash("olr_courses.instructor_guid")), {% parameter no_of_groups %})) + 1

  #   # VERSION 2
  #   # this version should be evenly distributed but will need to be a measure
  #   # sql: mod(dense_rank() over (order by "olr_courses.instructor_guid"), {% parameter no_of_groups %}) + 1
  #   view_label: "** MODELLING TOOLS **"
  # }

  set: curated_fields {fields:[course,edition,productfamily, coursearea, discipline, discipline_rank_6m, discipline_rank, family_rank_6m, family_rank, product, title, count,productfamily_edition,minorsubjectmatter,iac_isbn,isbn10,isbn13,pac_isbn,mindtap_isbn]}

  dimension: discipline_rank {description: "Discipline rank by total activations (all time)" type:number group_label:"Product Ranking"}
  dimension: family_rank {description: "Product family rank by total activations (all time)" type:number group_label:"Product Ranking"}
  dimension: discipline_rank_6m {description: "Discipline rank by total activations in the last 6 months" type:number group_label:"Product Ranking"}
  dimension: family_rank_6m {description: "Product family rank by total activations in the last 6 months" type:number group_label:"Product Ranking"}

#   measure: discipline_rank {
#     label: "Discipline - Rank"
#     group_label: "Categories"
#     type: string
#     sql: row_number() over (order by SUM(noofactivations) desc) ;;
#     hidden: yes
#   }
#
#   dimension: discipline_rank_tier  {
#     label: "Discipline - Rank (tiers)"
#     group_label: "Categories"
#     type: tier
#     style: interval
#     tiers: [10, 20, 50]
#     sql: row_number() over (order by SUM(noofactivations) desc) ;;
#   }

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
    group_label: "Product Family"
    sql: ${TABLE}.EDITION ;;
  }

  dimension: edition_number {
    type:  number
    hidden: yes
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
    description: "Brand Discipline"
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
    group_label: "Product Family"
    description: "Use if data for multiple editions is desired.  This dimension pulls data for all non-filtered editions of a given product family."
    sql: ${TABLE}.PRODUCTFAMILY ;;
  }

  dimension: productfamily_edition {
    type: string
    label: "Product Family + Edition"
    group_label: "Product Family"
    description: "Use if comparing multiple titles or specific products within a Course Area/Discipline.  This dimension pulls data for a specific combination of product family and edition."
    #sql: concat(concat(${productfamily},' - '),${edition});;
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
#     group_label: "Categories"
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
#    group_label: "Categories"
   sql: ${TABLE}.discipline_rollup;;
    #sql: ${publicationseries};;

    link: {
      label: "Engagement Toolkit"
      url: "http://dashboard.cengage.info/engtoolkit/discipline/{{value}}"
    }

    drill_fields: [productfamily]
  }

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
      END;;
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
    description: "This is the digital product. This ISBN is purchased with a transaction, the ISBN linked to an Access Code, and the ISBN Courses are built on.
    These have search metadata added in business systems, and are indexed by the various catalogs.
    The IAC ISBN will be a sub-product to a Core/Title ISBN. There can be multiple IAC ISBNs associated with a single Core,
    but an IAC ISBN itself can have only ONE Core ISBN. IAC ISBN may have one or multiple Component ISBNs in its Bill of Materials."
    type: string
    label: "IAC ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.IAC_ISBN ;;
  }

  dimension: isbn10 {
    description: "These are individual products inside of an IAC.  These are MindTap products, Coursemate, CNOW, Aplia, ebooks, recourse centers, mobile apps, etc.
    One component ISBN may be part of multiple IACs. Only one Courseware Component ISBN product may exist in an IAC.
    But that component can be in multiple IACs that have different shared components along with it that are also Component ISBNs."
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
    description: "This is the ISBN of a physical Printed Access Card, similar to how a physical workbook would have a unique ISBN.  Printed on this card is a single Access Code that has been generated from an IAC ISBN."
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

  measure: count_disciplines {
    label: "# Disciplines"
    type: count_distinct
    sql: ${discipline} ;;
  }

  measure: count_product_family {
    label: "# Product Families"
    type: count_distinct
    sql: ${productfamily} ;;
  }

  measure: count {
    label: "# Products"
    description: "Count of the number of products included in a given view.
    This measure is only relevant at a high-level (e.g. for an institution).  At a low (e.g. course key) level, this measure has limited value."
    type: count
    drill_fields: []
  }
}
