view: liberty_daily_feed {

derived_table: {
sql: SELECT
 dp.firstname as Student_First_Name
,dp.lastname as Student_Last_Name
,du.useremail as Student_Email
,dc.coursekey
,dc.coursename as Course_ID
,r.batchuid
,u2.fname as Professor_First_Name
,u2.lname as Professor_Last_Name
,u2.email as Professor_Email
,da.subcategory as Activity_Type
,dl.learningactivity as Activity_Title
,takestarttime as Activity_Start
,takeendtime as Last_Activity
,takeendtime as Submitted_Activity
,fao.timespent/60000 Time_On_Task_Minutes
,fao.points_earned as Points_Earned
,fao.points_possible as Points_Possible
,da.maxtakes as Attempts_Possible
,case
  when fao.completed = True then  'completed'
  when fao.completed = False then 'In-progress'
  else ''
end as status
FROM dw_ga.fact_activityoutcome as fao
join stg_mindtap.node node on node.id=fao.id
join stg_mindtap.snapshot s on s.id=node.snapshot_id
left join stg_mindtap.org_snapshot og on s.id=og.snapshot_id
left join stg_mindtap.org o on og.org_id=o.id
left join stg_mindtap.USER u2 on u2.id=s.created_by
join dw_ga.dim_date_v as dd on fao.completeddatekey=dd.datekey and fao.startdatekey=dd.datekey
join dw_ga.dim_institution as di on fao.institutionid=di.institutionid
join dw_ga.dim_user_v as du on fao.userid=du.userid
join dw_ga.dim_party_v dp on dp.guid = du.guid
inner join stg_mindtap.user mu on mu.source_id = dp.guid
join dw_ga.dim_activity_v as da on fao.activityid=da.activityid
join dw_ga.dim_course_v as dc on fao.courseid=dc.courseid
inner join dw_ga.dim_productplatform_v p on p.productplatformid = dc.productplatformid
join dw_ga.dim_learningpath_v as dl on fao.learningpathid=dl.learningpathid
left join reports.liberty_batchuid r on r.coursekey = dc.coursekey
WHERE di.institutionname='LIBERTY UNIV' and du.userrole='STUDENT'
and fao.filterflag=0
and fao.timespent>0
and takestarttime >= '20171110'

 ;;
  }
#
#   # Define your dimensions and measures here, like this:
dimension: Student_First_Name {
description: "First name of student"
type: string
sql: ${TABLE}.Student_First_Name ;;
  }

dimension: Student_Last_Name {
  description: "Last name of student"
  type: string
  sql: ${TABLE}.Student_Last_Name ;;
}

  dimension: Student_email {
    description: "Email of student"
    type: string
    sql: ${TABLE}.Student_email ;;
  }

  dimension: Coursekey {
    description: "Course key"
    type: string
    sql: ${TABLE}.Coursekey ;;
  }

  dimension: Course_Id {
    description: "Course name"
    type: string
    sql: ${TABLE}.Course_Id ;;
  }

  dimension: batchuid {
    description: "Unique id to link to LMS"
    type: string
    sql: ${TABLE}.batchuid ;;
  }

  dimension: Professor_last_name {
    description: "Last name of Professor"
    type: string
    sql: ${TABLE}.Professor_last_name ;;
  }

  dimension: Professor_First_Name {
    description: "First name of Professor"
    type: string
    sql: ${TABLE}.Professor_First_Name ;;
  }

  dimension: Professor_email {
    description: "Email of Professor"
    type: string
    sql: ${TABLE}.Professor_email ;;
  }

  dimension: Activity_Type {
    #description: "Activity Type"
    type: string
    sql: ${TABLE}.Activity_Type ;;
  }

  dimension: Activity_Title {
    #description: "Activity Title"
    type: string
    sql: ${TABLE}.Activity_Title ;;
  }

  dimension: Activity_Start {
    #description: "Activity Start date"
    type: date
    sql: ${TABLE}.Activity_Start ;;
  }

  dimension: Last_Activity {
    #description: "Last date activity was accessed"
    type: date
    sql: ${TABLE}.Last_Activity ;;
  }

  dimension: Submitted_Activity {
    #description: "Activity submission date"
    type: date
    sql: ${TABLE}.Submitted_Activity ;;
  }

  dimension: Time_On_Task_Minutes {
    #description: "Time on Task in Minutes"
    type: number
    sql: ${TABLE}.Time_On_Task_Minutes ;;
  }

  dimension: Points_Earned {
    #description: "Points earned"
    type: number
    sql: ${TABLE}.Points_Earned ;;
  }

  dimension: Points_Possible {
    #description: "Points possible"
    type: number
    sql: ${TABLE}.Points_Possible ;;
  }

  dimension: Attempts_Possible {
    #description: "Number of attempts possible"
    type: number
    sql: ${TABLE}.Attempts_Possible ;;
  }

  dimension: Status {
    #description: "Email of student"
    type: string
    sql: ${TABLE}.Status ;;
  }

}
