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

    bool opIndexAssign(bool value, size_t index)
    {
        if (value)
            bts(bitsPtr, index);
        else
            btr(bitsPtr, index);

        return value;
    }

    bool element(size_t index)() // const @nogc pure nothrow
    {
        import std.format : format;

        static assert(index < length,
            format("Index '%s' is out of bounds '%s'", index, length));

        return cast(bool) bt(bitsPtr, index);
    }

    bool element(size_t index)(bool value) // const @nogc pure nothrow
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

    private size_t* bitsPtr() @trusted @nogc pure nothrow
    {
        return cast(size_t*) bits.ptr;
    }
}
