# Examples

Each example creates replicas, performs mutations, converges state, and prints results to demonstrate the key semantic property of each CRDT type.

Build all examples with `make build-examples`.

## Counters

- **g-counter** - Grow-only counter with saturated addition and replica convergence.
- **pn-counter** - Positive/negative counter supporting both increment and decrement.
- **c-counter** - Causal counter with dot-based tracking for compact state.

## Sets

- **g-set** - Grow-only set with union-based convergence.
- **p2-set** - Two-phase set with one-time removal semantics.
- **t-set** - Timestamp-based last-write-wins set with configurable bias.
- **awor-set** - Add-wins observed-remove set demonstrating concurrent conflict resolution.
- **rwor-set** - Remove-wins observed-remove set with opposite conflict resolution bias.

## Registers

- **t-reg** - Timestamp-based last-write-wins register.
- **mv-reg** - Multi-value register retaining concurrent values until overridden.

## Collections

- **t-log** - Timestamped log with cutoff and trim for discarding old entries.
- **c-keyspace** - Composing CRDTs under named keys with a shared causal context.
