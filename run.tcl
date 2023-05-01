if {[file exists work]} {
    exec rm -rf work
}
exec mkdir work
cd work

exec xvlog -sv -f ../compile_sv.f -L uvm ; 

set NoQuitOnFinish 1

exec xelab top -relax -s top -timescale 1ns/1ps ;  
exec xsim top -testplusarg UVM_TESTNAME=verbose_test -testplusarg UVM_VERBOSITY=UVM_FULL -runall
exec xcrg -report_format html -dir ./xsim.covdb/ -report_dir ./coverage