# connection: "snowflake_prod"

# include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

include: "cube.model.lkml"
# include: "dims.model.lkml"

explore: fact_siteusage_dev {
#   extends: [fact_siteusage]
#   from: fact_siteusage
  view_name: fact_siteusage



join: activity_usage_facts {
  view_label: "Activity Facts"
  sql_on: (${activity_usage_facts.courseID},${activity_usage_facts.activity_type},${activity_usage_facts.partyid})
  = (${fact_siteusage.courseid},${mindtap_lp_activity_tags.activity_type},${fact_siteusage.partyid}) ;;
  relationship: one_to_one
}
}
