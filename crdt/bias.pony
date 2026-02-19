// Bias primitives for tie-breaking in timestamp-based CRDTs.
// Used as type parameters to select conflict resolution strategy.

primitive BiasInsert
  """
  When timestamps tie, insertions override deletions.
  """

primitive BiasDelete
  """
  When timestamps tie, deletions override insertions.
  """

primitive BiasGreater
  """
  When timestamps tie, the greater value wins.
  """

primitive BiasLesser
  """
  When timestamps tie, the lesser value wins.
  """
