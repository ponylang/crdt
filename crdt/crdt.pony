"""
# CRDT

Conflict-free replicated data types (CRDTs) for Pony, based on delta-state
replication. Each data structure supports convergent merging of concurrent
updates, so that all replicas eventually reach the same state without
coordination.

## Counters

* `GCounter` - Grow-only counter. Each replica can only increment; the global
  value is the sum across all replicas. Supports saturated addition to avoid
  overflow.
* `PNCounter` - Positive-negative counter. Built from a pair of `GCounter`
  instances, supporting both increment and decrement.
* `CCounter` - Causal counter. Uses a dot-based causal context to track
  increments and decrements with compact state.

## Sets

* `GSet` / `GHashSet` - Grow-only set. Elements can be added but never removed.
* `P2Set` / `P2HashSet` - Two-phase set. Elements can be added, then removed
  once. Once removed, an element cannot be re-added.
* `TSet` / `THashSet` - Timestamp-based set with last-write-wins semantics for
  insertion and deletion, using a logical timestamp and configurable bias.
* `AWORSet` / `AWORHashSet` - Add-wins observed-remove set. When concurrent
  add and remove operations conflict, the add wins.
* `RWORSet` / `RWORHashSet` - Remove-wins observed-remove set. When concurrent
  add and remove operations conflict, the remove wins.

## Registers

* `TReg` - Timestamp-based last-write-wins register. Concurrent updates are
  resolved by logical timestamp with a configurable bias for tie-breaking.
  Convenience aliases `TRegString` and `TRegNumber` provide default values.
* `MVReg` / `MVHashReg` - Multi-value register. Concurrent updates result in
  multiple values being retained until a subsequent update overrides them.

## Collections

* `TLog` - Timestamped log. A sorted list of entries with logical timestamps
  and a cutoff timestamp for discarding old entries. Supports trim and clear.
* `CKeyspace` / `HashCKeyspace` - A keyed collection of convergent CRDTs
  sharing a causal context. Composes any `Convergent` type under named keys.

## Delta-State Replication

All mutator methods accept and return a convergent delta-state. This delta
captures only the new information produced by the mutation, and can be sent
to other replicas for efficient convergence without transmitting the full state.

## Serialization

All types implement token-based serialization via the `Replicated` interface,
supporting `each_token` for serialization and `from_tokens` for deserialization.
"""
