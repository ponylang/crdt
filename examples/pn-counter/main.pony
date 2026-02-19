use "../../crdt"

actor Main
  """
  Demonstrates PNCounter: a counter that supports both increment and decrement,
  built from a pair of grow-only counters tracking positive and negative growth.
  """
  new create(env: Env) =>
    let a = PNCounter(1)
    let b = PNCounter(2)

    a.increment(10)
    a.decrement(3)
    b.increment(5)
    b.decrement(1)

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    a.converge(b)
    b.converge(a)

    env.out.print("After convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
