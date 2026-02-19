use "../../crdt"

actor Main
  """
  Demonstrates TReg: a timestamp-based last-write-wins register. Concurrent
  updates are resolved by logical timestamp. Ties are broken by a configurable
  bias (BiasGreater by default).
  """
  new create(env: Env) =>
    let a = TRegString
    let b = TRegString

    a.update("hello", 1)
    b.update("world", 2)

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    a.converge(b)
    b.converge(a)

    env.out.print("After convergence (higher timestamp wins):")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
