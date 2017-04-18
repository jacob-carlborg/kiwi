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

@describe("toSql(double)")
{
    @context(`when a the value is 0`)
    {
        @it(`converts the value to "0"`) unittest
        {
            double(0).toSql.shouldEqual("0");
        }
    }

    @context(`when a the value is 0.1`)
    {
        @it(`converts the value to "0.1"`) unittest
        {
            double(0.1).toSql.shouldEqual("0.1");
        }
    }

    @context(`when a the value is 1_000_000`)
    {
        @it(`converts the value to "1000000"`) unittest
        {
            double(1_000_000).toSql.shouldEqual("1000000");
        }
    }

    @context(`when a the value is 0.12345678945678912`)
    {
        @it(`converts the value to "0.12345678945678912"`) unittest
        {
            double(0.12345678945678912).toSql.shouldEqual("0.123456789456789");
        }
    }

    @context(`when a the value is 0.00005`)
    {
        @it(`converts the value to "5e-05"`) unittest
        {
            double(0.00005).toSql.shouldEqual("5e-05");
        }
    }
}

@describe("toSql(float)")
{
    @context(`when a the value is 0`)
    {
        @it(`converts the value to "0"`) unittest
        {
            float(0).toSql.shouldEqual("0");
        }
    }

    @context(`when a the value is 0.1`)
    {
        @it(`converts the value to "0.1"`) unittest
        {
            float(0.1).toSql.shouldEqual("0.1");
        }
    }

    @context(`when a the value is 1_000_000`)
    {
        @it(`converts the value to "1e+06"`) unittest
        {
            float(1_000_000).toSql.shouldEqual("1e+06");
        }
    }

    @context(`when a the value is 0.123457`)
    {
        @it(`converts the value to "0.123457"`) unittest
        {
            float(0.123457).toSql.shouldEqual("0.123457");
        }
    }

    @context(`when a the value is 0.00005`)
    {
        @it(`converts the value to "5e-05"`) unittest
        {
            float(0.00005).toSql.shouldEqual("5e-05");
        }
    }
}

@describe("toSql(real)")
{
    @context(`when a the value is 0`)
    {
        @it(`converts the value to "0"`) unittest
        {
            real(0).toSql.shouldEqual("0");
        }
    }

    @context(`when a the value is 0.1`)
    {
        @it(`converts the value to "0.1"`) unittest
        {
            real(0.1).toSql.shouldEqual("0.1");
        }
    }

    @context(`when a the value is 1_000_000`)
    {
        @it(`converts the value to "1000000"`) unittest
        {
            real(1_000_000).toSql.shouldEqual("1000000");
        }
    }

    @context(`when a the value is 0.123456789456789121`)
    {
        @it(`converts the value to "0.123456789456789121"`) unittest
        {
            real(0.123456789456789121).toSql.shouldEqual("0.123456789456789121");
        }
    }

    @context(`when a the value is 0.00005`)
    {
        @it(`converts the value to "5e-05"`) unittest
        {
            real(0.00005).toSql.shouldEqual("5e-05");
        }
    }
}
