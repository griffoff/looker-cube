- connection: snowflake_migration_test
  label: 'Cube Data on Looker'

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: dim_course
  label: 'Course'
  extension: required
  joins:
    - join: dim_start_date 
      sql_on: ${dim_course.startdatekey} = ${dim_start_date.datekey}
      relationship: many_to_one
    - join: dim_end_date 
      sql_on: ${dim_course.enddatekey} = ${dim_end_date.datekey}
      relationship: many_to_one
    - join: dim_product
      relationship: many_to_one
      sql_on: ${dim_course.productid} = ${dim_product.productid}
    - join: dim_institution
      relationship: many_to_one
      sql_on: ${dim_course.institutionid} = ${dim_institution.institutionid}
    - join: dim_productplatform
      relationship: many_to_one
      sql_on: ${dim_course.productplatformid} = ${dim_productplatform.productplatformid}
  
- explore: dim_date
  extension: required
  extends: [fact_session, fact_siteusage]
  joins:
    - join: fact_session
      sql_on: ${dim_date.datekey} = ${fact_session.eventdatekey}
      relationship: one_to_many
    - join: fact_siteusage
      sql_on: ${dim_date.datekey} = ${fact_siteusage.eventdatekey}
      relationship: one_to_many
    - join: fact_activation
      sql_on: ${dim_date.datekey} = ${fact_activation.activationdatekey}
      relationship: one_to_many
    - join: fact_enrollment
      sql_on: ${dim_date.datekey} = ${fact_enrollment.eventdatekey}
      relationship: one_to_many
      
- explore: dim_institution
  extension: required
  joins:
    - join: dim_location
      sql_on: ${dim_institution.locationid} = ${dim_location.locationid}
      relationship: many_to_one


- explore: dim_deviceplatform
  extension: required

- explore: dim_eventtype
  extension: required

- explore: dim_learningpath
  extension: required
  joins:
    #- join: parentlearningpath
    #  type: left_outer 
    #  sql_on: ${dim_learningpath.parentlearningpathid} = ${parentlearningpath.parentlearningpathid}
    #  relationship: many_to_one
    - join: dim_master_node
      sql_on: ${dim_learningpath.masternodeid} = ${dim_master_node.masternodeid}
      relationship: many_to_one
    - join: dim_first_used_date
      sql_on: ${dim_master_node.first_used_datekey} = ${dim_first_used_date.datekey}
      relationship: many_to_one
    
- explore: dim_location
  extension: required
  joins:
    - join: location
      type: left_outer 
      sql_on: ${dim_location.locationid} = ${location.locationid}
      relationship: many_to_one

- explore: dim_pagedomain
  extension: required
  joins:
    - join: dim_productplatform
      sql_on: ${dim_pagedomain.productplatformid} = ${dim_productplatform.productplatformid}
      relationship: many_to_one

#- explore: dim_party
  
- explore: dim_user
  extension: required
  joins:
    - join: dim_party
      sql_on: ${dim_user.mainpartyid} = ${dim_party.partyid}
      relationship: many_to_one  
  
- explore: fact_activation
  label: 'Activations'
  extends: [dim_user, dim_course]
  joins: 
    - join: dim_date
      sql_on: ${fact_activation.activationdatekey} = ${dim_date.datekey}
      relationship: many_to_one
    - join: dim_user
      sql_on: ${fact_activation.userid} = ${dim_user.userid}
      relationship: many_to_one
    - join: dim_product
      sql_on: ${fact_activation.productid} = ${dim_product.productid}
      relationship: many_to_one
    - join: dim_institution
      sql_on: ${fact_activation.institutionid} = ${dim_institution.institutionid}
      relationship: many_to_one
    - join: dim_course
      sql_on: ${fact_activation.courseid} = ${dim_course.courseid}
      relationship: many_to_one
    - join: dim_relative_to_start_date
      sql_on: ${fact_activation.daysfromcoursestart} = ${dim_relative_to_start_date.days}
      relationship: many_to_one
    - join: dim_relative_to_end_date
      sql_on: ${fact_activation.daysbeforecourseend} = ${dim_relative_to_end_date.days}
      relationship: many_to_one 
    - join: fact_enrollment
      sql_on: ${fact_activation.courseid} = ${fact_enrollment.courseid} and ${fact_activation.partyid}) = ${fact_enrollment.partyid})
      relationship: one_to_many
      
