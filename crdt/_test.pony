use "pony_test"
use "pony_check"

actor \nodoc\ Main is TestList
  new create(env: Env) => PonyTest(env, this)
  new make() => None

  fun tag tests(test: PonyTest) =>
    // Counters
    test(_TestGCounter)
    test(_TestGCounterDelta)
    test(_TestGCounterTokens)
    test(_TestGCounterMax)
    test(_TestPNCounter)
    test(_TestPNCounterDelta)
    test(_TestPNCounterTokens)
    test(_TestCCounter)
    test(_TestCCounterDelta)
    test(_TestCCounterTokens)

    // Sets
    test(_TestGSet)
    test(_TestGSetDelta)
    test(_TestGSetTokens)
    test(_TestP2Set)
    test(_TestP2SetDelta)
    test(_TestP2SetTokens)
    test(_TestTSet)
    test(_TestTSetDelta)
    test(_TestTSetTokens)
    test(_TestAWORSet)
    test(_TestAWORSetDelta)
    test(_TestAWORSetTokens)
    test(_TestRWORSet)
    test(_TestRWORSetDelta)
    test(_TestRWORSetTokens)

    // Registers
    test(_TestTReg)
    test(_TestTRegDelta)
    test(_TestTRegTokens)
    test(_TestMVReg)
    test(_TestMVRegDelta)
    test(_TestMVRegTokens)

    // Collections
    test(_TestTLog)
    test(_TestTLogDelta)
    test(_TestTLogTokens)
    test(_TestCKeyspace)
    test(_TestCKeyspaceDelta)
    test(_TestCKeyspaceTokens)

    // Property-based tests
    test(Property1UnitTest[
      (USize, Array[_CmdOnReplica[U64]])](_GCounterIncProperty))
    test(Property1UnitTest[
      (USize, Array[_CmdOnReplica])](_CCounterIncProperty))
    test(Property1UnitTest[
      (USize, Array[_CmdOnReplica])](_CCounterIncDecProperty))
    test(Property1UnitTest[
      (USize, Array[_CmdOnReplica[_PNCounterCmd]])](_PNCounterIncProperty))
    test(Property1UnitTest[
      (USize, Array[_CmdOnReplica[_PNCounterCmd]])](
      _PNCounterIncDecProperty))
