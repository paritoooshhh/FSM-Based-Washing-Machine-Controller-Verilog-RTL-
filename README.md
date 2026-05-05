# FSM Based Washing Machine Controller (RTL Design)

A complete **FSM-based Washing Machine Controller** designed in **Verilog HDL**, modeling real-world washing machine behavior with multiple modes, timer-driven control, and modular architecture.

---

## Project Overview

This project implements a **Moore Finite State Machine (FSM)** to control washing machine operations such as filling water, washing, draining, rinsing, and spinning.

The system is designed to mimic a real appliance controller by integrating:

* Mode-based operation
* Timer-controlled state transitions
* Actuator control signals

---

## Features

*  Moore FSM-based control logic
*  Timer-driven state transitions
*  11 washing modes (real panel inspired)
*  Modular RTL architecture
*  Clean separation of control and datapath
*  Fully testbench-verified

---

##  Supported Modes

* Normal
* Quick Wash
* Super Clean
* Delicates
* Bedsheet
* Jeans
* Drain + Spin
* Rinse + Spin
* Tub Clean
* Eco Tub Clean
* Presoak + Wash

---

##  Architecture

<img width="1262" height="780" alt="image" src="https://github.com/user-attachments/assets/e366e4e3-310e-47e5-b4fd-fa15d83a6b0a" />
FSM based - Washing Machine Controller - RTL Architecture (V1)


##  FSM Design

The controller is based on a **Moore State Machine**, where outputs depend only on the current state.

### States:

* IDLE
* FILL
* PRESOAK
* WASH
* DRAIN
* RINSE1
* SPIN
* DONE
  <img width="1417" height="813" alt="image" src="https://github.com/user-attachments/assets/7b043cf7-8e13-41ec-ac5f-e019f0c91132" />
Complete Moore State Machine Diagram

### Key Behavior:

* Transitions occur only when timer_done = 1
* Modes dynamically alter state paths

---

##  Actuator Control

The system controls real washing machine components:

* Water inlet valve
* Wash motor
* Spin motor
* Drain pump
* Door lock mechanism
* Buzzer (completion signal)

---

##  Project Structure

```text
washing-machine-controller/

rtl/
    timer_counter.v
    mode_timer_lookup.v
    washing_fsm.v
    actuator_control.v
    top_controller.v

Testbench/
    testbench.v

README.md
Design_spec.md
```

---

##  Simulation

The project includes a **testbench** to verify:

* Multiple washing modes
* State transitions
* Actuator behavior

---

##  Design Highlights

* Clean modular design
* Industry-style FSM implementation
* Scalable for future upgrades (V2)
* Real-world appliance modeling

---

##  Future Improvements (V2)

* Pause/resume functionality
* Multiple rinse cycles (RINSE1 → RINSE8)
* Real-time clock divider
* Sensor integration (water level, door safety)
* Display interface (7-segment / LCD)
* FPGA deployment

---

##  Author

**Paritosh Tanneru**
ECE 4th semester — IIIT Kottayam

---

##  Note

For detailed design specifications, timing tables, and state diagrams, refer to:

 `Design_spec.md`

---
