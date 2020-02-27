connection: "snowflake_prod"
label:"Experimental / Data Science"

include: "//core/common.lkml"
#include dims model
include: "dims.lkml"
# include all the views
include: "*.view"
