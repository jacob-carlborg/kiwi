module kiwi.model.dirty_tracking;

mixin template DirtyTracking(Fields...)
{
    import kiwi.core.static_bit_array : StaticBitArray;
    import std.meta : staticIndexOf;

private:

    StaticBitArray!(Fields.length) __changedFields;

    bool fieldHasChanged(string name)()
    in
    {
        import std.format : format;
        import std.string : join;

        static assert (staticIndexOf!(name, Fields) != -1,
            format("The given field '%s' does not exist in the list of " ~
            "fields '%s'", name, [Fields].join(", ")));
    }
    body
    {
        return __changedFields[staticIndexOf!(name, Fields)];
    }

    void fieldWillChange(string name)()
    in
    {
        import std.format : format;
        import std.string : join;

        static assert (staticIndexOf!(name, Fields) != -1,
            format("The given field '%s' does not exist in the list of " ~
            "fields '%s'", name, [Fields].join(", ")));
    }
    body
    {
        __changedFields[staticIndexOf!(name, Fields)] = true;
    }
}
