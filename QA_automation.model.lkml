include: "//project_source/*.view.lkml"
connection: "snowflake_prod"
label:"QA-DATAPROFILING"

include: "*.view.lkml"

explore: json_testreports_v {
  label: "QA Automation Reports"

}
explore: sap_subscription_v{
  label: "Sap_Subscription"
}

explore: ebook_usage_v{
  label: "EBook_Usage"
}

explore: cap_eventing_test_v {
  label: "CAP_Eventing"
}
