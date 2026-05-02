#############################################################
###############    DSM ONLY MAKE FILE	#####################
#############################################################

# # Define variables
# IVERILOG = iverilog
# VVP = vvp
# GTKWAVE = gtkwave
# NGSPICE = ngspice
# OUTPUT = dsm_top.out
# MIXED = dsm_top.so
# MIXED_OBJ = dsm_top_obj_dir
# VCD_FILE = dsm_top_tb.vcd
# SRC_FILES = dsm_top.v dsm_top_tb.v dsm_9bit.v shift_reg_serial.v
# NGSPICE_FILE = dsm_top.v
# DEST_DIR = ../xschem/
# # Default target
# all: run_wave

# # Compile using iverilog
# $(OUTPUT): $(SRC_FILES)
# 	$(IVERILOG) -o $(OUTPUT) $(SRC_FILES)

# # Run the simulation with vvp
# run: $(OUTPUT)
# 	$(VVP) $(OUTPUT)

# copy: 
# 	cp $(MIXED) $(DEST_DIR)

# # Open the wave file in GTKWave
# wave: $(VCD_FILE)
# 	$(GTKWAVE) $(VCD_FILE) conf_dsm.gtkw

# # Run ngspice vlnggen command
# ngspice:
# 	$(NGSPICE) vlnggen $(NGSPICE_FILE)

# # Execute both the simulation and wave viewer
# run_wave: run wave

# # Run ngspice and then the rest of the steps
# full: ngspice run_wave copy

# # Clean up generated files
# clean:
# 	rm -f $(OUTPUT) $(VCD_FILE) $(MIXED)
# 	rm -rf $(MIXED_OBJ) 




#############################################################
#############    DSM WITH DIVIDER MAKE FILE	#################
#############################################################

# Define variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
NGSPICE = ngspice
OUTPUT = dsm_and_freq_divider.out
MIXED = dsm_and_freq_divider.so
MIXED_OBJ = dsm_and_freq_divider_obj_dir
VCD_FILE = dsm_and_freq_divider.vcd
SRC_FILES =  tb_dsm_and_freq_divider.v dsm_and_freq_divider.v dsm_9bit.v dsm_top.v shift_reg_serial.v Frequency_Divider_240_248.v DFF.v
NGSPICE_FILE =  dsm_and_freq_divider.v
DEST_DIR = ../xschem/

# Default target
all: run_wave

# Compile using iverilog
$(OUTPUT): $(SRC_FILES)
	$(IVERILOG) -o $(OUTPUT) $(SRC_FILES)

# Run the simulation with vvp
run: $(OUTPUT)
	$(VVP) $(OUTPUT)

copy: 
	cp $(MIXED) $(DEST_DIR)

# Open the wave file in GTKWave
wave: $(VCD_FILE)
	$(GTKWAVE) $(VCD_FILE) conf_dsm_w_divider.gtkw

# Run ngspice vlnggen command
ngspice:
	$(NGSPICE) vlnggen $(NGSPICE_FILE)

# Execute both the simulation and wave viewer
run_wave: run wave

# Run ngspice and then the rest of the steps
full: ngspice run_wave copy

# Clean up generated files
clean:
	rm -f $(OUTPUT) $(VCD_FILE) $(MIXED)
	rm -rf $(MIXED_OBJ) 