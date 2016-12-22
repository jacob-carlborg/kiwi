module kiwi.record.db.postgres.to_sql;

import std.range : isOutputRange;

import kiwi.record.db.postgres.escaping;

template toSql(OutputRange) if (isOutputRange!(OutputRange, string))
{
    import std.format : formattedWrite;

    void toSql(bool value, OutputRange range)
    {
        range.put(value ? "'t'" : "'f'");
    }

    void toSql(byte value, OutputRange range)
    {
        range.formattedWrite("%s", value);
    }

    void toSql(double value, OutputRange range)
    {
        range.formattedWrite("%.100g", value);
    }

    // void toSql(T)(T value, OutputRange range) if (isSqlConvertible!T)
    // {
    //     range.formattedWrite("%s", value);
    // }
}

void toSql(OutputRange, T)(T value, OutputRange range)
    if (isOutputRange!(OutputRange, string) && convertsToSqlString!T)
{
    import std.format : formattedWrite;
    range.formattedWrite("'%s'", value);
}

private:

template convertsToSqlString(T)
{
    import std.traits;

    enum convertsToSqlString = isSomeChar!T || isSomeString!T;
}

// void toSql(T, OutputRange)(T value, OutputRange range)
//     if (isSqlConvertible!(T) && isOutputRange!(OutputRange))
// {
//     else static if (is(T == bool))
//         toSql(value);
//     else static if (is(T == byte))
//     else static if (is(T == char))
//     else static if (is(T == dchar))
//     else static if (is(T == double))
//     else static if (is(T == float))
//     else static if (is(T == int))
//     else static if (is(T == long))
//     else static if (is(T == real))
//     else static if (is(T == short))
//     else static if (is(T == ubyte))
//     else static if (is(T == uint))
//     else static if (is(T == ulong))
//     else static if (is(T == ushort))
//     else static if (is(T == wchar);)
// }
//
// template isSqlConvertible(T)
// {
//     enum isSqlConvertible =
//         is(T == bool) ||
//         is(T == byte) ||
//         // is(T == cdouble) ||
//         // is(T == cent) ||
//         // is(T == cfloat) ||
//         is(T == char) ||
//         // is(T == creal) ||
//         is(T == dchar) ||
//         is(T == double) ||
//         // is(T == enum) ||
//         is(T == float) ||
//         // is(T == idouble) ||
//         // is(T == ifloat) ||
//         is(T == int) ||
//         // is(T == ireal) ||
//         is(T == long) ||
//         is(T == real) ||
//         is(T == short) ||
//         is(T == ubyte) ||
//         // is(T == ucent) ||
//         is(T == uint) ||
//         is(T == ulong) ||
//         is(T == ushort) ||
//         is(T == wchar) ||
//
//         is(T == string)
//
//         ;
// }
// //
// // private:
// //
// //
