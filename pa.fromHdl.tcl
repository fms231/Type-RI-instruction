
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name ri -dir "D:/zuchengyuanli/ri/planAhead_run_1" -part xc7a100tfgg484-2L
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/Inst_code.ngc}]
add_files [list {ipcore_dir/RAM_B.ngc}]
set hdlfile [add_files [list {ipcore_dir/RAM_B.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/Inst_code.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top top $srcset
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/Inst_code.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/RAM_B.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tfgg484-2L
