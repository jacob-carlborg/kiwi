module kiwi.core.allocator_range;

struct AllocatorRange(T, alias growSize)
{
    import std.experimental.allocator : IAllocator, expandArray, makeArray;

    private
    {
        IAllocator allocator;
        T[] buffer;
        size_t usedSize;
    }

    this(IAllocator allocator, size_t initialSize)
    {
        import core.exception : onOutOfMemoryError;

        this.allocator = allocator;
        buffer = allocator.makeArray!T(initialSize);

        if (!buffer)
            onOutOfMemoryError();
    }

    @disable this(this);

    ~this()
    {
        // allocator.dispose(buffer);
        buffer = null;
    }

    void put(T c)
    {
        import std.algorithm : moveEmplace;
        import std.exception : enforce;
        import core.exception : OutOfMemoryError;

        if (usedSize == buffer.length)
        {
            enforce!OutOfMemoryError(
                allocator.expandArray(buffer, growSize(buffer.length))
            );
        }

        moveEmplace(c, buffer[usedSize++]);
    }

    T[] data()
    {
        auto data = buffer[0 .. usedSize];
        buffer = null;
        return data;
    }
}
