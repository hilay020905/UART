# UART (Universal Asynchronous Receiver and Transmitter)

This repository implements a **UART communication system** in digital logic (Verilog/VHDL).  
UART is a widely used protocol for **asynchronous serial communication** between devices such as microcontrollers, FPGAs, and computers.

---

## ✨ Features
- Asynchronous serial communication
- Configurable **baud rate generator**
- **Parity bit support** (Even/Odd selectable)
- **Start, Data, Parity, Stop** bit framing
- **Transmitter and Receiver FSMs**
- **Error detection** using parity checker
- Point-to-point communication support

---

## 📐 UART Frame Format
A typical UART frame consists of:

- **Start bit** → 1 bit (`Low`)
- **Data bits** → 8 bits (`D0 – D7`)
- **Parity bit** → Optional (Even/Odd)
- **Stop bit** → 1 bit (`High`)

![UART Frame Format](IMAGES/FIG01.jpg)

---

## 🚀 UART Transmitter
The **Transmitter** converts parallel input data into a serial bitstream.

![UART Transmitter Block Diagram](IMAGES/FIG02.jpg)

### Modules:
- **Baud Rate Generator** → Generates transmission clock  
- **Parity Generator** → Creates parity bit (Even/Odd)  
- **Transmitter FSM** → Controls data framing and timing  
- **PISO Register** → Converts parallel data to serial  

---

## 📥 UART Receiver
The **Receiver** reconstructs parallel data from the incoming serial stream.

![UART Receiver Block Diagram](IMAGES/FIG03.jpg)

### Modules:
- **Baud Rate Generator** → Synchronizes receiver sampling  
- **Negative Edge Detector** → Detects start bit  
- **Receiver FSM** → Manages reception and framing  
- **SIPO Register** → Converts serial input to parallel data  
- **Parity Checker** → Verifies correctness of received data  

---

## 🔗 Device-to-Device Communication
Two UART-enabled devices communicate by cross-connecting **Tx** and **Rx** lines:

- Device 1 **Tx → Rx** of Device 2  
- Device 2 **Tx → Rx** of Device 1  
- Common **Ground (GND)** connection  

![Device-to-Device Connection](IMAGES/FIG04.jpg)

---

## 📂 Repository Structure
