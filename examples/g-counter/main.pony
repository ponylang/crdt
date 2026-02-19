use "../../crdt"

actor Main
  """
  Demonstrates GCounter: a grow-only counter where each replica can only
  increment. The global value is the sum across all replicas. Incrementing
  beyond the maximum value of the integer type saturates at the maximum.
  """
  new create(env: Env) =>
    let a = GCounter(1)
    let b = GCounter(2)
    let c = GCounter(3)

    a.increment(10)
    b.increment(20)
    c.increment(30)

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
    env.out.print("  c = " + c.string())

    a.converge(b)
    a.converge(c)
    b.converge(a)
    c.converge(a)

    env.out.print("After convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
    env.out.print("  c = " + c.string())

    // Demonstrate saturated addition with U8
    let d = GCounter[U8](1)
    d.increment(250)
    d.increment(10)
    env.out.print("Saturated U8 counter: " + d.string())
