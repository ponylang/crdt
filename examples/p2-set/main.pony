use "../../crdt"

actor Main
  """
  Demonstrates P2Set: a two-phase set where elements can be added and then
  removed once. Once removed, an element can never be re-added.
  """
  new create(env: Env) =>
    let a = P2Set[String]
    let b = P2Set[String]

    a.set("apple")
    a.set("banana")
    a.set("cherry")
    b.set("banana")

    // Remove "banana" on replica a - this is permanent
    a.unset("banana")

    // Try to re-add "banana" on replica a - silently ignored
    a.set("banana")

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    a.converge(b)
    b.converge(a)

    env.out.print("After convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
