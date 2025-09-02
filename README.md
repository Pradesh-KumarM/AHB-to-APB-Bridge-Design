# AHB-to-APB-Bridge-Design
This project implements an AMBA AHB to APB Bridge in Verilog HDL.   The bridge enables communication between high-performance AHB masters and low-power APB peripherals, making it a key component in SoC designs.
---

## 🏗 Architecture
- **AHB Master** – Generates AHB transactions.
- **AHB Slave Interface** – Accepts transactions from AHB and forwards to APB controller.
- **APB Controller** – Controls APB transfers, generating control signals.
- **APB Interface** – Handles communication with APB peripherals.
- **Bridge Top Module** – Integrates all components.
- **Testbenches** – Verify functionality of each module and the complete system.

---

## 📂 Repository Structure
AHB-APB-Bridge/
│── README.md
│── Report/
│ └── PROJECT_REPORT_ahb2apb.docx
│── Code/
│ ├── ahbslaveinterface.v
│ ├── apbcontroller.v
│ ├── bridge_top.v
│ ├── ahb_master.v
│ ├── apb_interface.v
│── Testbenches/
│ ├── ahbslaveinterface_tb.v
│ ├── apbcontroller_tb.v
│ ├── bridge_top_tb.v
│ ├── top_tb.v


---

## 🛠 Features
- Full **Verilog HDL implementation** of AHB to APB Bridge.
- Supports **read and write transfers**.
- Separate **testbenches for all modules**.
- Simulated and verified using industry tools.

---

## 🚀 Tools Used
- **ModelSim** – RTL simulation and waveform analysis.  
- **Xilinx ISE / Vivado** – Synthesis and FPGA mapping.  
- **Verilog HDL** – RTL coding.  

---

## 📖 Key Learnings
- Understanding of **AMBA protocols (AHB & APB)**.  
- Design of a **bus bridge for protocol conversion**.  
- **Testbench writing & simulation methodology**.  
- Exposure to **SoC design verification flow**.  

---

## 📖 References
- ARM Ltd., *AMBA AHB and APB Specifications*.  
- D. Flynn, *AMBA: Enabling Reusable On-Chip Designs*.  
- Internship guidance material from Maven Silicon.  
