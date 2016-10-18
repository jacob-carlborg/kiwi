module kiwi.model.fields;

import std.format;
import std.string;

mixin template Fields(Storage)
{
    private Storage storage;

    mixin(generateFields!(Storage));
}

string generateFields(Storage)()
{
    import std.algorithm;
    import std.array;
    import std.meta;

    import kiwi.core.reflection;

    alias generate = field => generateGetter(field.name)
        ~ "\n\n" ~ generateSetter(field.name);

    auto fields = Reflector!(Storage)().fields;
    alias generatedFields = AliasSeq!(fields.map!(generate));

    return [generatedFields].join("\n\n");
}

private:

string generateGetter(string name)
{
    auto code = q{
auto %1$s()
{
    return storage.%1$s;
}
}.strip;

    return format(code, name);
}

string generateSetter(string name)
{
    auto code = q{
auto %1$s(typeof(storage.%1$s) %1$s)
{
    static if(__traits(compiles, fieldWillChange!("%1$s")))
        fieldWillChange!("%1$s");

    return storage.%1$s = %1$s;
}
}.strip;

    return format(code, name);
}
