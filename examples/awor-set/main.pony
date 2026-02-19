use "../../crdt"

actor Main
  """
  Demonstrates AWORSet: an add-wins observed-remove set. When a concurrent
  add and remove conflict (no causal relationship), the add wins.
  """
  new create(env: Env) =>
    let a = AWORSet[String](1)
    let b = AWORSet[String](2)

    a.set("apple")
    a.set("banana")
    b.set("cherry")

    // Converge so both replicas see all elements
    a.converge(b)
    b.converge(a)

    // Concurrent operations: a removes "banana", b re-adds "banana"
    a.unset("banana")
    b.set("banana")

    env.out.print("Before convergence (concurrent ops):")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    // After convergence, "banana" is present because add wins
    a.converge(b)
    b.converge(a)

    env.out.print("After convergence (add wins):")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
