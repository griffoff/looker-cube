view: productfamilymap {
  label: "Product"
  sql_table_name:  dev.zpg.productfamilymap;;

  dimension: prod_family_description {
    type:  string
    sql: ${TABLE}.prod_family_description ;;
    primary_key: yes
    hidden:  yes
  }

  dimension: discipline_description {
    label: "Discipline Description (E1)"
    group_label: "Categories"
    type: string
    sql: ${TABLE}.discipline_description ;;
  }

}

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
    as discipline_rollup from dw_ga.dim_product;;
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
    label: "Tech Product Code"
    group_label: "Categories"
    sql: ${TABLE}.TECHPRODUCTCODE ;;
  }

  dimension: techproductdescription {
    label: "Tech Product Description"
    group_label: "Categories"
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
#     sql:  CASE
#                WHEN ${publicationgroup} in ('Career Ed', 'SWEP') THEN
#                     CASE
#                         WHEN ${minorsubjectmatter} = 'Office Management' THEN 'Course Tech Office Management'
#                         WHEN ${minorsubjectmatter} = 'Health Admin and Management' THEN 'Health Information Management'
#                         ELSE ${minorsubjectmatter}
#                         END
#                WHEN ${productfamily} = 'MT CRMS Literature' THEN 'Literature'
#                WHEN ${publicationseries} in ('CT-Networking', 'CT-Prog/PC/HD', 'CT-Revealed Series') THEN 'Creative and Technical'
#                 --??
#                WHEN ${publicationseries} = 'CPG-Networking Security' then 'Creative and Technical'
#                 --??
#                WHEN ${publicationseries} like 'CT-%' THEN 'Computing'
#                WHEN ${publicationseries} like '%History%'
#                   OR ${coursearea} = 'History: U.S. Survey' THEN 'History'
#                WHEN ${publicationseries} = 'Composition' THEN 'English'
#                WHEN ${publicationseries} like 'Biology%' THEN 'Biology'
#                WHEN ${publicationseries} = 'Human Resources Management' THEN 'Management'
#                WHEN ${publicationseries} = 'Health Sciences' THEN 'Sports/Health/Recreat/Leisure'
#                WHEN ${publicationseries} = 'Intro Poli Sci' THEN 'Political Science'
#                WHEN ${publicationseries} = 'FreshmanOrient/College Success' THEN 'Freshman Orientation/College'
#                WHEN ${publicationseries} = 'Nutrition' THEN 'Life Sciences'
#                WHEN ${publicationseries} = 'General Business' THEN 'Business'
#                WHEN ${publicationseries} = 'Not Specified' THEN
#                     ${majorsubjectmatter}
#                     /*
#                     CASE
#                     WHEN ${majorsubjectmatter} = 'Accross Cengage Disciplines' THEN 'Other ' || ${publicationgroup}
#                     ELSE ${majorsubjectmatter}
#                     END
#                     */
#                WHEN ${publicationseries} = 'Applied Math' THEN 'Applied Math-SMT'
#                WHEN ${publicationseries} = 'Earth Science' THEN 'Earth Sciences'
#                WHEN ${publicationseries} = 'Milady - Cosmetology' THEN 'Cosmetology'
#                WHEN ${publicationseries} = 'UNKNOWN' THEN 'Not Specified'
#                WHEN ${publicationseries} in ('Civil Engineering', 'General Engineering') then 'PGR 142-' || ${publicationseries}
#                WHEN ${publicationseries} = 'Religion' then 'Religion & Phenomena'
#                WHEN ${publicationseries} = 'Mass Communication' then 'Communication Arts'
#                WHEN ${publicationseries} = 'Literature/Upper Level English' then 'Literature'
#                ELSE ${publicationseries}
#         END
# ;;

     sql: ${TABLE}.discipline_rollup;;

    description: "
      derived from PublicationSeries
      except
        - Nelson Canda which = MajorSubjectMatter
        - publication group: Career Ed = MinorSubjectMatter
       - also History includes U.S. History
      "
    link: {
      label: "Engagement Toolkit (Dev)"
      url: "http://dashboard-dev.cengage.info/engtoolkit/discipline/{{value}}"
    }

    drill_fields: [productfamily]
  }

  measure: discipline_rank {
    label: "Discipline - Rank"
    group_label: "Categories"
    type: string
    sql: row_number() over (order by SUM(noofactivations) desc) ;;
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
  }


  dimension: discipline_old {
    type: string
    label: "Discipline (Old)"
    group_label: "Categories"
    sql: ${TABLE}.DISCIPLINE ;;

    link: {
      label: "Engagement Toolkit (Dev)"
      url: "http://dashboard-dev.cengage.info/engtoolkit/discipline/{{value}}"
    }
  }

  dimension: coursearea_pt {
    type: string
    label: "Course Area (Pubtrack)"
    group_label: "Pubtrack Categories"
    sql: ${TABLE}.COURSEAREA_PT ;;
  }

  dimension: discipline_pt {
    type: string
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
    type: string
    label: "IAC ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.IAC_ISBN ;;
  }

  dimension: isbn10 {
    type: string
    label: "ISBN10"
    group_label: "ISBN"
    sql: ${TABLE}.ISBN10 ;;
  }

  dimension: isbn13 {
    type: string
    label: "ISBN13"
    group_label: "ISBN"
    sql: ${TABLE}.ISBN13 ;;
  }

  dimension: mindtap_isbn {
    type: string
    label: "Mindtap ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.MINDTAP_ISBN ;;
  }

  dimension: pac_isbn {
    type: string
    label: "PAC ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.PAC_ISBN ;;
  }

  dimension: public_coretext_isbn {
    type: string
    label: "Public CoreText ISBN"
    group_label: "ISBN"
    sql: ${TABLE}.PUBLIC_CORETEXT_ISBN ;;
  }

  dimension: islatestedition {
    label: "Latest Edition?"
    type: string
    sql: ${TABLE}.ISLATESTEDITION ;;
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
    type: count
    drill_fields: []
  }
}
