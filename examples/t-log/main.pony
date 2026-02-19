use "../../crdt"

actor Main
  """
  Demonstrates TLog: a sorted log of timestamped entries. Entries are sorted
  in descending timestamp order (most recent first). A cutoff timestamp can
  discard old entries, and trim retains at least n entries.
  """
  new create(env: Env) =>
    let a = TLog[String]
    let b = TLog[String]

    a.write("first event", 1)
    a.write("second event", 2)
    b.write("third event", 3)
    b.write("fourth event", 4)

    env.out.print("Before convergence:")
    env.out.print("  a = " + a.string())
    env.out.print("  b = " + b.string())

    a.converge(b)
    b.converge(a)

    env.out.print("After convergence:")
    env.out.print("  a = " + a.string())

    // Trim to keep only the 2 most recent entries
    a.trim(2)
    env.out.print("After trim(2):")
    env.out.print("  a = " + a.string())
