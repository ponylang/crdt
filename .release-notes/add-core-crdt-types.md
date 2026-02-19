## Add core CRDT types

Implements the core set of delta-state CRDTs:

**Counters:**
- `GCounter` - grow-only counter with saturated addition
- `PNCounter` - positive-negative counter (increment and decrement)
- `CCounter` - causal counter with dot-based tracking

**Sets:**
- `GSet` - grow-only set (add only, never remove)
- `P2Set` - two-phase set (elements can be removed once, permanently)
- `TSet` - timestamp-based set with last-write-wins semantics
- `AWORSet` - add-wins observed-remove set
- `RWORSet` - remove-wins observed-remove set

**Registers:**
- `TReg` - timestamp-based last-write-wins register
- `MVReg` - multi-value register (retains concurrent values)

**Collections:**
- `TLog` - sorted timestamped log with cutoff/trim
- `CKeyspace` - compose CRDTs under named keys with shared causal context

All types support delta-state replication and token-based serialization.

```pony
use "crdt"

actor Main
  new create(env: Env) =>
    let a = GCounter(1)
    let b = GCounter(2)

    a.increment(10)
    b.increment(20)

    a.converge(b)
    b.converge(a)

    env.out.print(a.string()) // "30"
```
