# crdt

Conflict-free replicated data types (CRDTs) for Pony, based on delta-state replication.

## Status

The API might change but it is usable in production software.

## Overview

The following CRDT types are implemented:

**Counters:** `GCounter`, `PNCounter`, `CCounter`

**Sets:** `GSet`, `P2Set`, `TSet`, `AWORSet`, `RWORSet`

**Registers:** `TReg`, `MVReg`

**Collections:** `TLog`, `CKeyspace`

Each type supports convergent merging of concurrent updates so that all replicas eventually reach the same state without coordination. All mutator methods accept and return convergent delta-states for efficient replication.

See the `examples/` directory for usage demonstrations of each type.

## Installation

* Install [corral](https://github.com/ponylang/corral)
* `corral add github.com/ponylang/crdt.git --version 0.0.0`
* `corral fetch` to fetch your dependencies
* `use "crdt"` to include this package
* `corral run -- ponyc` to compile your application

## API Documentation

[https://ponylang.github.io/crdt](https://ponylang.github.io/crdt)
