# UART Communication System (Verilog)

This project implements a **UART (Universal Asynchronous Receiver and Transmitter)** communication system in Verilog HDL.  
UART is a widely used protocol for **serial communication** between digital devices such as FPGAs, microcontrollers, and PCs.

---

## 📖 Project Overview

The project implements a UART communication system with the following components:

- **UART Frame Format** (`IMAGES/FIG01.jpg`)  
  The UART frame consists of:
  - Start bit (Low)
  - 8 Data bits (`D0`–`D7`)
  - Optional parity bit
  - Stop bit (High)  

  This defines the structure of each data transmission.  

  ![UART Frame Format](IMAGES/FIG01.jpg)

---

- **Device Connection** (`IMAGES/FIG02.jpg`)  
  Two devices (Device 01 and Device 02) are connected with **crossed TX/RX lines** (TX of one to RX of the other) and a **shared ground**, which is typical for UART communication.  

  ![Device Connection](IMAGES/FIG02.jpg)

---

- **Transmitter Architecture** (`IMAGES/FIG03.jpg`)  
  Includes:
  - **Baud Rate Generator** → produces the clock signal  
  - **Parity Generator** → generates parity bit (optional)  
  - **Finite State Machine (FSM)** → controls transmission sequence  
  - **Parallel-in Serial-out (PISO) Register** → shifts parallel data out serially  

  ![Transmitter Architecture](IMAGES/FIG03.jpg)

---

- **Receiver Architecture** (`IMAGES/FIG04.jpg`)  
  Includes:
  - **Baud Rate Generator** → synchronizes receiver sampling  
  - **Negative Edge Detector** → identifies start bit  
  - **Finite State Machine (FSM)** → manages reception sequence  
  - **Parity Checker** → validates received data  
  - **Serial-in Parallel-out (SIPO) Register** → converts serial input back to parallel data  

  ![Receiver Architecture](IMAGES/FIG04.jpg)

---

## ⚙️ Implementation Details

- **HDL Language**: Verilog  
- **Top-level Modules**: 
  - UART Transmitter
  - UART Receiver
  - Baud Rate Generator
- **Clock Frequency**: 50 MHz  
- **Baud Rate**: 115200  
- **Testbench**: 
  - Implements **loopback mechanism** (TX connected to RX internally)  
  - Generates **VCD file (`uart.vcd`)** for waveform visualization in GTKWave  

---

## ✨ Features
- Supports **8-bit data transmission** with optional parity bit  
- Baud rate generation for both **transmitter and receiver**  
- FSMs for **state management** in both transmitter and receiver  
- Testbench to simulate and validate UART operation  
- Compatible with **GTKWave** for waveform analysis  

---

## 📂 Repository Structure
