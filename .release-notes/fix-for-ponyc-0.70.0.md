## Fixed to work with ponyc 0.70.0

ponyc 0.70.0 changed how type parameter constraints handle bare type names: a type name without an explicit capability now gets the type's default capability instead of `#any`. Intersection constraints that mixed explicit and bare capabilities stopped compiling because the bare side defaulted to `ref` instead of matching the explicit `val`.

Added explicit `val` capabilities to `Equatable` and `Hashable` in all affected type aliases.
