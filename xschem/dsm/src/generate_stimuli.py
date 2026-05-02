# generate_stimuli.py
# Generates HSPICE stimulus file for serial input sweep (-128 to +127)
# Compatible with IHP/xschem/Ngspice "hspice_simple" format
# Updated: sclk frequency = 100 MHz (period = 10 ns)

def write_bit_sequence(f, bit):
    """Write timing sequence for a single bit."""
    f.write(f"set sdata {bit}\n")
    f.write("s 1\n")            # small setup time before clock
    f.write("set sclk 1\n")
    f.write("s 5\n")            # sclk high for 5 ns
    f.write("set sclk 0\n")
    f.write("s 5\n")            # sclk low for 5 ns (total 10 ns period = 100 MHz)

def write_serial_word(f, word):
    """Send one 9-bit signed word (MSB first)."""
    # Convert signed integer to 9-bit two's complement
    if word < 0:
        word = (1 << 9) + word
    bits = [(word >> i) & 1 for i in range(8, -1, -1)]  # MSB first

    f.write(f"* --- Sending word {word if word < 256 else word - 512} ---\n")
    f.write("set en 1\n")
    f.write("s 3\n")  # short enable setup
    for bit in bits:
        write_bit_sequence(f, bit)
    f.write("set en 0\n")
    f.write("set sdata 0\n")
    f.write("s 10000\n\n")  # delay after word

def main():
    with open("../xschem/simulation/stimuli_input_0.txt", "w") as f:
        # Header
        f.write("unit n\n")
        f.write("voltage 1.8\n")
        f.write("slope 5\n")
        f.write("format hspice_simple\n\n")
        f.write("signal sdata\nsignal sclk\nsignal rst\nsignal en\n\n")
        f.write("beginfile stimuli_test.cir\n\n")

        # Initialization and reset
        f.write("* --- Initialization ---\n")
        f.write("set rst 1\nset en 0\nset sclk 0\nset sdata 0\ns 50\n")
        f.write("set rst 0\ns 20\n\n")

        ####### FOR TESTING DSM ############
        # # Sweep from -128 to +127 step 16
        # for word in range(-128, 128, 16):
        #     write_serial_word(f, word)
        ####################################

        write_serial_word(f, 0)

        # End
        f.write("endfile\n")

    print("✅ Stimulus file generated successfully with 100 MHz SCLK.")

if __name__ == "__main__":
    main()
