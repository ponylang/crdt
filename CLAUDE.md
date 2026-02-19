# crdt

Conflict-free replicated data types for Pony.

## Building and Testing

```bash
make                    # build tests + examples (release)
make test               # same as above
make config=debug       # debug build
make build-examples     # examples only
make clean              # clean build artifacts + corral cache
```

## Project Status

The API might change but it is usable in production software.

## Project Structure

All source files live in `crdt/` (flat layout, no subpackages). Test files are prefixed with `_test_` or `_prop_` and use `_`-prefixed class names for privacy. The test runner is `crdt/_test.pony`.

### CRDT Types

- **Counters**: `GCounter` (g_counter.pony), `PNCounter` (pn_counter.pony), `CCounter` (c_counter.pony)
- **Sets**: `GSet`/`GHashSet` (g_set.pony), `P2Set`/`P2HashSet` (p2_set.pony), `TSet`/`THashSet` (t_set.pony), `AWORSet`/`AWORHashSet` (awor_set.pony), `RWORSet`/`RWORHashSet` (rwor_set.pony)
- **Registers**: `TReg` (t_reg.pony), `MVReg`/`MVHashReg` (mv_reg.pony)
- **Collections**: `TLog` (t_log.pony), `CKeyspace`/`HashCKeyspace` (c_keyspace.pony)

### Interfaces and Internal Abstractions

- **Interfaces**: `Convergent` (convergent.pony, trait), `Replicated` (replicated.pony, interface), `Causal` (causal.pony, trait)
- **Types**: `ID` (id.pony), `Bias*` primitives (bias.pony)
- **Serialization**: `Tokens`/`TokensIterator` (tokens.pony)
- **Internal**: `_Dot` (_dot.pony), `DotContext` (dot_context.pony), `DotKernel` (dot_kernel.pony), `DotKernelSingle` (dot_kernel_single.pony), `DotChecklist` (dot_checklist.pony), `Eq`/`EqIs`/`EqTuple2` (eq.pony), `_Math` (_math.pony), `_DefaultValueFn` (_default_value_fn.pony)

## Key Design Patterns

- All CRDT mutator methods accept and return a convergent delta-state
- `Convergent` and `Causal` are traits (not interfaces) because they have private methods (`_create_in`, `_converge_empty_in`)
- Hash-based types come in pairs: a convenience type alias (e.g., `GSet`) using `HashEq` and a generic class (e.g., `GHashSet`) parameterized by `HashFunction`
- `CKeyspace` composes CRDTs under named keys with a shared `DotContext`
