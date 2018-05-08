connection: "snowflake_uploads"

include: "/core/common.lkml"
include: "/core/fivetran.view"

include: "UPLOADS.fivetran_audit.view.lkml"         # include all views in this project

explore: fivetran_audit{}
