# 🔇 NoiselessUART

**NoiselessUART** is a noise-resilient UART protocol implemented in Verilog, enhanced by a Riccati-equation-inspired sampling mechanism to reduce Bit Error Rate (BER). This design integrates traditional UART transceiver logic with intelligent sampling and majority-voting, aiming for robust performance in noisy environments.

---

## 📌 Key Features

- UART Transmitter and Receiver (8N1 Frame Format)
- Riccati-based adaptive sampling and majority voting
- 50% BER reduction under simulated bit-flip noise
- Parameterized baud rate and clock frequency
- Synthesizable and simulation-ready Verilog code
- Modular testbench with waveform support

---

## 🧠 Project Motivation

Traditional UART implementations are prone to **bit errors** under line noise and clock drift. Inspired by **Riccati equations** (used in control theory and estimation), we introduce a **sampling redundancy + majority voting** strategy to recover accurate bits even under random disturbances.

> 🎯 *"Make UART robust without changing the protocol—only the way we sample."*

---

## 🛠️ Files Overview

| File           | Description                                 |
|----------------|---------------------------------------------|
| `UART.v`       | Top-level wrapper integrating TX and RX     |
| `UART_TX.v`    | Serial transmitter with start/stop framing  |
| `UART_RX.v`    | Receiver with Riccati-style sampling filter |
| `UART_TB.v`    | Testbench to simulate noisy channel         |
| `Makefile`     | Compile and run simulation using Icarus     |

---

## ⚙️ Simulation

### Run with Icarus Verilog:

```bash
make        # Compile and simulate
gtkwave dump.vcd
