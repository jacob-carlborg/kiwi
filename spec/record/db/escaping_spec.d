module spec.record.db.escaping_spec;

import spec.spec_helper;

import kiwi.record.db.escaping;

@describe("escapeValue")
{
    @context("when a value contains a '")
    {
        @it("escapes the value") unittest
        {
            escapeValue("f'oo").shouldEqual("f''oo");
        }
    }

    @context("when a value does not contain a '")
    {
        @it("returns the value unchanged") unittest
        {
            escapeValue("foo").shouldEqual("foo");
        }
    }
}

@describe("escapeTableName")
{
    @context(`when the given name contains a "`)
    {
        @it("escapes the name") unittest
        {
            escapeTableName(`f"oo`).shouldEqual(`f""oo`);
        }
    }

    @context(`when the given name does not contain a "`)
    {
        @it("returns the name unchanged") unittest
        {
            escapeTableName("foo").shouldEqual("foo");
        }
    }
}
