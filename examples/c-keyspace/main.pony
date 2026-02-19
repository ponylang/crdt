use "../../crdt"

actor Main
  """
  Demonstrates CKeyspace: composing CRDTs under named keys with a shared
  causal context. Each key maps to a convergent CRDT instance that shares
  context with the keyspace.
  """
  new create(env: Env) =>
    let a = CKeyspace[String, AWORSet[String]](1)
    let b = CKeyspace[String, AWORSet[String]](2)

    // Access or create CRDTs under named keys
    a.at("fruits").set("apple")
    a.at("fruits").set("banana")
    a.at("colors").set("red")
    b.at("fruits").set("cherry")
    b.at("colors").set("blue")

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    a.converge(b)
    b.converge(a)

    env.out.print("After convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())
