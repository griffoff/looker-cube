connection: "snowflake_migration_test"
label:"Source Data on Snowflake"
include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: olr_courses {
  label: "CLTS - Courses"
  join: entities{
    sql_on: ${olr_courses.entity_no} = ${entities.entity_no} ;;
    relationship: many_to_one
  }
  join: products {
    sql_on: ${olr_courses.isbn} = ${products.isbn13} ;;
    relationship: many_to_one
  }

  join: activations_olr {
    sql_on: ${olr_courses.context_id}=${activations_olr.context_id} ;;
    relationship: one_to_many
  }

  join: magellan_hed_entities {
    sql_on: ${activations_olr.entity_no} = ${magellan_hed_entities.entity_no} ;;
    relationship: many_to_one
  }
}

explore: snapshot {
  label: "MindTap - snapshot"

  join:  org {
    sql_on: ${snapshot.org_id} = ${org.id} ;;
    relationship: one_to_one
  }

  join:  node {
    sql_on: ${snapshot.id} = ${node.snapshot_id} ;;
  }

}
