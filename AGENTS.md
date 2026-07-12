# crdt

Conflict-free replicated data types for Pony.

<!-- contributor-only -->
## Contributing with an AI assistant

This is a Pony project. The ponylang org maintains a set of LLM coding skills. Get set up with them before contributing:

- **Not set up yet?** Install them once:

  ```bash
  git clone https://github.com/ponylang/llm-skills.git
  cd llm-skills
  python install.py
  ```

- **Already set up?** Make sure you're on the latest. If you installed with the script above, `git pull` in the directory where you cloned `llm-skills` and the symlinked skills update automatically — if you set them up another way, refresh them however that setup expects.

See the [llm-skills README](https://github.com/ponylang/llm-skills) for details and other harnesses.

When you start working on this project, load the `pony-skills` skill — it tells your assistant which Pony skill to use for each task.

Read [CONTRIBUTING.md](CONTRIBUTING.md).
<!-- /contributor-only -->

## Building and testing

```bash
make                     # build + run tests, build examples (test is the default)
make test                # same as make
make test-one t=TestName # run a single test by name
make examples            # examples only
make config=debug        # debug build
make clean               # clean build artifacts + corral cache
```

## Design

Every CRDT is delta-state: a mutator both applies the change and returns a convergent delta that can be merged into any replica. `Convergent` and `Causal` are traits rather than interfaces because they carry private methods (`_create_in`, `_converge_empty_in`). Hash-based types come in pairs — a convenience alias over `HashEq` (for example `GSet`) and a generic class parameterized by `HashFunction` (for example `GHashSet`).

## Conventions

- Test files are prefixed `_test_` or `_prop_` (property tests), use `_`-prefixed private class names, and are registered in `crdt/_test.pony`.
