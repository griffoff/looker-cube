view: dim_iframeapplication {
  label: "App Dock"
  #sql_table_name: DW_GA.DIM_IFRAMEAPPLICATION ;;
  derived_table: {
    sql:
        WITH apps AS (
          SELECT
            DISTINCT
            f.iframeapplicationid AS id
            ,iframeapplicationname AS name
            ,displayname
            ,split_part(replace(iframeapplicationname, ' '), '...SHIFT+R', 0) AS matchname
            ,split_part(iframeapplicationname, '... SHIFT+R', 0) AS matchname2
                ,cnt
              FROM dw_ga.dim_iframeapplication f
              INNER JOIN (SELECT iframeapplicationid, count(*) AS cnt FROM dw_ga.fact_appusage GROUP BY 1) a ON f.iframeapplicationid = a.iframeapplicationid
            )
            ,ranks AS (
              SELECT matchname, displayname, name, RANK() OVER (PARTITION BY matchname ORDER BY cnt DESC) AS RANK
              FROM apps
            )
            ,names as (
              SELECT
                  DISTINCT b.id, Replace(InitCap(COALESCE(a.displayname, b.displayname, a.name, b.name)), '_', ' ') AS displayname
              FROM apps b
              left JOIN ranks a ON a.matchname = b.matchname
                        AND a.RANK = 1
            )
            select
                max(iframeapplicationid) over (partition by n.displayname) as iframeapplicationid_group
                ,a.*
                ,n.displayname as bestdisplayname
                ,REPLACE(REPLACE(REPLACE(REPLACE(a.IFRAMEAPPLICATIONNAME, '_', ' '), 'LAUNCH', ''), 'VIEW', ''), 'FLASH CARDS', 'FLASHCARDS') as CleanedApplicationName
            from DW_GA.DIM_IFRAMEAPPLICATION a
            inner join names n on a.iframeapplicationid = n.id
    ;;

    sql_trigger_value: select count(*) from DW_GA.dim_iframeapplication ;;
  }

  dimension: displayname {
    label: "Display Name"
    type: string
    #sql: COALESCE(${TABLE}.DISPLAYNAME, ${iframeapplicationname}) ;;
    sql: COALESCE(${TABLE}.BESTDISPLAYNAME, ${iframeapplicationname}) ;;
    link: {
      label: "MindApp details on Inside"
      url: "http://inside/sites/DevOps/SitePages/{{ value }}.aspx"
    }
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension_group: dw_ldts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: iframeapplicationid_group {
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID_GROUP ;;
    hidden: yes
  }

  dimension: iframeapplicationid {
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: iframeapplicationname {
    label: "Application Name"
    type: string
    sql: ${TABLE}.CleanedApplicationName ;;
    link: {
      label: "MindApp details on Inside"
      url: "http://inside/sites/DevOps/SitePages/{{ value }}.aspx"
    }
  }

  measure: count {
    label: "# apps"
    type: count
    drill_fields: [iframeapplicationname, displayname]
  }
}
