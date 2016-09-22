- view: dim_activity
  label: 'Activity'
  sql_table_name: DW_GA.DIM_ACTIVITY_V
  fields:

  - dimension: activitycategory
    label: 'Category'
    type: string
    sql: ${TABLE}.Category
  
  - dimension: activitysubcategory
    label: 'Sub category'
    type: string
    sql: ${TABLE}.SubCategory

  - dimension: activitysubtype
    label: 'Sub type'
    type: string
    sql: ${TABLE}.SubType

  - dimension: activityid
    type: number
    sql: ${TABLE}.ACTIVITYID
    primary_key: true
    hidden: true
  
  - dimension: possiblepoints
    label: 'Possible points'
    type: number
    sql: ${TABLE}.possiblepoints
    hidden: true
    
  - dimension: possiblepoints_bucket
    label: 'Possible points (bins)'
    type: tier
    tiers: [5, 10, 20, 50, 100]
    style: integer
    sql: ${possiblepoints}
  
  - dimension: APPLICATIONNAME
    label: 'Application Name'
    type: string
    sql: ${TABLE}.APPLICATIONNAME

  - dimension: assigned
    label: 'Assigned'
    type: string
    sql: ${TABLE}.ASSIGNED
  
  - dimension: originalassigned
    label: 'Originally assigned'
    type: string
    sql: ${TABLE}.ORIGINALASSIGNED
    
  - dimension: assigned_status
    label: 'Assignment status'
    type: string
    sql: |
      CASE 
        WHEN ${assigned} = 'Unassigned' AND ${originalassigned} = 'Assigned' THEN 'DE-ASSIGNED'
        WHEN ${assigned} = 'Assigned' AND ${originalassigned} = 'Unassigned' THEN 'PROMOTED TO ASSIGNED'
        WHEN ${assigned} = ${originalassigned} THEN ${originalassigned} || ' - NO CHANGE'
        ELSE ${assigned}
      END
    
  - dimension: scorable
    label: 'Scorable'
    type: string
    sql: ${TABLE}.SCORABLE

  - dimension: originalscorable
    label: 'Originally scorable'
    type: string
    sql: ${TABLE}.ORIGINALSCORABLE
  
  - measure: count
    label: 'No. of Activities'
    type: count
    drill_fields: []

