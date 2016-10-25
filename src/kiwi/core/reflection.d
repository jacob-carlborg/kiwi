/**
 * This module contains an API to for reflection.
 *
 * $(I Reflection) is the ability of code to inspect and modify itself.
 * The $(REF Reflector, kiwi, core, reflection) is the main interface to the
 * reflection API and all information is available through this API.
 *
 * The $(REF reflector, kiwi, core, reflection) function is used to create a new
 * `Reflector`.
 */
module kiwi.core.reflection;

import std.meta;
import std.range;
import std.traits;
import std.typecons;

///
unittest
{
    import std.meta;

    struct Foo
    {
        int bar;
    }

    Foo foo;
    auto fields = foo.reflector.fields;
    alias names = fields.map!(e => e.name);

    static assert(names == AliasSeq!("bar"));
}

/// Get/set the value of a field using its name
unittest
{
    import std.algorithm;

    struct Foo
    {
        int bar;
    }

    Foo foo;
    auto field = foo.reflector.fields!("bar");
    field.value = 3;

    assert(field.value == 3);
}

/**
 * This represents the main interface to the reflection API.
 *
 * All information is available through Reflectors.
 *
 * Params:
 *      T = the type to reflection upon. Has to be an aggregate
 *
 * See_Also: $(REF reflector, kiwi, core, reflection)
 */
struct Reflector(T) if (isAggregateType!(T))
{
    T* value;

    this(ref T value)
    {
        this.value = &value;
    }

    /**
     * Returns: a proxy to all fields of the aggregate this reflector belongs
     *      to.
     */
    Fields!(T) fields()
    {
        return Fields!(T).init;
    }

    /**
     * Returns the field of the given name.
     *
     * Params:
     *      name = the name of the field to retrieve
     *
     * Returns: the field of the given name. The return type is an instance of
     *      $(REF FieldWithValue, kiwi, core, reflection)
     *
     * See_Also:
     *      $(LI $(REF fields, kiwi, core, reflection))
     *      $(LI $(REF FieldWithValue, kiwi, core, reflection))
     */
    auto fields(string name)()
    {
        enum toName(alias e) = e.name;
        enum names = staticMap!(toName, Fields!(T).fields);
        enum index = staticIndexOf!(name, names);

        return FieldWithValue!(T, name, index)(value);
    }
}

/**
 * Creates a new reflector for the given value. $(FOO)
 *
 * Params:
 *      T = the type of the given value. Has to be an aggregate
 *      value = the value to create the reflector for
 *
 * Returns: a reflector for the given value.
 * See_Also: $(REF Reflector, kiwi, core, reflection)
 */
Reflector!(T) reflector(T)(ref T value) if (isAggregateType!(T))
{
    return Reflector!(T)(value);
}

/**
 * Creates a new reflector for the given type.
 *
 * Params:
 *      T = the type of the given value. Has to be an aggregate
 *
 * Returns: a reflector for the given type.
 * See_Also: $(REF Reflector, kiwi, core, reflection)
 */
Reflector!(T) reflector(T)() if (isAggregateType!(T))
{
    return Reflector!(T).init;
}

unittest
{
    import std.meta;

    struct Foo
    {
        int bar;
    }

    Foo foo;
    auto fields = foo.reflector.fields;
    alias names = fields.map!(e => e.name);

    static assert(names == AliasSeq!("bar"));
}

/**
 * This struct acts as a proxy through which all fields can be accessed.
 *
 * Params:
 *      T = the type of the aggregate the proxy is inspecting
 */
struct Fields(T)
{
    private static
    {
        alias toField(alias e) = Field!(__traits(identifier, e),
            staticIndexOf!(e, T.tupleof));

        enum toName(alias e) = e.name;
        enum toIndex(alias e) = e.index;

        alias fields = staticMap!(toField, T.tupleof);
    }

    alias fields this;

    /// Returns: a new tuple with the fields matching the given predicate
    static alias filter(alias lambda) = lambdaFilter!(lambda, fields);

    /// Returns: a new tuple with the result of the lambda for each field
    static alias map(alias lambda) = lambdaMap!(lambda, fields);
}

