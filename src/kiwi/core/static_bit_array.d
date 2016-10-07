module kiwi.core.static_bit_array;

struct StaticBitArray(size_t length)
{
    import core.bitop : bts, btr, bt;
    import std.traits : TemplateArgsOf;

    enum length = TemplateArgsOf!(typeof(this))[0];

    private ubyte[lengthToBytes(length)] bits;

    private static size_t lengthToBytes(size_t length) @safe @nogc pure nothrow
    {
        enum bits = ubyte.sizeof * 8;
        return (length + (bits - 1)) / bits;
    }

    this(bool[length] values ...)
    {
        foreach (index, value ; values)
            this[index] = value;
    }

    bool opIndex(size_t index) const pure nothrow
    in
    {
        import std.format : format;

        assert(index < length,
            format("Index '%s' is out of bounds '%s'", index, length));
    }
    body
    {
        return cast(bool) bt(bitsPtr, index);
    }

    bool opIndexAssign(bool value, size_t index) pure nothrow
    in
    {
        import std.format : format;

        assert(index < length,
            format("Index '%s' is out of bounds '%s'", index, length));
    }
    body
    {
        if (value)
            bts(bitsPtr, index);
        else
            btr(bitsPtr, index);

        return value;
    }

    bool element(size_t index)() const @nogc pure nothrow
    in
    {
        import std.format : format;

        static assert(index < length,
            format("Index '%s' is out of bounds '%s'", index, length));
    }
    body
    {
        return cast(bool) bt(bitsPtr, index);
    }

    bool element(size_t index)(bool value) @nogc pure nothrow
    in
    {
        import std.format : format;

        static assert(index < length,
            format("Index '%s' is out of bounds '%s'", index, length));
    }
    body
    {
        if (value)
            bts(bitsPtr, index);
        else
            btr(bitsPtr, index);

        return value;
    }

    void all(bool value) @nogc pure nothrow @safe
    {
        bits[] = value ? 0b11111111 : 0b00000000;
    }

    private inout(size_t)* bitsPtr() @trusted @nogc pure nothrow inout
    {
        return cast(inout(size_t)*) bits.ptr;
    }
}
