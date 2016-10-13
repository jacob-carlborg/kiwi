module spec.core.reflection.reflector_spec;

import std.algorithm;
import std.meta;

import spec.spec_helper;
import kiwi.core.reflection;

@describe("reflector")
{
    @it("returns a reflector") unittest
    {
        struct Foo {}
        Foo value;

        value.reflector.shouldEqual(Reflector!(Foo)(value));
    }
}

@describe("Reflector")
{
    @describe("fields")
    {
        @it("returns the fields of the associated aggregate") unittest
        {
            struct Foo
            {
                int bar;
                int foo;
            }

            Foo value;
            alias expected = AliasSeq!(Field!("bar", 0), Field!("foo", 1));

            static assert(is(value.reflector.fields.fields == expected));
        }
    }

    @describe("fields")
    {
        @it("returns the field for the given name") unittest
        {
            struct Foo
            {
                int bar;
                int foo;
            }

            auto value = Foo(3);
            auto field = value.reflector.fields!("bar");
            auto expected = FieldWithValue!(Foo, "bar", 0)(&value);

            static assert(field.name == expected.name);
            static assert(field.index == expected.index);
        }
    }
}

@describe("Fields")
{
    @describe("filter")
    {
        @it("returns the fields matching the given predicate") unittest
        {
            struct Foo
            {
                int bar;
                int foo;
            }

            Foo value;
            alias result = value.reflector.fields.filter!(e => e.name == "foo");
            alias expected = AliasSeq!(Field!("foo", 1));

            static assert(is(result == expected));
        }
    }

    @describe("map")
    {
        @it("returns a new tuple with the result of the given lambda") unittest
        {
            struct Foo
            {
                int bar;
                int foo;
            }

            Foo value;
            auto fields = value.reflector.fields;
            alias result = fields.map!(e => e.name);

            static assert(result == AliasSeq!("bar", "foo"));
        }

        @context("mapping the indexes")
        {
            @it("returns a tuple with the indexes") unittest
            {
                struct Foo
                {
                    int bar;
                    int foo;
                }

                Foo value;
                auto fields = value.reflector.fields;
                alias result = fields.map!(e => e.index);

                static assert(result == AliasSeq!(0, 1));
            }
        }
    }
}

@describe("Field")
{
    @describe("name")
    {
        @it("returns the name of the field") unittest
        {
            struct Foo
            {
                int foo;
                int bar;
            }

            Foo value;
            static assert(value.reflector.fields!("bar").name == "bar");
        }
    }

    @describe("index")
    {
        @it("returns the index of the field") unittest
        {
            struct Foo
            {
                int foo;
                int bar;
            }

            Foo value;
            static assert(value.reflector.fields!("bar").index == 1);
        }
    }
}

@describe("FieldWithValue")
{
    @describe("name")
    {
        @it("returns the name of the field") unittest
        {
            struct Foo
            {
                int foo;
                int bar;
            }

            Foo value;
            static assert(value.reflector.fields!("bar").name == "bar");
        }
    }

    @describe("index")
    {
        @it("returns the index of the field") unittest
        {
            struct Foo
            {
                int foo;
                int bar;
            }

            Foo value;
            static assert(value.reflector.fields!("bar").index == 1);
        }
    }

    @describe("type")
    {
        @it("returns an object representing the type of the field") unittest
        {
            struct Foo
            {
                int foo;
                int bar;
            }

            Foo value;
            enum type = value.reflector.fields!("bar").type;

            static assert(type == Type!(int)());
        }
    }

    @describe("value")
    {
        @it("returns the value of the field") unittest
        {
            struct Foo
            {
                int bar;
                int foo;
            }

            Foo value = { bar: 3, foo: 4 };
            auto field = value.reflector.fields!("foo");

            field.value.shouldEqual(value.foo);
        }
    }

    @describe("value =")
    {
        @it("sets the value") unittest
        {
            struct Foo
            {
                int bar;
                int foo;
            }

            Foo value = { bar: 3, foo: 4 };
            auto field = value.reflector.fields!("foo");
            field.value = 5;

            value.foo.shouldEqual(5);
        }
    }
}

@describe("Type")
{
    @describe("name")
    {
        @it("returns the name of the type") unittest
        {
            static assert(Type!(int).name == "int");
        }
    }

    @describe("nativeType")
    {
        @it("evaluates to native D type hold by Type") unittest
        {
            static assert(is(Type!(int).nativeType == int));
        }
    }
}
