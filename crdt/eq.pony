
interface EqFn[A]
  """
  A function object for testing equality of two values.
  """
  new val create()
  fun apply(a: A, a': A): Bool

primitive Eq[A: Equatable[A] #read]
  """
  Equality by the `eq` method of the `Equatable` interface.
  """
  fun apply(a: A, a': A): Bool =>
    a.eq(a')

primitive EqIs[A: Any #any]
  """
  Identity equality (same object reference).
  """
  fun apply(a: A, a': A): Bool =>
    a is a'

primitive EqTuple2[A: Equatable[A] #read, B: Equatable[B] #read]
  """
  Element-wise equality for 2-tuples.
  """
  fun apply(a: (A, B), a': (A, B)): Bool =>
    a._1.eq(a'._1) and a._2.eq(a'._2)
