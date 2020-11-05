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

explore: cafe_eventing_client_activity_event{
  label: "CAP_Eventing_Client_Activity"
}

explore:iam_v{
  label: "IAM_Events"
}
explore:ipm_v{
  label: "IPM_Events"
}

explore: fairuse_login_v {
  label: "Fairuse_Login_Events"
}
explore: olr_activations_test_v {
  label: "OLR_ACTIVATIONS"
}
explore: datavault_dataquality_v {
  label: "Datavault_DataQuality"
 }

explore: cafe_eventing_server_activity_event{
  label: "CAP_Eventing_Server_Activity"
}

explore: rental_events_v{
  label: "Rental_events"
}

explore: champions_academy_v{
  label: "Prestige-champions"
}

explore: prestige_bene_v{
  label: "Prestige-bene"
}

explore: prestige_grabber_v{
  label: "Prestige-champions"
}

explore: prestige_hair_design_v{
  label: "Prestige-hair_design"
}

explore: prestige_salon_v{
  label: "Prestige-salon"
}

explore: prestige_victorias_v{
  label: "Prestige-victorias"
}