- explore: fact_activityoutcome
  label: 'Activity Outcomes'
  extends: [dim_user, dim_course, dim_learningpath]
  joins: 
    - join: dim_completion_date
      sql_on: ${fact_activityoutcome.completeddatekey} = ${dim_completion_date.datekey}
      relationship: many_to_one
    - join: dim_user
      sql_on: ${fact_activityoutcome.userid} = ${dim_user.userid}
      relationship: many_to_one
    - join: dim_product
      sql_on: ${fact_activityoutcome.productid} = ${dim_product.productid}
      relationship: many_to_one
    - join: dim_learningpath
      sql_on: ${fact_activityoutcome.learningpathid} = ${dim_learningpath.learningpathid}
      relationship: many_to_one
    - join: dim_activity
      sql_on: ${fact_activityoutcome.activityid} = ${dim_activity.activityid}
      relationship: many_to_one
    - join: dim_institution
      sql_on: ${fact_activityoutcome.institutionid} = ${dim_institution.institutionid}
      relationship: many_to_one
    - join: dim_course
      sql_on: ${fact_activityoutcome.courseid} = ${dim_course.courseid}
      relationship: many_to_one
    - join: dim_relative_to_start_date
      sql_on: ${fact_activityoutcome.daysfromcoursestart} = ${dim_relative_to_start_date.days}
      relationship: many_to_one
    - join: dim_relative_to_end_date
      sql_on: ${fact_activityoutcome.daysbeforecourseend} = ${dim_relative_to_end_date.days}
      relationship: many_to_one
    - join: dim_relative_to_due_date
      sql_on: ${fact_activityoutcome.daysleftbeforeduedate} = ${dim_relative_to_due_date.days}
      relationship: many_to_one
    - join: dim_time
      sql_on: ${fact_activityoutcome.timekey} = ${dim_time.timekey}
      relationship: many_to_one
    - join: dim_filter
      sql_on: ${fact_activityoutcome.filterflag} = ${dim_filter.filterflag}
      relationship: many_to_one
    - join: fact_activation
      sql_on: ${fact_activityoutcome.courseid} = ${fact_activation.courseid} and ${fact_activityoutcome.userid} = ${fact_activation.userid}
      relationship: many_to_one
      
- explore: fact_activity
  label: 'Instructor Activities'
  extends: [dim_user, dim_course, dim_learningpath]
  joins: 
    - join: dim_eventtype
      sql_on: ${fact_activity.eventtypeid} = ${dim_eventtype.eventtypeid}
      relationship: many_to_one
    - join: dim_created_date
      sql_on: ${fact_activity.createddatekey} = ${dim_created_date.datekey}
      relationship: many_to_one
    - join: dim_user
      sql_on: ${fact_activity.userid} = ${dim_user.userid}
      relationship: many_to_one
    - join: dim_product
      sql_on: ${fact_activity.productid} = ${dim_product.productid}
      relationship: many_to_one
    - join: dim_learningpath
      sql_on: ${fact_activity.learningpathid} = ${dim_learningpath.learningpathid}
      relationship: many_to_one
    - join: dim_activity
      sql_on: ${fact_activity.activityid} = ${dim_activity.activityid}
      relationship: many_to_one
    - join: dim_institution
      sql_on: ${fact_activity.institutionid} = ${dim_institution.institutionid}
      relationship: many_to_one
    - join: dim_course
      sql_on: ${fact_activity.courseid} = ${dim_course.courseid}
      relationship: many_to_one
    - join: dim_relative_to_start_date
      sql_on: ${fact_activity.daysfromcoursestart} = ${dim_relative_to_start_date.days}
      relationship: many_to_one
    - join: dim_relative_to_end_date
      sql_on: ${fact_activity.daysbeforecourseend} = ${dim_relative_to_end_date.days}
      relationship: many_to_one
    - join: dim_time
      sql_on: ${fact_activity.timekey} = ${dim_time.timekey}
      relationship: many_to_one
    - join: dim_filter
      sql_on: ${fact_activity.filterflag} = ${dim_filter.filterflag}
      relationship: many_to_one

- explore: fact_appusage
  label: 'App usage'
  extends: [dim_user, dim_course, dim_learningpath]
  joins:
    - join: dim_learningpath
      sql_on: ${fact_appusage.learningpathid} = ${dim_learningpath.learningpathid}
      relationship: many_to_one
    - join: dim_location
      type: left_outer 
      sql_on: ${fact_appusage.locationid} = ${dim_location.locationid}
      relationship: many_to_one
    - join: dim_date
      sql_on: ${fact_appusage.eventdatekey} = ${dim_date.datekey}
      relationship: many_to_one
    - join: dim_user
      sql_on: ${fact_appusage.userid} = ${dim_user.userid}
      relationship: many_to_one
    - join: dim_party
      sql_on: ${fact_appusage.partyid} = ${dim_party.partyid}
      relationship: many_to_one
    - join: dim_product
      sql_on: ${fact_appusage.productid} = ${dim_product.productid}
      relationship: many_to_one
    - join: dim_course
      sql_on: ${fact_appusage.courseid} = ${dim_course.courseid}
      relationship: many_to_one
    - join: dim_deviceplatform
      sql_on: ${fact_appusage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid}
      relationship: many_to_one
    - join: dim_iframeapplication
      sql_on: ${fact_appusage.iframeapplicationid} = ${dim_iframeapplication.iframeapplicationid}
      relationship: many_to_one
    - join: dim_productplatform
      sql_on: ${fact_appusage.productplatformid} = ${dim_productplatform.productplatformid}
      relationship: many_to_one
    - join: dim_time
      sql_on: ${fact_appusage.timekey} = ${dim_time.timekey}
      relationship: many_to_one

