# 
# deploy_file:
#
#  IN = Source file
#  OUT = Output path


get_filename_component(outdir
    ${OUT}
    PATH)

get_filename_component(outname
    ${OUT}
    NAME)

message(STATUS "Deploy ${IN} to ${outdir} as ${outname}")

file(INSTALL
    "${IN}"
    RENAME
    ${outname}
    DESTINATION
    "${outdir}")

