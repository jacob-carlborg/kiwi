module kiwi.record.model_schema;

mixin template ModelSchema(Record)
{
    import kiwi.core.reflection : Reflector;

    static Columns!(Record) columns()
    {
        auto fields = reflector!(Record).fields;
        return Columns!(Record)(fields);
    }

    static Column columns(string name)()
    {
        auto field = reflector!(Record).fields!(name);
        return Column.fromField(field);
    }

    static string tableName()
    {
        import std.string;
        import transforms.snake;

        auto name = __traits(identifier, typeof(this)).snakeCaseCT;
        return !name.endsWith("s") ? name ~ 's' : name;
    }
}

struct Columns(Record)
{
    import std.algorithm;
    import std.array;

    import kiwi.core.reflection;

    private immutable Fields!(Record) fields;
    immutable Column[] columns;

    alias columns this;

    this(Fields!(Record) fields)
    {
        alias columns = fields.map!(e => Column.fromField(e));
        this.columns = [columns];
    }

    immutable(string)[] names()
    {
        return columns.map!(e => e.name).array;
    }
}

struct Column
{
    immutable string name;

    static Column fromField(Field)(Field field)
    {
        return FieldToColumnConverter!(Field)(field).convert;
    }
}

private struct FieldToColumnConverter(Field)
{
private:
    import std.string;

    import transforms.snake;

    Field field;

    this(Field field)
    {
        this.field = field;
    }

    Column convert()
    {
        return Column(convertName());
    }

    string convertName()
    {
        return field.name.chomp("_").snakeCaseCT;
    }
}
