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
