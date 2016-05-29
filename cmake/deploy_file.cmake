# 
# deploy_file:
#
#  IN = Source file
#  OUTDIR = Output path


#get_filename_component(outdir
#    ${OUT}
#    PATH)
#
#get_filename_component(outname
#    ${OUT}
#    NAME)

message(STATUS "Deploy ${IN} to ${OUTDIR}")

file(COPY
    "${IN}"
    DESTINATION
    "${OUTDIR}")

