# include: "cube.model.lkml"

connection: "snowflake_prod"
# label:"DEV - Cube Data on Looker"
#
# explore: fact_siteusage_dev {
#   extends: [fact_siteusage]
#   label: "DEV site usage extend"
#   from: fact_siteusage
#   view_name: fact_siteusage
#
#   join: activity_usage_facts {
#     view_label: "Activity Facts"
#     sql_on: (${activity_usage_facts.courseid},${activity_usage_facts.activity_type},${activity_usage_facts.partyid})
#             = (${fact_siteusage.courseid},${mindtap_lp_activity_tags.activity_type},${fact_siteusage.partyid}) ;;
#     relationship: one_to_one
#   }
#
#   join: ga_data_parsed {
#     sql_on: ${dim_party.guid_raw} = ${ga_data_parsed.userssoguid}
#         and ${dim_course.olr_course_key} = ${ga_data_parsed.coursekey}
#         and ${lp_node_map.nodeid} = ${ga_data_parsed.activityid};;
#     relationship: one_to_many
#   }
#
# }
