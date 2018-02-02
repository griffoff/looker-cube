# If necessary, uncomment the line below to include explore_source.
# include: "source.model.lkml"

view: flat_studentinteractions_4m_ga {
  derived_table: {
    explore_source: ga_data_parsed {
      column: userssoguid {}
      column: coursekey {}
      column: activitybuilder_launch_sum {}
      column: alg_launch_sum {}
      column: aplia_launch_sum {}
      column: apliamobile_launch_sum {}
      column: assessment_activity_launch_sum {}
      column: assessment_activity_started_sum {}
      column: assessment_activity_submitted_sum {}
      column: assessment_activity_sum {}
      column: assessment_launch_sum {}
      column: assessment_activity_view_sum {}
      column: assessment_view_sum {}
      column: assignment_launch_sum {}
      column: assignment_learning_burst_launch_sum {}
      column: atp_launch_sum {}
      column: blog_launch_sum {}
      column: bookmarks_create_sum {}
      column: bookmarks_launch_sum {}
      column: cerego_launch_sum {}
      column: chemistryreference_launch_sum {}
      column: class_skills_launch_sum {}
      column: cnowhw_launch_sum {}
      column: cnowhw_preclass_ilrn_com_launch_sum {}
      column: composition_launch_sum {}
      column: concept_map_interacted_sum {}
      column: concept_map_sum {}
      column: conceptmap_activity_launch_sum {}
      column: conceptmap_app_launch_sum {}
      column: conceptmap_launch_sum {}
      column: connectyardlearner_launch_sum {}
      column: create_glossary_show_sum {}
      column: dashboard_navigation_sum {}
      column: dictionary_launch_sum {}
      column: diet_analysis_plus_launch_sum {}
      column: diet_wellnes_plus_launch_sum {}
      column: dlappdock_techconnections_launch_sum {}
      column: dlmt_iq_instructortestcreator_launch_sum {}
      column: dlmt_iq_launch_sum {}
      column: dlmt_iq_studenttestcreator_launch_sum {}
      column: everNote_Launch_sum {}
      column: everNoteMobile_Launch_sum {}
      column: exerciseset_launch_sum {}
      column: exerciseset_learning_burst_launch_sum {}
      column: faq_launch_sum {}
      column: flashcards_activity_launch_sum {}
      column: flashcards_launch_sum {}
      column: flashcards_view_sum {}
      column: flashnotes_Launch_sum {}
      column: flashnotesCEO_Launch_sum {}
      column: flashnotesQAD_Launch_sum {}
      column: glossary_sum {}
      column: game_learning_burst_launch_sum {}
      column: gameactivity_launch_sum {}
      column: generated_folder_activity_sum {}
      column: glossary_launch_sum {}
      column: glossary_show_sum1 {}
      column: glossary_show_sum2 {}
      column: glossary_view_sum {}
      column: google_docs_launch_sum3 {}
      column: googledoc_launch_sum1 {}
      column: googledocs_activity_launch_sum {}
      column: googledocs_launch_sum {}
      column: googledocs_launch_sum2 {}
      column: gradebook_launch_sum {}
      column: gradebook_launches_sum {}
      column: highlights_create_sum {}
      column: highlights_launch_sum {}
      column: history_conceptmapactivity_launch_sum {}
      column: homework_activity_launch_sum {}
      column: homework_activity_view_sum {}
      column: homework_launch_sum {}
      column: homework_started_sum {}
      column: homework_submitted_sum {}
      column: homework_sum {}
      column: homework_view_sum {}
      column: inapppurchase_launch_sum {}
      column: insite_launch_sum {}
      column: kaltura_launch_sum {}
      column: lams_launch_sum {}
      column: lams_v2_launch_sum {}
      column: media_activity_launch_sum {}
      column: media_sum {}
      column: mediaquiz_activity_launch_sum {}
      column: mediaquiz_learning_burst_launch_sum {}
      column: messagecenter_launch_sum {}
      column: messagecenter_message_sent_sum {}
      column: messagecenter_preferences_changed_sum {}
      column: milady_launch_sum {}
      column: milady_procedural_tracker_launch_sum {}
      column: mindapp_ab_launch_sum {}
      column: mindapp_eportfolio_launch_sum {}
      column: mindapp_grove_launch_sum {}
      column: mindapp_office_365_launch_sum {}
      column: mindapp_resource_viewer_launch_sum {}
      column: mindappscenario_launch_sum {}
      column: mindtap_instructor_resourcecenter_launch_sum {}
      column: mtstudycentermindapp_launch_sum {}
      column: mynotes_launch_sum {}
      column: nettutor6_launch_sum {}
      column: nettutorlti_launch_sum {}
      column: notepad_launch_sum {}
      column: onedrive_launch_sum {}
      column: onenote_launch_sum {}
      column: other_activity_launch_sum {}
      column: other_activity_submitted_sum {}
      column: other_activity_view_sum {}
      column: other_launch_sum {}
      column: outcome_management_launch_sum {}
      column: outline_composition_launch_sum {}
      column: outlinespeech_launch_sum {}
      column: polling_launch_sum {}
      column: pred_reportactivity_launch_sum {}
      column: profile_plus_launch_sum {}
      column: progress_launch_sum {}
      column: questia_launch_sum {}
      column: quicknote_create_sum {}
      column: quicknote_launch_sum {}
      column: quiz_launch_sum {}
      column: reading_activity_launch_sum {}
      column: reading_activity_sum {}
      column: reading_activity_view_sum {}
      column: reading_Launch_sum {}
      column: reading_view_sum {}
      column: readspeaker_launch_sum {}
      column: readspeaker1_launch_sum {}
      column: readspeaker3_launch_sum {}
      column: rssfeed_activity_launch_sum {}
      column: rssfeed_launch_sum {}
      column: sam_appification_prod_launch_sum {}
      column: search_launched_sum {}
      column: search_performed_sum {}
      column: speechvideolibraryprod_launch_sum {}
      column: studycenter_launch_sum {}
      column: studyguide_activity_launch_sum {}
      column: studyguide_activity_view_sum {}
      column: studyguide_launch_sum {}
      column: studyguide_launch_sum1 {}
      column: studyguide_sum {}
      column: studyhubmindapp_launch_sum {}
      column: studyhubmt4_launch_sum {}
      column: system_interacted_sum {}
      column: systemcheck_launch_sum {}
      column: systemsetup_interacted_sum {}
      column: textsnippet_learning_burst_launch_sum {}
      column: time_in_mindtap_avg {}
      column: time_in_mindtap_sum {}
      column: total_session_time_sum {}
      column: videocapture_launch_sum {}
      column: wac_launch_sum {}
      column: webassignbspage_launch_sum {}
      column: weblinks_activity_launch_sum {}
      column: weblinks_launch_sum {}
      column: youseeu_launch_sum {}
      column: localtime_timestamp_tz_time {}
      column: coretextisbn {}
    }

    sql_trigger_value: select count(*) from raw_ga.ga_data_parsed ;;
  }
  dimension: userssoguid {}
  dimension: coursekey {}
  dimension: activitybuilder_launch_sum {
    type: number
  }
  dimension: alg_launch_sum {
    type: number
  }
  dimension: aplia_launch_sum {
    type: number
  }
  dimension: apliamobile_launch_sum {
    type: number
  }
  dimension: assessment_activity_launch_sum {
    type: number
  }
  dimension: assessment_activity_started_sum {
    type: number
  }
  dimension: assessment_activity_submitted_sum {
    type: number
  }
  dimension: assessment_activity_sum {
    type: number
  }
  dimension: assessment_launch_sum {
    type: number
  }
  dimension: assessment_activity_view_sum {
    type: number
  }
  dimension: assessment_view_sum {
    type: number
  }
  dimension: assignment_launch_sum {
    type: number
  }
  dimension: assignment_learning_burst_launch_sum {
    type: number
  }
  dimension: atp_launch_sum {
    type: number
  }
  dimension: blog_launch_sum {
    type: number
  }
  dimension: bookmarks_create_sum {
    type: number
  }
  dimension: bookmarks_launch_sum {
    type: number
  }
  dimension: cerego_launch_sum {
    type: number
  }
  dimension: chemistryreference_launch_sum {
    type: number
  }
  dimension: class_skills_launch_sum {
    type: number
  }
  dimension: cnowhw_launch_sum {
    type: number
  }
  dimension: cnowhw_preclass_ilrn_com_launch_sum {
    type: number
  }
  dimension: composition_launch_sum {
    type: number
  }
  dimension: concept_map_interacted_sum {
    type: number
  }
  dimension: concept_map_sum {
    type: number
  }
  dimension: conceptmap_activity_launch_sum {
    type: number
  }
  dimension: conceptmap_app_launch_sum {
    type: number
  }
  dimension: conceptmap_launch_sum {
    type: number
  }
  dimension: connectyardlearner_launch_sum {
    type: number
  }
  dimension: create_glossary_show_sum {
    type: number
  }
  dimension: dashboard_navigation_sum {
    type: number
  }
  dimension: dictionary_launch_sum {
    type: number
  }
  dimension: diet_analysis_plus_launch_sum {
    type: number
  }
  dimension: diet_wellnes_plus_launch_sum {
    type: number
  }
  dimension: dlappdock_techconnections_launch_sum {
    type: number
  }
  dimension: dlmt_iq_instructortestcreator_launch_sum {
    type: number
  }
  dimension: dlmt_iq_launch_sum {
    type: number
  }
  dimension: dlmt_iq_studenttestcreator_launch_sum {
    type: number
  }
  dimension: everNote_Launch_sum {
    type: number
  }
  dimension: everNoteMobile_Launch_sum {
    type: number
  }
  dimension: exerciseset_launch_sum {
    type: number
  }
  dimension: exerciseset_learning_burst_launch_sum {
    type: number
  }
  dimension: faq_launch_sum {
    type: number
  }
  dimension: flashcards_activity_launch_sum {
    type: number
  }
  dimension: flashcards_launch_sum {
    type: number
  }
  dimension: flashcards_view_sum {
    type: number
  }
  dimension: flashnotes_Launch_sum {
    type: number
  }
  dimension: flashnotesCEO_Launch_sum {
    type: number
  }
  dimension: flashnotesQAD_Launch_sum {
    type: number
  }
  dimension: glossary_sum {
    type: number
  }
  dimension: game_learning_burst_launch_sum {
    type: number
  }
  dimension: gameactivity_launch_sum {
    type: number
  }
  dimension: generated_folder_activity_sum {
    type: number
  }
  dimension: glossary_launch_sum {
    type: number
  }
  dimension: glossary_show_sum1 {
    type: number
  }
  dimension: glossary_show_sum2 {
    type: number
  }
  dimension: glossary_view_sum {
    type: number
  }
  dimension: google_docs_launch_sum3 {
    type: number
  }
  dimension: googledoc_launch_sum1 {
    type: number
  }
  dimension: googledocs_activity_launch_sum {
    type: number
  }
  dimension: googledocs_launch_sum {
    type: number
  }
  dimension: googledocs_launch_sum2 {
    type: number
  }
  dimension: gradebook_launch_sum {
    type: number
  }
  dimension: gradebook_launches_sum {
    type: number
  }
  dimension: highlights_create_sum {
    type: number
  }
  dimension: highlights_launch_sum {
    type: number
  }
  dimension: history_conceptmapactivity_launch_sum {
    type: number
  }
  dimension: homework_activity_launch_sum {
    type: number
  }
  dimension: homework_activity_view_sum {
    type: number
  }
  dimension: homework_launch_sum {
    type: number
  }
  dimension: homework_started_sum {
    type: number
  }
  dimension: homework_submitted_sum {
    type: number
  }
  dimension: homework_sum {
    type: number
  }
  dimension: homework_view_sum {
    type: number
  }
  dimension: inapppurchase_launch_sum {
    type: number
  }
  dimension: insite_launch_sum {
    type: number
  }
  dimension: kaltura_launch_sum {
    type: number
  }
  dimension: lams_launch_sum {
    type: number
  }
  dimension: lams_v2_launch_sum {
    type: number
  }
  dimension: media_activity_launch_sum {
    type: number
  }
  dimension: media_sum {
    type: number
  }
  dimension: mediaquiz_activity_launch_sum {
    type: number
  }
  dimension: mediaquiz_learning_burst_launch_sum {
    type: number
  }
  dimension: messagecenter_launch_sum {
    type: number
  }
  dimension: messagecenter_message_sent_sum {
    type: number
  }
  dimension: messagecenter_preferences_changed_sum {
    type: number
  }
  dimension: milady_launch_sum {
    type: number
  }
  dimension: milady_procedural_tracker_launch_sum {
    type: number
  }
  dimension: mindapp_ab_launch_sum {
    type: number
  }
  dimension: mindapp_eportfolio_launch_sum {
    type: number
  }
  dimension: mindapp_grove_launch_sum {
    type: number
  }
  dimension: mindapp_office_365_launch_sum {
    type: number
  }
  dimension: mindapp_resource_viewer_launch_sum {
    type: number
  }
  dimension: mindappscenario_launch_sum {
    type: number
  }
  dimension: mindtap_instructor_resourcecenter_launch_sum {
    type: number
  }
  dimension: mtstudycentermindapp_launch_sum {
    type: number
  }
  dimension: mynotes_launch_sum {
    type: number
  }
  dimension: nettutor6_launch_sum {
    type: number
  }
  dimension: nettutorlti_launch_sum {
    type: number
  }
  dimension: notepad_launch_sum {
    type: number
  }
  dimension: onedrive_launch_sum {
    type: number
  }
  dimension: onenote_launch_sum {
    type: number
  }
  dimension: other_activity_launch_sum {
    type: number
  }
  dimension: other_activity_submitted_sum {
    type: number
  }
  dimension: other_activity_view_sum {
    type: number
  }
  dimension: other_launch_sum {
    type: number
  }
  dimension: outcome_management_launch_sum {
    type: number
  }
  dimension: outline_composition_launch_sum {
    type: number
  }
  dimension: outlinespeech_launch_sum {
    type: number
  }
  dimension: polling_launch_sum {
    type: number
  }
  dimension: pred_reportactivity_launch_sum {
    type: number
  }
  dimension: profile_plus_launch_sum {
    type: number
  }
  dimension: progress_launch_sum {
    type: number
  }
  dimension: questia_launch_sum {
    type: number
  }
  dimension: quicknote_create_sum {
    type: number
  }
  dimension: quicknote_launch_sum {
    type: number
  }
  dimension: quiz_launch_sum {
    type: number
  }
  dimension: reading_activity_launch_sum {
    type: number
  }
  dimension: reading_activity_sum {
    type: number
  }
  dimension: reading_activity_view_sum {
    type: number
  }
  dimension: reading_Launch_sum {
    type: number
  }
  dimension: reading_view_sum {
    type: number
  }
  dimension: readspeaker_launch_sum {
    type: number
  }
  dimension: readspeaker1_launch_sum {
    type: number
  }
  dimension: readspeaker3_launch_sum {
    type: number
  }
  dimension: rssfeed_activity_launch_sum {
    type: number
  }
  dimension: rssfeed_launch_sum {
    type: number
  }
  dimension: sam_appification_prod_launch_sum {
    type: number
  }
  dimension: search_launched_sum {
    type: number
  }
  dimension: search_performed_sum {
    type: number
  }
  dimension: speechvideolibraryprod_launch_sum {
    type: number
  }
  dimension: studycenter_launch_sum {
    type: number
  }
  dimension: studyguide_activity_launch_sum {
    type: number
  }
  dimension: studyguide_activity_view_sum {
    type: number
  }
  dimension: studyguide_launch_sum {
    type: number
  }
  dimension: studyguide_launch_sum1 {
    type: number
  }
  dimension: studyguide_sum {
    type: number
  }
  dimension: studyhubmindapp_launch_sum {
    type: number
  }
  dimension: studyhubmt4_launch_sum {
    type: number
  }
  dimension: system_interacted_sum {
    type: number
  }
  dimension: systemcheck_launch_sum {
    type: number
  }
  dimension: systemsetup_interacted_sum {
    type: number
  }
  dimension: textsnippet_learning_burst_launch_sum {
    type: number
  }
  dimension: time_in_mindtap_avg {
    value_format: "hh:mm:ss"
    type: number
  }
  dimension: time_in_mindtap_sum {
    value_format: "hh:mm:ss"
    type: number
  }
  dimension: total_session_time_sum {
    value_format: "hh:mm:ss"
    type: number
  }
  dimension: videocapture_launch_sum {
    type: number
  }
  dimension: wac_launch_sum {
    type: number
  }
  dimension: webassignbspage_launch_sum {
    type: number
  }
  dimension: weblinks_activity_launch_sum {
    type: number
  }
  dimension: weblinks_launch_sum {
    type: number
  }
  dimension: youseeu_launch_sum {
    type: number
  }
  dimension: localtime_timestamp_tz_time {
    label: "Ga Data Parsed  Time"
    type: date_time
  }
  dimension: coretextisbn {}
}
