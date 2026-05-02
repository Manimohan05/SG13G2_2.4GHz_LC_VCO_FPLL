# Define variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
NGSPICE = ngspice
OUTPUT = Frequency_Divider_240_248.out
MIXED = Frequency_Divider_240_248.so
MIXED_OBJ = Frequency_Divider_240_248_obj_dir
VCD_FILE = tb_Frequency_Divider_240_248.vcd
SRC_FILES = ../testbenches/tb_Frequency_Divider_240_248.v DFF.v Divide_by_4.v Prescaler_4_5.v Mod7_Counter.v Modulus_Controller.v Output_Div2.v
NGSPICE_FILE = Frequency_Divider_240_248.v
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
	$(GTKWAVE) $(VCD_FILE) conf.gtkw

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