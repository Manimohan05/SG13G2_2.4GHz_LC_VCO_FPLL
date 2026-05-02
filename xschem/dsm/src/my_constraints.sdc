# 1. Define sclk (e.g., 100MHz)
create_clock -name sclk -period 10.0 [get_ports {sclk}]

# 2. Define freq_in (e.g., 3GHz -> 0.333ns)
create_clock -name freq_in -period 0.333 [get_ports {freq_in}]

# 3. Tell the tool these clocks are independent (Asynchronous)
# This is the most important part for your area/timing!
set_clock_groups -asynchronous -group [get_clocks sclk] -group [get_clocks freq_in]


