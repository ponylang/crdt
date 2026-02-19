use "../../crdt"

actor Main
  """
  Demonstrates TSet: a set with last-write-wins semantics using logical
  timestamps. Concurrent operations are resolved by timestamp, with a
  configurable bias for breaking ties.
  """
  new create(env: Env) =>
    let a = TSet[String]
    let b = TSet[String]

    // Insert with timestamps
    a.set("apple", 1)
    a.set("banana", 2)
    b.set("cherry", 3)

    // Remove "banana" at timestamp 4 (later than its insertion at 2)
    b.unset("banana", 4)

    // Try to re-add "banana" at timestamp 3 (earlier than its deletion at 4)
    // This will be ignored because the deletion timestamp is higher
    a.set("banana", 3)

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    a.converge(b)
    b.converge(a)

    env.out.print("After convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
