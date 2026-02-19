use "../../crdt"

actor Main
  """
  Demonstrates CCounter: a causal counter using dot-based tracking for
  compact state. Supports both increment and decrement.
  """
  new create(env: Env) =>
    let a = CCounter(1)
    let b = CCounter(2)

    a.increment(10)
    a.decrement(3)
    b.increment(5)

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    a.converge(b)
    b.converge(a)

    env.out.print("After convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
