- dashboard: instructor_activity_status
  title: 'Instructor: Activity Status'
  layout: newspaper
  elements:
  - name: 'HOW TO USE THIS DASHBOARD:'
    type: text
    title_text: 'HOW TO USE THIS DASHBOARD:'
    subtitle_text: ''
    body_text: |-
      1) Find the template dashboard most appropriate for the identified need

      2) Click the 3 vertical dots and select “Explore from here” (right click to ensure it opens in a new browser tab)

      3) Update filters as desired

      4) Save updated looks and/or download tables to Excel
    row: 0
    col: 18
    width: 6
    height: 8
  - name: NOTES
    type: text
    title_text: NOTES
    body_text: |-
      1) Data is based on the number or courses, so if 10% of the ACTIVITY TYPE "Section Quiz" is "graded", this means 10% of ALL Section Quizzes across ALL courses are set to Gradable.

      2) Graphs assume that the user knows the default setting of a given activity/activity type.

      3) Chapter 0 includes all "getting started"-like activities.  Chapter 98 includes all unit-level activities not tied to a specific chapter.  Chapter 99 includes all Appendix activities.

      4) Data is updated nightly, but has a 24+ hour delay (meaning, if you are looking on 8/10, data for 8/8 will be available, but data for 8/9 will NOT be available).

      5) Activations tables are being updated; figures may move up or down a couple percentage points but should not impact analysis.
    row: 0
    col: 12
    width: 6
    height: 8
  - title: Usage Data Template - Overview
    name: Usage Data Template - Overview
    model: cube
    explore: fact_activation
    type: looker_single_record
    fields:
    - dim_product.productfamily
    - dim_product.edition
    - product_facts.product_users
    - fact_activation.user_count
    - fact_activation.total_noofactivations
    - product_facts.activations_for_isbn
    - fact_activation.course_count
    - fact_activation.institution_count
    filters:
      dim_institution.HED_filter: 'Yes'
      dim_filter.is_external: 'Yes'
      dim_party.is_external: 'Yes'
      dim_start_date.fiscalyear: FY17
      dim_institution.country: UNITED STATES
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
    sorts:
    - product_facts.product_users desc
    limit: 500
    column_limit: 50
    show_view_names: true
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields:
    - product_facts.activations_for_isbn
    listen:
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    row: 0
    col: 0
    width: 6
    height: 8
  - title: Activity Type Overall
    name: Activity Type Overall
    model: cube
    explore: fact_activity
    type: looker_bar
    fields:
    - mindtap_lp_activity_tags.total_activity_activations
    - dim_activity.status
    - mindtap_lp_activity_tags.Concat_activity_sub_type
    pivots:
    - dim_activity.status
    filters:
      dim_institution.HED_filter: 'Yes'
      dim_filter.is_external: 'Yes'
      mindtap_lp_activity_tags.activity_type: ''
      dim_learningpath.learningtype: Activity
      dim_activity.status: ''
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
      course_section_facts.course_count: ">0"
    sorts:
    - dim_activity.status 0
    - mindtap_lp_activity_tags.Concat_activity_sub_type desc
    limit: 1000
    column_limit: 50
    stacking: percent
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: []
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    x_axis_label: Activity Type
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#409da0"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    series_colors:
      Unassigned - mindtap_lp_activity_tags.total_activity_activations: "#8b370b"
      Graded - mindtap_lp_activity_tags.total_activity_activations: "#1f7ad2"
    listen:
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    note_state: collapsed
    note_display: above
    note_text: Address question "How many activities of a given activity type across
      ALL courses at ALL Universities are set to a given status?"
    row: 8
    col: 0
    width: 24
    height: 11
  - title: Specific University
    name: Specific University
    model: cube
    explore: fact_activity
    type: looker_bar
    fields:
    - mindtap_lp_activity_tags.activity_type
    - mindtap_lp_activity_tags.total_activity_activations
    - dim_activity.status
    pivots:
    - dim_activity.status
    filters:
      dim_institution.HED_filter: 'Yes'
      dim_filter.is_external: 'Yes'
      dim_learningpath.learningtype: Activity
      dim_activity.status: ''
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
      course_section_facts.course_count: ">0"
    sorts:
    - dim_activity.status 0
    - mindtap_lp_activity_tags.total_activity_activations desc 0
    limit: 1000
    column_limit: 50
    total: true
    stacking: percent
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: []
    series_colors:
      Unassigned - mindtap_lp_activity_tags.total_activity_activations: "#8b370b"
      Graded - mindtap_lp_activity_tags.total_activity_activations: "#1f7ad2"
    listen:
      University Name: dim_institution.institutionname
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    note_state: expanded
    note_display: above
    note_text: |-
      Address question "How many activities of a given activity type across ALL courses at a SPECIFIC University are set to a given status?"

      * University Filter can be applied
    row: 19
    col: 0
    width: 12
    height: 10
  - title: University Level Breakdown
    name: University Level Breakdown
    model: cube
    explore: fact_activity
    type: looker_bar
    fields:
    - mindtap_lp_activity_tags.total_activity_activations
    - dim_activity.status
    - dim_institution.institutionname
    pivots:
    - dim_activity.status
    filters:
      dim_institution.HED_filter: 'Yes'
      dim_filter.is_external: 'Yes'
      dim_learningpath.learningtype: Activity
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
      course_section_facts.course_count: ">0"
    sorts:
    - dim_activity.status 0
    - mindtap_lp_activity_tags.total_activity_activations desc 0
    limit: 1000
    column_limit: 50
    stacking: percent
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: []
    x_axis_label_rotation_bar: 0
    series_colors:
      Unassigned - mindtap_lp_activity_tags.total_activity_activations: "#8b370b"
      Graded - mindtap_lp_activity_tags.total_activity_activations: "#1f7ad2"
    listen:
      Activity Type: mindtap_lp_activity_tags.activity_type
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    note_state: expanded
    note_display: above
    note_text: |-
      Address question "How many activities of a SPECIFIC activity type across ALL courses at ALL Universities are set to a given status?"

      * Activity Type Filter applies
    row: 19
    col: 12
    width: 12
    height: 10
  - title: By Chapter
    name: By Chapter
    model: cube
    explore: fact_activity
    type: looker_bar
    fields:
    - mindtap_lp_activity_tags.chapter
    - mindtap_lp_activity_tags.total_activity_activations
    - dim_activity.status
    pivots:
    - dim_activity.status
    filters:
      dim_institution.HED_filter: 'Yes'
      dim_filter.is_external: 'Yes'
      mindtap_lp_activity_tags.chapter: NOT NULL
      dim_learningpath.learningtype: Activity
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
      course_section_facts.course_count: ">0"
    sorts:
    - dim_activity.status 0
    - mindtap_lp_activity_tags.chapter
    limit: 1000
    column_limit: 50
    total: true
    stacking: percent
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
    interpolation: linear
    value_labels: legend
    label_type: labPer
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: []
    series_colors:
      Unassigned - mindtap_lp_activity_tags.total_activity_activations: "#8b370b"
      Graded - mindtap_lp_activity_tags.total_activity_activations: "#1f7ad2"
    listen:
      Activity Type: mindtap_lp_activity_tags.activity_type
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    note_state: expanded
    note_display: above
    note_text: |-
      Address question "How many activities within a given CHAPTER across ALL courses at ALL Universities are set to a given status?"

      * Activity Type Filter can be applied
    row: 29
    col: 0
    width: 12
    height: 12
  - title: Chapter Usage By University
    name: Chapter Usage By University
    model: cube
    explore: fact_activity
    type: looker_bar
    fields:
    - mindtap_lp_activity_tags.total_activity_activations
    - dim_activity.status
    - mindtap_lp_activity_tags.chapter
    pivots:
    - dim_activity.status
    filters:
      dim_institution.HED_filter: 'Yes'
      dim_filter.is_external: 'Yes'
      mindtap_lp_activity_tags.chapter: NOT NULL
      dim_learningpath.learningtype: Activity
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
      course_section_facts.course_count: ">0"
    sorts:
    - dim_activity.status 0
    - mindtap_lp_activity_tags.chapter
    limit: 1000
    column_limit: 50
    total: true
    stacking: percent
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: []
    series_colors:
      Unassigned - mindtap_lp_activity_tags.total_activity_activations: "#8b370b"
      Graded - mindtap_lp_activity_tags.total_activity_activations: "#1f7ad2"
    listen:
      University Name: dim_institution.institutionname
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    note_state: expanded
    note_display: above
    note_text: |-
      Address question "How many activities within a given CHAPTER at a SPECIFIC University are set to a given status?"

      * University Filter can be applied
    row: 29
    col: 12
    width: 12
    height: 12
  - title: "# Activity Groups"
    name: "# Activity Groups"
    model: cube
    explore: fact_activity
    type: table
    fields:
    - mindtap_lp_activity_tags.activity_type
    - mindtap_lp_activity_tags.learning_path_activity_title_count
    filters:
      dim_institution.HED_filter: 'Yes'
      dim_filter.is_external: 'Yes'
      mindtap_lp_activity_tags.activity_type: "-NULL"
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
    sorts:
    - mindtap_lp_activity_tags.activity_type
    limit: 500
    column_limit: 50
    total: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: normal
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map: usa
    map_projection: ''
    quantize_colors: false
    barColors:
    - red
    - blue
    groupBars: true
    labelSize: 10pt
    showLegend: true
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    font_size: '12'
    series_types: {}
    hidden_fields: []
    x_axis_reversed: false
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: false
      showValues: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: mindtap_lp_activity_tags.learning_path_activity_title_count
        name: 'Learning Path # Activities (unique from external tagging)'
        axisId: mindtap_lp_activity_tags.learning_path_activity_title_count
    hidden_series:
    - calculation_1
    listen:
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    row: 0
    col: 6
    width: 6
    height: 8
  filters:
  - name: Activity Type
    title: Activity Type
    type: field_filter
    default_value: ''
    model: cube
    explore: fact_activity
    field: mindtap_lp_activity_tags.activity_type
    listens_to_filters: []
    allow_multiple_values: true
    required: false
  - name: University Name
    title: University Name
    type: field_filter
    default_value: ''
    model: cube
    explore: fact_activity
    field: dim_institution.institutionname
    listens_to_filters: []
    allow_multiple_values: true
    required: false
  - name: Product Family + Edition
    title: Product Family + Edition
    type: field_filter
    default_value: Kearney/Abnormal Psychology & - 003
    model: cube
    explore: fact_activity
    field: dim_product.productfamily_edition
    listens_to_filters: []
    allow_multiple_values: true
    required: false
  - name: Fiscal Year
    title: Fiscal Year
    type: field_filter
    default_value: FY17
    model: cube
    explore: fact_activity
    field: dim_start_date.fiscalyear
    listens_to_filters: []
    allow_multiple_values: true
    required: false
