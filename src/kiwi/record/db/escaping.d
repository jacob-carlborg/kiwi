module kiwi.record.db.escaping;

version(KiwiDatabasePostgres)
    public import kiwi.record.db.postgres.escaping;

static assert(isInterfaceImplemented,
    "The escaping interface is not implemented");

private:

bool isInterfaceImplemented()
{
    checkEscapeValue();

    return true;
}

void checkEscapeValue()
{
    enum result = __traits(compiles, { string r = escapeValue(""); });

    static assert(result, "The function 'string escapeValue(string)' is not " ~
        "implemented");
}
