module kiwi.record.db.escaping;

version(KiwiDatabasePostgres)
    public import kiwi.record.db.postgres.escaping;

static assert(isInterfaceImplemented,
    "The escaping interface is not implemented");

private:

bool isInterfaceImplemented()
{
    checkEscapeValue();
    checkEscapeTableName();
    checkEscapeColumnName();

    return true;
}

void checkEscapeValue()
{
    enum result = __traits(compiles, { string r = escapeValue(""); });

    static assert(result, "The function 'string escapeValue(string)' is not " ~
        "implemented");
}

void checkEscapeTableName()
{
    enum result = __traits(compiles, { string r = escapeTableName(""); });

    static assert(result, "The function " ~
        "'string escapeTableName(string)' is not implemented");
}

void checkEscapeColumnName()
{
    enum result = __traits(compiles, { string r = escapeColumnName(""); });

    static assert(result, "The function " ~
        "'string escapeColumnName(string)' is not implemented");
}
