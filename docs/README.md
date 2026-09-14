[![Librelane Digital Flow (UNIC-CASS)](https://github.com/unic-cass/unic-cass-wrapper/actions/workflows/digital-flow.yaml/badge.svg?branch=dev&event=push)](https://github.com/unic-cass/unic-cass-wrapper/actions/workflows/digital-flow.yaml)

# UNIC-CASS-WRAPPER 

> **Project Status:**
>This repository represents an initial version of the UNIC-CASS Wrapper. Its architecture, interfaces, and integration assumptions may evolve over time as the UNIC-CASS program grows and new requirements, design experiences, and use cases are incorporated.

Table of contents
=================

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [GPIO Configuration](#gpio-configuration)
4. [Layout Integration](#layout-integration)

Overview
========

The UNIC-CASS Wrapper is an open-source chip integration template designed to standardize and simplify the integration of UNIC-CASS circuit designs for fabrication using the IHP open-source PDK.

Inspired by the Caravel integration concept, this repository provides a lightweight wrapper architecture that enables designers to focus on their core circuit designs while relying on a predefined, reusable top-level structure for chip-level integration. Unlike Caravel, the UNIC-CASS Wrapper does not implement a System-on-Chip (SoC); instead, it serves purely as a generic template for integrating one or more user designs into a manufacturable chip.

This repository is part of the Universalization of IC Design from CASS (UNIC-CASS) program—an open, end-to-end initiative aimed at democratizing integrated circuit design education and fabrication through open-source tools, workflows, and PDKs.

Prerequisites
=============

The unic-cass-wrapper is designed to work inside the [uniccass-icdesign-tools](https://github.com/unic-cass/uniccass-icdesign-tools) Docker container.  
Make sure the container is properly installed and running before continuing with the Quick Start.

Quick Start
===========

### Starting Your Project

1. Create a new repository based on the unic-cass-wrapper template. Ensure your repo is public and includes a README.
    - Follow [this link](https://github.com/unic-cass/unic-cass-wrapper/fork) to create your repository.
    - Clone the repository using:
        ```
        git clone <your GitHub repo URL>
        ```
2. Set up your local environment:
    ```
    cd <project_name>
    make setup
    ```
    This command installs:
    - Submodules
3. Start hardening your design:
    - Create a subdirectory for each design in your project under the unic_cass_wrapper_user_project/ directory with Librelane configuration files (config.json). You can use the [user_project_example](https://github.com/unic-cass/unic-cass-wrapper/tree/main/unic_cass_wrapper_user_project/user_project_example) as a template.
    - Provide an RTL Verilog model of your design to Librelane ([example](https://github.com/unic-cass/unic-cass-wrapper/blob/5480577840c9ec114b1a3f2999bc0efdfbeef1d0/unic_cass_wrapper_user_project/user_project_example/config.json#L10C1-L11C37)). You must follow **exactly** the pin names and interface shown below. **Do not modify this interface**, as it is crucial for correct integration with the unic_cass_wrapper.

        ``` verilog
        module your_design(
            `ifdef USE_POWER_PINS
            inout VPWR,    // Common digital supply
            inout VGND,    // Common digital ground
            `endif
            input  wire clk_i,
            input  wire rst_ni,
            input  wire [16:0] ui_PAD2CORE,
            output  wire [16:0] uo_CORE2PAD
        );
        ```
    - Build your design GDSII.

        ```
        cd unic_cass_wrapper_user_project/your_design/
        make <module_name>
        ```
    - Finally, you can explore the results:
        ```
        make <module_name> VIEW_RESULTS=1
        ```
4. Integrate modules into the user_project_wrapper:
    1. Instantiate your designs in [user_project_wrapper.v](https://github.com/unic-cass/unic-cass-wrapper/blob/5480577840c9ec114b1a3f2999bc0efdfbeef1d0/unic_cass_wrapper/src/user_project_wrapper.sv#L83). You must **only modify the module name and the instance name**. **Do not change the instance pin connections**, as they are required for correct integration with the unic_cass_wrapper.
    2. Update the macros in the [config.json](https://github.com/unic-cass/unic-cass-wrapper/blob/5480577840c9ec114b1a3f2999bc0efdfbeef1d0/unic_cass_wrapper/config.json#L125C1-L145C10) file. Make sure to provide:
        - your design names
        - GDS path
        - LEF path
        - NL (netlist) path
        - LIB path
        - SPEF path
        - Module instances with the desired position (the position is up to you)
    3. Harden the user_project_wrapper with your module(s):
        ```
        cd unic_cass_wrapper
        make
        ```
    4. Finally, you can explore the results.
        ```
        make view_results
        ```
5. After you have gone through the flow successfully, update the [designs](https://github.com/unic-cass/unic-cass-wrapper/blob/5480577840c9ec114b1a3f2999bc0efdfbeef1d0/Makefile#L3C1-L3C8) variable in the Makefile of the main directory and run it. This will:
    1. Run again the complete flow.
    2. If it passes DRC and LVS it is ready for tapeout.
6. This main Makefile will be run in github every time you push a change. The action must pass in order to complete the mock-tapeout process.

GPIO Configuration
=================

![architecture](img/unic-cass-mock-tapeout-pinlist.png)

Layout Integration
=================

![architecture](img/unic-cass-mock-tapeout.png)