///
unittest
{
    import std.meta;

    struct Foo
    {
        int foo;
        int bar;
    }

    Foo foo;
    auto fields = foo.reflector.fields;
    alias names = fields.map!(e => e.name);

    static assert(names == AliasSeq!("foo", "bar"));
}

/**
 * This struct represents a field in the reflection API.
 *
 * Params:
 *      name = the name of the field
 *      index = the index of the field
 */
struct Field(string name, size_t index)
{
    /// Returns: the name of the field.
    enum name = TemplateArgsOf!(typeof(this))[0];

    /// Returns: the index of the field.
    enum index = TemplateArgsOf!(typeof(this))[1];
}

///
unittest
{
    import std.algorithm;

    struct Foo
    {
        int foo;
        int bar;
    }

    Foo foo;
    alias field = foo.reflector.fields.fields[1];

    static assert(field.name == "bar");
    static assert(field.index == 1);
}

/**
 * This struct represents a field, including access the value of the field,
 * in the reflection API.
 *
 * Params:
 *      T = the type of the field
 *      name = the name of the field
 *      index = the index of the field
 */
struct FieldWithValue(T, string name, size_t index)
{
    /// Returns: the name of the field
    enum name = TemplateArgsOf!(typeof(this))[1];

    /// Returns: the index of the field
    enum index = TemplateArgsOf!(typeof(this))[2];

    /// Returns: the type of the field
    enum type = Type!(typeof(T.tupleof[index]))();

    private T* aggregate;

    /**
     * Constructs a new instance of this struct.
     *
     * Params:
     *      aggregate = a pointer the aggregate this field belongs to
     *
     * Preconditions:
     *      aggregate = may not be `null`
     */
    this(T* aggregate)
    in
    {
        assert(aggregate !is null, "aggregate is null");
    }
    body
    {
        this.aggregate = aggregate;
    }

    /// Returns: the value of the field.
    auto value()
    {
        assert(aggregate !is null, "aggregate is null");
        return aggregate.tupleof[index];
    }

    /// Sets the given value of the field.
    void value(U)(U value)
    {
        assert(aggregate !is null, "aggregate is null");
        aggregate.tupleof[index] = value;
    }
}

///
unittest
{
    import std.algorithm;

    struct Foo
    {
        int foo;
        int bar;
    }

    Foo foo;
    auto field = foo.reflector.fields!("bar");
    field.value = 3;

    static assert(field.name == "bar");
    static assert(field.index == 1);

    assert(field.value == 3);
}

/**
 * This struct represents the type of a field in the reflection API.
 *
 * Params:
 *      T = the type of the field
 */
struct Type(T)
{
    /// Evaluates to the native D type this struct holds.
    alias nativeType = T;

    /// Returns: the name of the type
    enum name = T.stringof;
}

///
unittest
{
    struct Foo
    {
        int foo;
        int bar;
    }

    Foo foo;
    auto type = foo.reflector.fields!("bar").type;

    static assert(type.name == "int");
    static assert(is(type.nativeType == int));
}

private template lambdaFilter(alias pred, TList...)
{
    static if (TList.length == 0)
    {
        alias lambdaFilter = AliasSeq!();
    }
    else static if (TList.length == 1)
    {
        static if (pred(TList[0].init))
            alias lambdaFilter = AliasSeq!(TList[0]);
        else
            alias lambdaFilter = AliasSeq!();
    }
    else
    {
        alias lambdaFilter =
            AliasSeq!(
                lambdaFilter!(pred, TList[ 0  .. $/2]),
                lambdaFilter!(pred, TList[$/2 ..  $ ]));
    }
}

private template lambdaMap(alias F, T...)
{
    static if (T.length == 0)
    {
        alias lambdaMap = AliasSeq!();
    }
    else static if (T.length == 1)
    {
        alias lambdaMap = AliasSeq!(F(T[0].init));
    }
    else
    {
        alias lambdaMap =
            AliasSeq!(
                lambdaMap!(F, T[ 0  .. $/2]),
                lambdaMap!(F, T[$/2 ..  $ ]));
    }
}
