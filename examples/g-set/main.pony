use "../../crdt"

actor Main
  """
  Demonstrates GSet: a grow-only set where elements can be added but never
  removed. Convergence is a simple union of all elements.
  """
  new create(env: Env) =>
    let a = GSet[String]
    let b = GSet[String]

    a.set("apple")
    a.set("banana")
    b.set("banana")
    b.set("cherry")

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    a.converge(b)
    b.converge(a)

    env.out.print("After convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
