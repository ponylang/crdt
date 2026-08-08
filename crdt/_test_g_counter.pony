use "pony_test"

class \nodoc\ _TestGCounter is UnitTest
  new iso create() => None
  fun name(): String => "crdt.GCounter"

  fun apply(h: TestHelper) =>
    let a = GCounter("a".hash64())
    let b = GCounter("b".hash64())
    let c = GCounter("c".hash64())

    a.increment(1)
    b.increment(2)
    c.increment(3)

    h.assert_eq[U64](a.value(), 1)
    h.assert_eq[U64](b.value(), 2)
    h.assert_eq[U64](c.value(), 3)
    h.assert_ne[GCounter](a, b)
    h.assert_ne[GCounter](b, c)
    h.assert_ne[GCounter](c, a)

    h.assert_false(a.converge(a))

    h.assert_true(a.converge(b))
    h.assert_true(a.converge(c))
    h.assert_true(b.converge(c))
    h.assert_true(b.converge(a))
    h.assert_true(c.converge(a))
    h.assert_false(c.converge(b))

    h.assert_eq[U64](a.value(), 6)
    h.assert_eq[U64](b.value(), 6)
    h.assert_eq[U64](c.value(), 6)
    h.assert_eq[GCounter](a, b)
    h.assert_eq[GCounter](b, c)
    h.assert_eq[GCounter](c, a)

    a.increment(9)
    b.increment(8)
    c.increment(7)

    h.assert_eq[U64](a.value(), 15)
    h.assert_eq[U64](b.value(), 14)
    h.assert_eq[U64](c.value(), 13)
    h.assert_ne[GCounter](a, b)
    h.assert_ne[GCounter](b, c)
    h.assert_ne[GCounter](c, a)

    h.assert_true(a.converge(b))
    h.assert_true(a.converge(c))
    h.assert_true(b.converge(c))
    h.assert_true(b.converge(a))
    h.assert_true(c.converge(a))
    h.assert_false(c.converge(b))

    h.assert_eq[U64](a.value(), 30)
    h.assert_eq[U64](b.value(), 30)
    h.assert_eq[U64](c.value(), 30)
    h.assert_eq[GCounter](a, b)
    h.assert_eq[GCounter](b, c)
    h.assert_eq[GCounter](c, a)

class \nodoc\ _TestGCounterDelta is UnitTest
  new iso create() => None
  fun name(): String => "crdt.GCounter (ẟ)"

  fun apply(h: TestHelper) =>
    let a = GCounter("a".hash64())
    let b = GCounter("b".hash64())
    let c = GCounter("c".hash64())

    var a_delta = a.increment(1)
    var b_delta = b.increment(2)
    var c_delta = c.increment(3)

    h.assert_eq[U64](a.value(), 1)
    h.assert_eq[U64](b.value(), 2)
    h.assert_eq[U64](c.value(), 3)
    h.assert_ne[GCounter](a, b)
    h.assert_ne[GCounter](b, c)
    h.assert_ne[GCounter](c, a)

    h.assert_false(a.converge(a_delta))

    h.assert_true(a.converge(b_delta))
    h.assert_true(a.converge(c_delta))
    h.assert_true(b.converge(c_delta))
    h.assert_true(b.converge(a_delta))
    h.assert_true(c.converge(a_delta))
    h.assert_true(c.converge(b_delta))

    h.assert_eq[U64](a.value(), 6)
    h.assert_eq[U64](b.value(), 6)
    h.assert_eq[U64](c.value(), 6)
    h.assert_eq[GCounter](a, b)
    h.assert_eq[GCounter](b, c)
    h.assert_eq[GCounter](c, a)

    a_delta = a.increment(9)
    b_delta = b.increment(8)
    c_delta = c.increment(7)

    h.assert_eq[U64](a.value(), 15)
    h.assert_eq[U64](b.value(), 14)
    h.assert_eq[U64](c.value(), 13)
    h.assert_ne[GCounter](a, b)
    h.assert_ne[GCounter](b, c)
    h.assert_ne[GCounter](c, a)

    h.assert_true(a.converge(b_delta))
    h.assert_true(a.converge(c_delta))
    h.assert_true(b.converge(c_delta))
    h.assert_true(b.converge(a_delta))
    h.assert_true(c.converge(a_delta))
    h.assert_true(c.converge(b_delta))

    h.assert_eq[U64](a.value(), 30)
    h.assert_eq[U64](b.value(), 30)
    h.assert_eq[U64](c.value(), 30)
    h.assert_eq[GCounter](a, b)
    h.assert_eq[GCounter](b, c)
    h.assert_eq[GCounter](c, a)

class \nodoc\ _TestGCounterTokens is UnitTest
  new iso create() => None
  fun name(): String => "crdt.GCounter (tokens)"

  fun apply(h: TestHelper) =>
    let data    = GCounter[U8]("a".hash64())
    let data_b  = GCounter[U8]("b".hash64())
    let data_c  = GCounter[U8]("c".hash64())

    data.increment(4)
    data_b.increment(5)
    data_c.increment(6)

    data.converge(data_b)
    data.converge(data_c)

    let tokens = Tokens .> from(data)
    _TestTokensWellFormed(h, tokens)

    try
      h.assert_eq[GCounter[U8]](
        data,
        data.create(0) .> from_tokens(tokens.iterator())?
      )
    else
      h.fail("failed to parse token stream")
    end

class \nodoc\ _TestGCounterMax is UnitTest
  new iso create() => None
  fun name(): String => "crdt.GCounter (max)"

  fun apply(h: TestHelper) =>
    let data    = GCounter[U8]("a".hash64())
    let data_b  = GCounter[U8]("b".hash64())
    let data_c  = GCounter[U8]("c".hash64())

    data.increment(250)
    data_b.increment(253)
    data_c.increment(254)

    h.assert_true(data.converge(data_b))
    h.assert_true(data.converge(data_c))
    h.assert_true(data_b.converge(data))
    h.assert_false(data_b.converge(data_c)) // data_b == data_c
    h.assert_true(data_c.converge(data))
    h.assert_false(data_c.converge(data_b)) // data_c == data_b

    data.increment(7)
    data_c.increment(1)

    h.assert_true(data_c.converge(data))
    h.assert_false(data_c.converge(data_b)) // data_c > data_b

    h.assert_eq[U8](data.value(), U8.max_value())
    h.assert_eq[U8](data_b.value(), U8.max_value())
    h.assert_eq[U8](data_c.value(), U8.max_value())

    data.increment(42)
    h.assert_eq[U8](data.value(), U8.max_value())
