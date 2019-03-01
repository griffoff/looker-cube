include: "//core/fivetran.view"
view: fivetran_audit {
  extends: [fivetran_audit_base]
  label: "FiveTran Sync Audit"
#  sql_table_name: MT_NB.FIVETRAN_AUDIT ;;
  derived_table: {
    sql:
      with audit as (
          SELECT * FROM BUDGETS.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM GOOGLE_SHEETS.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM HR.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM HR3DREVIEWS.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM LEARNINGPATH_METADATA.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM LEARNINGPATH_METADATA2.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM WL_METADATA_ATELIER_MASTER.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM WL_METADATA_HORIZONS_MASTER.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM WL_METADATA_JUNTOS_MASTER.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM WL_METADATA_PLAZAS_MASTER.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM WL_METADATA_RUTAS_MASTER.FIVETRAN_AUDIT
          UNION ALL
          SELECT * FROM ZDN.FIVETRAN_AUDIT
      )
    select
        *
        ,row_number() over (partition by "TABLE" order by "START") as update_no
        ,case when lead(done) over(partition by schema, "TABLE" order by done) is null then True end as latest
        ,convert_timezone('EST', min("START") over (partition by update_id)) as update_start_time
        ,convert_timezone('EST', max(done) over (partition by update_id)) as update_finish_time
     from audit
      ;;
  }

  dimension: update_start_time {
    hidden: no
  }

  dimension: update_finish_time {
    hidden: no
  }

  dimension: initial_sync {
    hidden:no
  }

  measure: latest_rows_updated_or_inserted {
    hidden: no
  }

}
