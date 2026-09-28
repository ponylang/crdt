use "pony_test"

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
    test.property(_GCounterIncProperty)
    test.property(_CCounterIncProperty)
    test.property(_CCounterIncDecProperty)
    test.property(_PNCounterIncProperty)
    test.property(_PNCounterIncDecProperty)
