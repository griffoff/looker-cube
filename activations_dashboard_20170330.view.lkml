view: activations_dashboard_20170330 {
  label: "Activations Dashboard - as at May 30 2017"

  derived_table: {
    sql:  select column1 as ProductGroup, column2 as discipline, column3::int as ActivationsFY16
          from values
('SSBH','Psychology',82723)
,('SSBH','Political Science',35470)
,('SSBH','Economics',63712)
,('SSBH','Business Law',43426)
,('SSBH','History',32683)
,('SSBH','English',33378)
,('SSBH','Management',36448)
,('SSBH','Speech',24068)
,('SSBH','Criminal Justice',19026)
,('SSBH','Sociology',22570)
,('SSBH','Business Communication',21504)
,('SSBH','Business',15076)
,('SSBH','Finance',17594)
,('SSBH','Art',10224)
,('SSBH','Marketing',13437)
,('SSBH','Education',8807)
,('SSBH','Business Statistics',10115)
,('SSBH','Music',7820)
,('SSBH','Philosophy',4734)
,('SSBH','Counseling',3641)
,('STM','Freshman Orientation/College',34744)
,('STM','Computing',39478)
,('STM','Life Sciences',32094)
,('STM','Biology',23712)
,('STM','Sports/Health/Recreat/Leisure',11675)
,('STM','Developmental English',6544)
,('STM','Earth Sciences',4026)
,('STM','Course Tech Office Management',3511)
,('STM','Chemistry',3732)
,('STM','Astronomy',1892)
,('STM','Creative and Technical',1435)
,('STM','MIS',2362)
,('STM','Precalc/Coll Alg-Trig',11)
,('STM','Calculus',28)
,('STM','Applied Math-SMT',2)
,('STM','Statistics',0)
,('STM','Advanced Math',0)
,('STM','Developmental Math',3)
,('STM','Not Specified',1)
,('STM','Physics',1)
,('Skills','Basic Health Science',17822)
,('Skills','Automotive Trades',5152)
,('Skills','Medical Insurance & Coding',3485)
,('Skills','Paralegal',2762)
,('Skills','Mechanical Engineering',647)
,('Skills','HVAC/Refrigeration',653)
,('Skills','Medical Assisting',1213)
,('Skills','Health Information Management',1076)
,('Skills','Electrical',395)
,('Skills','Nursing Assisting',538)
,('Skills','Surgical Technology',605)
,('Skills','Career Development',217)
,('Skills','Accounting, General',132)
,('Skills','Cosmetology',2412)
,('Skills','Forensic Science',36)
,('Skills','Applied Math-Career',0)
,('Skills','Welding',7)
,('Skills','Agriscience',26)
,('Skills','Drafting',0)
,('Skills','Respiratory Care',0)
      ;;
  }

  dimension: discipline {
    type: string
    sql: ${TABLE}.discipline ;;
    primary_key: yes
  }

  dimension: productgroup {
    label: "Product Group"
    type: string
    sql: ${TABLE}.productgroup ;;
  }

  measure: activations_fy16 {
    label: "Activations FY16"
    type: sum
    sql: ${TABLE}.ActivationsFY16 ;;
  }

}


view: activations_from_JW {
  label: "Activations detail from John Walsh (DataMart)"
  derived_table: {
    sql: select pub_series_de, count(*) as activationsfy16
        from dev.zpg.activations_fy2016
        group by 1
 ;;
  }

  dimension: discipline {
    type: string
    sql: ${TABLE}.pub_series_de ;;
    primary_key: yes
  }

  measure: activations_fy16 {
    label: "Activations FY16"
    type: sum
    sql: ${TABLE}.ActivationsFY16 ;;
  }

}
