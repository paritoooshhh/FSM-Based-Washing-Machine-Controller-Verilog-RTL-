# Washing Machine Controller (RTL Design)

A modular **Finite State Machine (FSM) based washing machine controller** implemented in **Verilog HDL**.
This project models the control logic of a modern washing machine supporting multiple washing modes and timer-based state transitions.

The design follows a **hardware architecture approach**, separating the FSM, timer logic, mode control, and actuator outputs into independent modules.

---

# Project Overview

Modern washing machines operate through a sequence of stages such as filling water, washing, draining, rinsing, and spinning.
This project models that behaviour using a **finite state machine with timer-driven transitions**.

The controller activates different mechanical components (actuators) such as:

* Water inlet valve
* Drum motor (wash mode)
* Drum motor (spin mode)
* Drain pump
* Door lock
* Buzzer

Each washing **mode** determines which states are executed and how long each stage runs.

---

# Controller Architecture

The controller is organized into modular RTL blocks.

```
                    +----------------------+
mode_select  -----> |   MODE CONTROLLER    |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    |   TIMER LOOKUP       |
                    | (mode + state)       |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    |    TIMER COUNTER     |
                    +----------+-----------+
                               |
                         timer_done
                               |
                               v
                    +----------------------+
                    |     WASHING FSM      |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    |   ACTUATOR CONTROL   |
                    +----------------------+
```

---

# FSM States (V1)

The washing cycle is implemented using the following states:

```
IDLE
FILL
PRESOAK
WASH
DRAIN
RINSE1
SPIN
DONE
```

Base washing flow:

```
IDLE → FILL → PRESOAK → WASH → DRAIN → RINSE1 → SPIN → DONE
```

Depending on the selected washing **mode**, certain states may be skipped.

---

# Actuator Signals

The controller drives the following actuator outputs.

| Signal      | Description                    |
| ----------- | ------------------------------ |
| water_valve | Controls water inlet           |
| motor_wash  | Slow drum rotation for washing |
| motor_spin  | High speed rotation for drying |
| drain_pump  | Removes dirty water            |
| door_lock   | Locks door during cycle        |
| buzzer      | Signals cycle completion       |

---

# Supported Washing Modes

The controller models **11 washing modes** inspired by real washing machine panels.

```
NORMAL
SUPER_CLEAN
QUICK_WASH
DELICATES
BEDSHEET
JEANS
DRAIN_SPIN
RINSE_SPIN
TUB_CLEAN
ECO_TUB_CLEAN
PRESOAK_WASH
```

Each mode modifies:

* State sequence
* State duration

---

# Version 1 (V1)

V1 implements the **core washing machine controller**.

## Features

* FSM based washing cycle controller
* Timer-driven state transitions
* Multiple washing modes
* Modular RTL architecture
* Separate actuator control logic
* Time remaining counter
* Simulation and waveform verification

## Supported States

```
IDLE
FILL
PRESOAK
WASH
DRAIN
RINSE1
SPIN
DONE
```

## Example Mode Flow

Normal mode:

```
FILL → WASH → DRAIN → RINSE1 → SPIN
```

Super Clean mode:

```
FILL → PRESOAK → WASH → DRAIN → RINSE1 → SPIN
```

Drain + Spin mode:

```
DRAIN → SPIN
```

---

# Version 2 (V2) – Future Upgrade

Version 2 will expand the design to model **more realistic appliance behaviour**.

## Planned Improvements

### Multiple Rinse Cycles

Real washing machines may perform up to **8 rinse cycles**.

```
RINSE1 → DRAIN → RINSE2 → DRAIN → ... → RINSE8
```

### Advanced Timer Control

* Configurable cycle durations
* Dynamic timer loading

### Sensor Integration

Possible additions:

* Water level sensor
* Door safety sensor
* Load detection

### Display System

* Time remaining counter
* Mode display logic
* 7-segment display interface

### Enhanced Modes

More accurate behaviour for:

* Eco modes
* Heavy fabric cycles
* Delicate fabric handling

---

# Repository Structure

```
washing-machine-controller/

rtl/
    washing_fsm.v
    timer_counter.v
    mode_controller.v
    actuator_control.v
    top_controller.v

tb/
    washing_machine_tb.v

sim/
    simulation scripts

docs/
    architecture.md
```

---

# Simulation

The design can be simulated using:

* Icarus Verilog
* ModelSim
* Vivado Simulator

Waveforms can be viewed using **GTKWave**.

---

# Learning Goals

This project demonstrates key digital design concepts:

* Finite State Machine design
* Modular RTL architecture
* Timer driven control systems
* Hardware control of mechanical actuators
* Verilog testbench development

---

# Author

Paritosh Tanneru
ECE – IIIT Kottayam

---
