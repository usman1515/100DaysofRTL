# 100DaysOfRTL Root
100DaysOfRTL_ROOT = $(realpath .)


# ============================================================================= ARGS
ip :=

# ---------------------------------------- GHDL
# FLAGS_GHDL	:= --std=87
FLAGS_GHDL	+= --std=93
# FLAGS_GHDL	:= --std=02
# FLAGS_GHDL	:= --std=08
# FLAGS_GHDL	:= --std=19
FLAGS_GHDL	+= -fexplicit -frelaxed-rules --syn-binding
wave 		:= tb_$(ip)
end_sim 	:= 100ns

# ---------------------------------------- IVERILOG
FLAGS_IVERILOG	+= -Wall -Winfloop -gno-shared-loop-index -g2012
vvp 			:= tb_$(ip)

# ---------------------------------------- YOSYS
file_yosys		:= yosys_$(ip)
file_netlist	:= netlist_$(ip)
rtl_top			:= $(ip)
path_yosys_file	:= $(ip)/$(file_yosys).ys

# ============================================================================= TARGETS

sim_vhdl:
	@ echo " "
	@ echo -------------------- Compiling VHDL ${ip} RTL -----------------------
	@ cd $(ip); \
		ghdl -a $(FLAGS_GHDL) $(ip).vhd; \
		ghdl -a $(FLAGS_GHDL) tb_$(ip).vhd; \
		ghdl -e $(FLAGS_GHDL) tb_$(ip); \
		ghdl -r $(FLAGS_GHDL) tb_$(ip) \
		--vcd=$(wave).vcd --stop-time=$(end_sim)
	@ echo ------------------------------------ DONE ------------------------------------
	@ echo " "

sim_verilog:
	@ echo " "
	@ echo ----------------------- Compiling Verilog ${ip} RTL -----------------------
	@ cd $(ip); \
		iverilog $(FLAGS_IVERILOG) $(ip).sv tb_$(ip).sv \
		-o $(vvp).vvp; \
		vvp $(vvp).vvp
	@ echo ------------------------------------ DONE ------------------------------------
	@ echo " "

synth:
	@ echo " "
	@ echo ---------------------- Synthesizing $(ip) RTL ---------------------
	@ touch $(ip)/$(file_yosys).ys
	@ echo "# ----- reading design file"		>> $(path_yosys_file)
	@ echo "read -sv $(ip)/$(rtl_top).sv"		>> $(path_yosys_file)
	@ echo "# ----- elaborate design hierarchy"	>> $(path_yosys_file)
	@ echo "hierarchy -check -auto-top"			>> $(path_yosys_file)
	@ echo "# ----- coarse synthesis"			>> $(path_yosys_file)
	@ echo "flatten" 							>> $(path_yosys_file)
	@ echo "proc; opt_expr; opt_clean"			>> $(path_yosys_file)
	@ echo "check; opt -nodffe -nosdff" 		>> $(path_yosys_file)
	@ echo "fsm; opt"							>> $(path_yosys_file)
	@ echo "wreduce"							>> $(path_yosys_file)
	@ echo "peepopt; opt_clean" 				>> $(path_yosys_file)
	@ echo "techmap" 							>> $(path_yosys_file)
	@ echo "alumacc" 							>> $(path_yosys_file)
	@ echo "share; opt" 						>> $(path_yosys_file)
	@ echo "memory -nomap; opt_clean"			>> $(path_yosys_file)
	@ echo "# ----- fine synthesis"				>> $(path_yosys_file)
	@ echo "opt -fast -full" 					>> $(path_yosys_file)
	@ echo "memory_map; opt -full" 				>> $(path_yosys_file)
	@ echo "techmap; opt -fast" 				>> $(path_yosys_file)
	@ echo "abc -fast; opt -fast" 				>> $(path_yosys_file)
	@ echo "# ----- check"						>> $(path_yosys_file)
	@ echo "clean" 								>> $(path_yosys_file)
	@ echo "# ----- write netlist as verilog"			>> $(path_yosys_file)
	@ echo "write_verilog $(ip)/$(file_netlist).v"		>> $(path_yosys_file)
	@ echo "# ----- write netlist to new json file"		>> $(path_yosys_file)
	@ echo "json -aig -o $(ip)/$(file_netlist).json" 	>> $(path_yosys_file)
	@ echo "# ----- display stats"						>> $(path_yosys_file)
	@ echo "stat -tech cmos -width"						>> $(path_yosys_file)
	@ echo "# ----- display design netlist using svg"	>> $(path_yosys_file)
	@ echo "show -format svg -viewer eog -stretch -width \
		-colors 10000 -signed -prefix $(ip)/$(rtl_top)" >> $(path_yosys_file)
	@ echo ----- running yosys
	@ yosys $(path_yosys_file)
	@ echo ------------------------------------ DONE ------------------------------------
	@ echo " "

clean:
	@ echo " "
	@ echo -------------------------- Cleaning all dump files -------------------------
	@ rm -rfv \
	*/*.ys \
	*/*.vcd \
	*/*.vvp \
	*/*.json \
	*/*.v \
	*/*.dot \
	*/*.svg \
	*/*.cf
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "