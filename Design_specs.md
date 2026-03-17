# Washing Machine Controller — Design Specification (V1)

## Overview

This project implements a **finite state machine (FSM)-based washing machine controller** in Verilog.
The controller models real-world washing machine behavior with multiple washing modes and timer-driven transitions.

The system is designed using a **modular hardware architecture**, separating control logic, timing logic, and output control.

---

## Design Assumptions

* **FSM Type**: Moore Machine
* **Clock Assumption (V1)**:
  `1 clock cycle = 1 second`
* **Timer Type**: Controlled timer (load + enable based)
* **State Transitions**: Occur only when `timer_done = 1`

---

## FSM States

```text
IDLE
FILL
PRESOAK
WASH
DRAIN
RINSE1
SPIN
DONE
```

### Base Flow

```text
IDLE → FILL → PRESOAK → WASH → DRAIN → RINSE1 → SPIN → DONE → IDLE
```

Modes selectively skip states.

---

## Actuator Signals

| Signal      | Description                 |
| ----------- | --------------------------- |
| water_valve | Controls water inlet        |
| motor_wash  | Drum rotation (wash speed)  |
| motor_spin  | Drum rotation (spin speed)  |
| drain_pump  | Removes water               |
| door_lock   | Locks door during operation |
| buzzer      | Signals completion          |

---

## State → Actuator Mapping

| State   | water_valve | motor_wash | motor_spin | drain_pump | door_lock | buzzer |
| ------- | ----------- | ---------- | ---------- | ---------- | --------- | ------ |
| IDLE    | 0           | 0          | 0          | 0          | 0         | 0      |
| FILL    | 1           | 0          | 0          | 0          | 1         | 0      |
| PRESOAK | 0           | 1          | 0          | 0          | 1         | 0      |
| WASH    | 0           | 1          | 0          | 0          | 1         | 0      |
| DRAIN   | 0           | 0          | 0          | 1          | 1         | 0      |
| RINSE1  | 1           | 1          | 0          | 0          | 1         | 0      |
| SPIN    | 0           | 0          | 1          | 0          | 1         | 0      |
| DONE    | 0           | 0          | 0          | 0          | 0         | 1      |

---

## Mode Encoding (4-bit)

```verilog
NORMAL        = 4'd0
QUICK_WASH    = 4'd1
SUPER_CLEAN   = 4'd2
DELICATES     = 4'd3
BEDSHEET      = 4'd4
JEANS         = 4'd5
DRAIN_SPIN    = 4'd6
RINSE_SPIN    = 4'd7
TUB_CLEAN     = 4'd8
ECO_TUB_CLEAN = 4'd9
PRESOAK_WASH  = 4'd10
```

---

## Mode → State Matrix

| Mode          | FILL | PRESOAK | WASH | DRAIN | RINSE1 | SPIN |
| ------------- | ---- | ------- | ---- | ----- | ------ | ---- |
| NORMAL        | ✓    | ✗       | ✓    | ✓     | ✓      | ✓    |
| SUPER_CLEAN   | ✓    | ✓       | ✓    | ✓     | ✓      | ✓    |
| QUICK_WASH    | ✓    | ✗       | ✓    | ✓     | ✓      | ✓    |
| DELICATES     | ✓    | ✗       | ✓    | ✓     | ✓      | ✓    |
| BEDSHEET      | ✓    | ✓       | ✓    | ✓     | ✓      | ✓    |
| JEANS         | ✓    | ✓       | ✓    | ✓     | ✓      | ✓    |
| DRAIN_SPIN    | ✗    | ✗       | ✗    | ✓     | ✗      | ✓    |
| RINSE_SPIN    | ✓    | ✗       | ✗    | ✗     | ✓      | ✓    |
| TUB_CLEAN     | ✓    | ✗       | ✓    | ✓     | ✓      | ✓    |
| ECO_TUB_CLEAN | ✓    | ✗       | ✓    | ✓     | ✗      | ✗    |
| PRESOAK_WASH  | ✓    | ✓       | ✓    | ✓     | ✓      | ✓    |

---

## Mode + State → Timer Table (in seconds)

### NORMAL

FILL=10, WASH=30, DRAIN=4, RINSE1=10, SPIN=12

### QUICK_WASH

FILL=6, WASH=14, DRAIN=4, RINSE1=6, SPIN=8

### SUPER_CLEAN

FILL=12, PRESOAK=20, WASH=40, DRAIN=6, RINSE1=14, SPIN=16

### DELICATES

FILL=8, WASH=14, DRAIN=4, RINSE1=8, SPIN=5

### BEDSHEET

FILL=12, PRESOAK=18, WASH=30, DRAIN=6, RINSE1=12, SPIN=12

### JEANS

FILL=10, PRESOAK=16, WASH=32, DRAIN=6, RINSE1=12, SPIN=14

### DRAIN_SPIN

DRAIN=6, SPIN=10

### RINSE_SPIN

FILL=8, RINSE1=10, SPIN=10

### TUB_CLEAN

FILL=10, WASH=40, DRAIN=6, RINSE1=12, SPIN=10

### ECO_TUB_CLEAN

FILL=10, WASH=50, DRAIN=6

### PRESOAK_WASH

FILL=10, PRESOAK=20, WASH=24, DRAIN=6, RINSE1=10, SPIN=10

---

## Timer Design

### Inputs

* clk
* reset
* load
* enable
* load_value

### Outputs

* time_remaining
* timer_done

### Behavior

```text
if(load) → load_value into counter
if(enable) → decrement counter
if(counter == 0) → timer_done = 1
```

---

## FSM Inputs & Outputs

### Inputs

* clk
* reset
* start
* mode[3:0]
* timer_done

### Outputs

* state[2:0]

---

## Design Modules

```text
rtl/
    washing_fsm.v
    timer_counter.v
    mode_timer_lookup.v
    actuator_control.v
    top_controller.v
```

---

## Future Improvements (V2)

* Multiple rinse cycles (RINSE1 → RINSE8)
* Clock divider for real-time operation
* Sensor integration (water level, door)
* Pause/resume support
* Display system (7-segment / LCD)
