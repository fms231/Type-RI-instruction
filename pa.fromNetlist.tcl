
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name ri -dir "D:/zuchengyuanli/ri/planAhead_run_2" -part xc7a100tfgg484-2L
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/zuchengyuanli/ri/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/zuchengyuanli/ri} {ipcore_dir} }
add_files [list {ipcore_dir/Inst_code.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/RAM_B.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
link_design
