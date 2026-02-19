// A unique replica identifier. Each replica in a CRDT cluster must use a
// distinct ID. Read-only replicas that never mutate state may use ID 0.
type ID is U64
