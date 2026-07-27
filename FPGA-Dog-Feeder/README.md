# FPGA-Based Food and Water Dispensing System

An FPGA-based automated food and water dispensing system implemented in **Verilog HDL** with **simulation-based verification using ModelSim**.

---

## Overview

This project presents the design and implementation of an FPGA-based automated food and water dispensing system intended for use in dog shelters. The system identifies individual dogs using RFID technology, monitors food and water levels through load cells, and controls dispensing using DC motors. An IoT monitoring system records system data to Google Sheets, enabling remote monitoring of the dispensing process.

The hardware controller is implemented in Verilog HDL and deployed on an **Altera Cyclone II EP2C5T144I8N FPGA**.

---

## Features

- RFID-based dog identification
- Automatic food dispensing
- Automatic water dispensing
- Load cell monitoring of food and water bowls
- Feeding cooldown mechanism to prevent repeated feeding
- Daily feeding reset
- IoT monitoring through Google Sheets
- Modular Verilog HDL architecture
- Simulation-based verification using ModelSim

---

## System Architecture

![System Block Diagram](docs/block_diagram.png)

---

## RTL Module Hierarchy

```
FPGA_Dog_Feeder (Top Module)
│
├── feeding_controller
│   └── food_controller
│       └── dog_cooldown_controller
│           └── cooldown_timer
│   ├── water_controller
│   └── loadcell_controller
│
├── rfid_controller
│
└── day_reset_controller
```

---

## Hardware Components

| Component | Purpose |
|----------|---------|
| Altera Cyclone II EP2C5T144I8N | Main FPGA controller |
| RFID Reader & Tags | Dog identification |
| Load Cells | Food and water level measurement |
| DC Motors | Dispensing mechanism |
| IoT Module | Upload system data to Google Sheets |

---

## Verification

Each RTL module is independently verified using dedicated ModelSim testbenches before system integration.

Current verification includes:

| Module | Status |
|---------|--------|
| cooldown_timer | ✅ Verified |
| dog_cooldown_controller | ✅ Verified |
| rfid_controller | ✅ Verified |
| feeding_controller | 🚧 Planned |
| food_controller | 🚧 Planned |
| water_controller | 🚧 Planned |
| loadcell_controller | ✅ Verified |
| day_reset_controller | 🚧 Planned |
| Top-Level System | 🚧 Planned |

Simulation waveforms are available in the **waveforms/** directory.

---

## Project Structure

```
FPGA-Dog-Feeder/
│
├── rtl/               # Verilog HDL source files
├── tb/                # ModelSim testbenches
├── waveforms/         # Simulation waveform screenshots
├── docs/              # Project documentation
└── README.md
```

---

## Development Tools

- Verilog HDL
- Intel Quartus Prime
- ModelSim
- Git & GitHub

---

## Future Improvements

- Complete verification of all RTL modules
- Hardware validation on FPGA
- Improve IoT monitoring dashboard
- Implement configurable feeding schedules
- Add watchdog and fault detection logic
- Migrate design to AMD/Xilinx FPGA platform

---

## Repository Status

🚧 **Active Development**

This repository is continuously updated as additional modules are implemented, verified, and integrated into the complete FPGA-based dispensing system.

---

## License

This project is intended for educational, research, and portfolio purposes.
