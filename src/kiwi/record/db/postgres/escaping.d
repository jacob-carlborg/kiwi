module kiwi.record.db.postgres.escaping;

import std.string;

string escapeValue(string value)
{
    return value.replace("'", "''");
}

string escapeTableName(string name)
{
    return name.replace(`"`, `""`);
}

string escapeColumnName(string name)
{
    return name.replace(`"`, `""`);
}