- explore: fact_enrollment
  label: 'Enrollments'
  extends: [dim_user, dim_course]
  joins: 
    - join: dim_date
      sql_on: ${fact_enrollment.eventdatekey} = ${dim_date.datekey}
      relationship: many_to_one
    - join: dim_user
      sql_on: ${fact_enrollment.userid} = ${dim_user.userid}
      relationship: many_to_one
    - join: dim_product
      sql_on: ${fact_enrollment.productid} = ${dim_product.productid}
      relationship: many_to_one
    - join: dim_institution
      sql_on: ${fact_enrollment.institutionid} = ${dim_institution.institutionid}
      relationship: many_to_one
    - join: dim_course
      sql_on: ${fact_enrollment.courseid} = ${dim_course.courseid}
      relationship: many_to_one
    - join: dim_relative_to_start_date
      sql_on: ${fact_enrollment.daysfromcoursestart} = ${dim_relative_to_start_date.days}
      relationship: many_to_one
    - join: dim_relative_to_end_date
      sql_on: ${fact_enrollment.daysbeforecourseend} = ${dim_relative_to_end_date.days}
      relationship: many_to_one 
      
- explore: fact_session
  label: 'Web - Sessions'
  extends: [dim_user]
  joins:
    - join: dim_location
      sql_on: ${fact_session.locationid} = ${dim_location.locationid}
      relationship: many_to_one
    - join: dim_session_date
      from: dim_date
      sql_on: ${fact_session.eventdatekey} = ${dim_session_date.datekey}
      relationship: many_to_one
    - join: dim_time
      sql_on: ${fact_session.timekey} = ${dim_time.timekey}
      relationship: many_to_one
    - join: dim_deviceplatform
      sql_on: ${fact_session.deviceplatformid} = ${dim_deviceplatform.deviceplatformid}
      relationship: many_to_one
    - join: dim_product
      sql_on: ${fact_session.productid} = ${dim_product.productid}
      relationship: many_to_one
    - join: dim_productplatform
      sql_on: ${fact_session.productplatformid} = ${dim_productplatform.productplatformid}
      relationship: many_to_one
    - join: dim_user
      sql_on: ${fact_session.userid} = ${dim_user.userid}
      relationship: many_to_one
      
- explore: fact_siteusage
  label: 'Web - Site usage'
  extends: [dim_user, dim_course, dim_pagedomain]
  joins:
    - join: dim_date
      sql_on: ${fact_siteusage.eventdatekey} = ${dim_date.datekey}
      relationship: many_to_one
    - join: dim_course
      sql_on: ${fact_siteusage.courseid} = ${dim_course.courseid}
      relationship: many_to_one
    - join: dim_location
      sql_on: ${fact_siteusage.locationid} = ${dim_location.locationid}
      relationship: many_to_one
    - join: dim_activity
      sql_on: ${fact_siteusage.activityid} = ${dim_activity.activityid}
      relationship: many_to_one
    - join: dim_learningpath
      sql_on: ${fact_siteusage.learningpathid} = ${dim_learningpath.learningpathid}
      relationship: many_to_one
    - join: dim_master_node
      sql_on: ${fact_siteusage.masternodeid} = ${dim_master_node.masternodeid}
      relationship: many_to_one
    - join: dim_party
      sql_on: ${fact_siteusage.partyid} = ${dim_party.partyid}
      relationship: many_to_one
    - join: dim_user
      sql_on: ${fact_siteusage.userid} = ${dim_user.userid}
      relationship: many_to_one
    - join: dim_deviceplatform
      sql_on: ${fact_siteusage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid}
      relationship: many_to_one
    - join: dim_product
      sql_on: ${fact_siteusage.productid} = ${dim_product.productid}
      relationship: many_to_one
    - join: dim_time
      sql_on: ${fact_siteusage.timekey} = ${dim_time.timekey}
      relationship: many_to_one
    - join: dim_pagedomain
      sql_on: ${fact_siteusage.pagedomainid} = ${dim_pagedomain.pagedomainid}
      relationship: many_to_one
    - join: dim_start_date
      sql_on: ${fact_siteusage.coursestartdatekey} = ${dim_start_date.datekey}
      relationship: many_to_one
    - join: dim_relative_to_start_date
      sql_on: ${fact_siteusage.daysfromcoursestart} = ${dim_relative_to_start_date.days}
      relationship: many_to_one


