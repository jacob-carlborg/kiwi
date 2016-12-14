module kiwi.record.db.to_sql;

version(KiwiDatabasePostgres)
    public import kiwi.record.db.postgres.to_sql;

static assert(isInterfaceImplemented,
    "The toSql interface is not implemented");

private:

struct OutputRange
{
    void put(string){}
    void put(char){}
}

bool isInterfaceImplemented()
{
    checkToSql!(bool);
    checkToSql!(byte);
    checkToSql!(char);
    checkToSql!(dchar);

    return true;
}

void checkToSql(T)()
{
    import std.format;

    enum result = __traits(compiles, { T.init.toSql(OutputRange()); });

    static assert(result, format("The function 'void toSql(%s, OutputRange)' " ~
        "is not implemented", T.stringof));
}
