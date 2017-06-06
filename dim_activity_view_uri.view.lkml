view: dim_activity_view_uri {
  label: "Learning Path"
  derived_table: {
    sql:
    with a
    as (
      select
          id
          ,case
            when view_uri like '/static/iloveapps/webvideo%'
              then parse_json(case when check_json(split_part(view_uri, '&data=', 2)) is null then split_part(view_uri, '&data=', 2) end)
            when view_uri like '/mindapp-cxp/take.html?activityPath=IMILAC://imilac:activity:%'
              then parse_url(replace(view_uri, '/mindapp-cxp/take.html?activityPath=IMILAC://imilac:activity:', 'IMILAC://'), 1)
            when view_uri like '/mindapp-cxp/take.html?activityPath=%'
                 or view_uri like 'take.html?activityPath=%'
              then parse_url(
                      replace(replace(
                        case
                        when array_size(split(view_uri, ':')) = 1
                          then 'mindtap://' || view_uri
                        else view_uri
                        end
                  ,'/mindapp-cxp/', ''), 'take.html?activityPath=', '')
               ,1)
            when view_uri like '/static%'
              then parse_url('mindtap://ng.cengage.com' || view_uri)
            when parse_url(view_uri, 1):error is not null
              then parse_url('mindtap://ng.cengage.com' || view_uri)
            else parse_url(replace(trim(view_uri), 'https', 'http'), 1)
            end as parse
            ,view_uri
      from stg_mindtap.activity
      where view_uri is not null
    )
    ,urls as (
      select
          id
          ,case
              --youtube
              when parse:scheme is null then parse_url(html_unescape(parse:src))
              --everything else
              else parse
              end as parsed_url
          ,case when parse:scheme is null then parse end as details
          ,coalesce(parse:path, prod.public.html_unescape(parse:src), parse:host) path
          ,view_uri
      from a
    )
    select
        case
            when parsed_url:scheme = 'http'
            then parsed_url:host::string
            else parsed_url:scheme::string
            end as ContentSource
        ,*
        ,details:details::string as details_inline
        ,replace(details:details, '||', '\n')::string as details_wrapped
    from urls;;
    sql_trigger_value: select count(*) from stg_mindtap.activity ;;
  }

  dimension: id {
    primary_key: yes
    hidden: yes
  }

  dimension: contentsource {
    label: "Content Source"
    type: string
  }

  dimension: details_inline {
    label: "Details (YouTube)"
    sql: ${TABLE}.details_inline ;;
  }

  dimension: view_uri {
    label: "MindTap URI"
    description: "The uri stored in mindtap for this content"
  }

  dimension: details_wrapped {
    hidden: yes
    sql: ${TABLE}.details_wrapped ;;
  }

  dimension: path {
    label: "Link"
    type: string
    html: <a title="{{details_wrapped._value}}" href="{{value}}">{{value}}</a> ;;
  }
}
