- view: dim_product
  label: 'Product'
  sql_table_name: DW_GA.DIM_PRODUCT
  fields:

  - dimension: course
    label: 'Course Name'
    group_label: 'Product Details'
    type: string
    sql: ${TABLE}.COURSE
    
  - dimension: authors
    type: string
    label: 'Authors'
    group_label: 'Product Details'
    sql: ${TABLE}.AUTHORS
    
  - dimension: edition
    type: string
    label: 'Edition'
    group_label: 'Product Details'
    sql: ${TABLE}.EDITION
    
  - dimension: majorsubjectmatter
    type: string
    label: 'Major Subject Matter'
    group_label: 'Subject Matter'
    sql: ${TABLE}.MAJORSUBJECTMATTER
    
  - dimension: minorsubjectmatter
    type: string
    label: 'Minor Subject Matter'
    group_label: 'Subject Matter'
    sql: ${TABLE}.MINORSUBJECTMATTER

  - dimension: mediatype
    label: 'Media Type'
    group_label: 'Categories'
    type: string
    sql: ${TABLE}.MEDIATYPE
    
  - dimension: productfamily
    type: string
    label: 'Product Family'
    group_label: 'Categories'
    sql: ${TABLE}.PRODUCTFAMILY

  - dimension: publicationgroup
    type: string
    label: 'Publication Group'
    group_label: 'Publication Categories'
    sql: ${TABLE}.PUBLICATIONGROUP

  - dimension: publicationseries
    type: string
    label: 'Publication Series'
    group_label: 'Publication Categories'
    sql: ${TABLE}.PUBLICATIONSERIES

  - dimension: techproductcode
    type: string
    label: 'Tech Product Code'
    group_label: 'Categories'
    sql: ${TABLE}.TECHPRODUCTCODE

  - dimension: techproductdescription
    label: 'Tech Product Description'
    group_label: 'Categories'
    type: string
    sql: ${TABLE}.TECHPRODUCTDESCRIPTION

  - dimension: coursearea
    type: string
    label: 'Course Area'
    group_label: 'Categories'
    sql: ${TABLE}.COURSEAREA
    
  - dimension: discipline
    type: string
    label: 'Discipline'
    group_label: 'Categories'
    sql: ${TABLE}.DISCIPLINE
    links:
    - label: Engagement Toolkit (Dev)
      url: http://dashboard-dev.cengage.info/engtoolkit/discipline/{{value}}

  - dimension: coursearea_pt
    type: string
    label: 'Course Area (Pubtrack)'
    group_label: 'Pubtrack Categories'
    sql: ${TABLE}.COURSEAREA_PT

  - dimension: discipline_pt
    type: string
    label: 'Discipline (Pubtrack)'
    group_label: 'Pubtrack Categories'
    sql: ${TABLE}.DISCIPLINE_PT

  - dimension: division_cd
    label: 'Division Code'
    group_label: 'Sales Division'
    type: string
    sql: ${TABLE}.DIVISION_CD

  - dimension: division_de
    type: string
    label: 'Division Description'
    group_label: 'Sales Division'
    sql: ${TABLE}.DIVISION_DE

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true

  - dimension: iac_isbn
    type: string
    label: 'IAC ISBN'
    group_label: 'ISBN'
    sql: ${TABLE}.IAC_ISBN

  - dimension: isbn10
    type: string
    label: 'ISBN10'
    group_label: 'ISBN'
    sql: ${TABLE}.ISBN10

  - dimension: isbn13
    type: string
    label: 'ISBN13'
    group_label: 'ISBN'
    sql: ${TABLE}.ISBN13
    
  - dimension: mindtap_isbn
    type: string
    label: 'Mindtap ISBN'
    group_label: 'ISBN'
    sql: ${TABLE}.MINDTAP_ISBN

  - dimension: pac_isbn
    type: string
    label: 'PAC ISBN'
    group_label: 'ISBN'
    sql: ${TABLE}.PAC_ISBN
    
  - dimension: public_coretext_isbn
    type: string
    label: 'Public CoreText ISBN'
    group_label: 'ISBN'
    sql: ${TABLE}.PUBLIC_CORETEXT_ISBN

  - dimension: islatestedition
    label: 'Latest Edition?'
    type: string
    sql: ${TABLE}.ISLATESTEDITION

  - dimension_group: loaddate
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.LOADDATE
    hidden: true

  - dimension: product
    type: string
    label: 'Product Name'
    group_label: 'Product Details'
    sql: ${TABLE}.PRODUCT

  - dimension: product_skey
    type: string
    sql: ${TABLE}.PRODUCT_SKEY
    hidden: true

  - dimension: title
    type: string
    label: 'Product Title'
    group_label: 'Product Details'
    sql: ${TABLE}.TITLE

  - dimension: titleshort
    type: string
    label: 'Product Title (Short)'
    group_label: 'Product Details'
    sql: ${TABLE}.TITLESHORT
    
  - dimension: productid
    type: string
    sql: ${TABLE}.PRODUCTID
    primary_key: true
    hidden: true

  - measure: count
    label: 'No. of Products'
    type: count
    drill_fields: []

