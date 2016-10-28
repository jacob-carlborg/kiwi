module kiwi.record.db.postgres.escaping;

import std.string;

string escapeValue(string value)
{
    return value.replace("'", "''");
}
