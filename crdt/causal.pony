trait Causal[A: Causal[A] ref] is (Convergent[A] & Replicated)
  """
  A convergent, serializable CRDT that uses dot-based causal tracking.
  Types implementing this trait support creation under a replica id,
  convergent merging, token-based serialization, and clearing all local state.
  """
  new ref create(id: ID)
  fun ref clear[D: A ref = A](delta': D = recover D(0) end): D
