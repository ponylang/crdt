use "../../crdt"

actor Main
  """
  Demonstrates MVReg: a multi-value register. When concurrent updates happen
  on different replicas, all values are retained until a subsequent update
  overrides them.
  """
  new create(env: Env) =>
    let a = MVReg[String](1)
    let b = MVReg[String](2)

    // Concurrent writes on different replicas
    a.update("alice")
    b.update("bob")

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    // After convergence, both values are retained
    a.converge(b)
    b.converge(a)

    env.out.print("After convergence (both values retained):")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    // A new update overrides all concurrent values
    a.update("charlie")
    b.converge(a)

    env.out.print("After a new update overrides:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
