module spec.model.fields_spec;

import spec.spec_helper;
import kiwi.model.fields;

@describe("Fields")
{
    @it("generates a getter for the attributes of given type") unittest
    {
        struct Foo
        {
            mixin Fields!(Storage);

            static struct Storage
            {
                int a;
                string b;
            }
        }

        Foo foo;

        __traits(compiles, { int a = foo.a; }).shouldEqual(true);
        __traits(compiles, { string a = foo.b; }).shouldEqual(true);
    }

    @it("generates a setter for the attributes of given type") unittest
    {
        struct Foo
        {
            mixin Fields!(Storage);

            static struct Storage
            {
                int a;
                string b;
            }
        }

        Foo foo;

        __traits(compiles, { foo.a = 3; }).shouldEqual(true);
        __traits(compiles, { foo.b = "asd"; }).shouldEqual(true);
    }
}
