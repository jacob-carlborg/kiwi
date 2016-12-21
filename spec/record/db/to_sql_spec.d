module spec.record.db.to_sql_spec;

import spec.spec_helper;

static import kiwi.record.db.to_sql;
import std.array;

string toSql(T)(T value)
{
    auto buffer = appender!string();
    kiwi.record.db.to_sql.toSql(value, buffer);

    return buffer.data;
}

@describe("toSql(bool)")
{
    @context("when a the value is false")
    {
        @it(`converts the value to "'f'"`) unittest
        {
            false.toSql.shouldEqual("'f'");
        }
    }

    @context("when a the value is true")
    {
        @it(`converts the value to "'t'"`) unittest
        {
            true.toSql.shouldEqual("'t'");
        }
    }
}

@describe("toSql(byte)")
{
    @context("when a the value is 0")
    {
        @it(`converts the value to "0"`) unittest
        {
            byte(0).toSql.shouldEqual("0");
        }
    }

    @context("when a the value is true")
    {
        @it(`converts the value to "'t'"`) unittest
        {
            byte(5).toSql.shouldEqual("5");
        }
    }
}

@describe("toSql(char)")
{
    @context(`when a the value is 'a'`)
    {
        @it(`converts the value to "'a'"`) unittest
        {
            'a'.toSql.shouldEqual("'a'");
        }
    }
}

@describe("toSql(dchar)")
{
    @context(`when a the value is 'a'`)
    {
        @it(`converts the value to "'a'"`) unittest
        {
            dchar('a').toSql.shouldEqual("'a'");
        }
    }

    @context(`when a the value is '☃'`)
    {
        @it(`converts the value to "'☃'"`) unittest
        {
            '☃'.toSql.shouldEqual("'☃'");
        }
    }
}

@describe("toSql(wchar)")
{
    @context(`when a the value is 'a'`)
    {
        @it(`converts the value to "'a'"`) unittest
        {
            wchar('a').toSql.shouldEqual("'a'");
        }
    }

    @context(`when a the value is 'ö'`)
    {
        @it(`converts the value to "'ö'"`) unittest
        {
            'ö'.toSql.shouldEqual("'ö'");
        }
    }
}
