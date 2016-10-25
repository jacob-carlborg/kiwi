module spec.record.model_schema_spec;

import spec.spec_helper;

import kiwi.core.reflection;
import kiwi.record.model_schema;

@describe("ModelSchema")
{
    @describe("columns")
    {
        @it("returns the columns") unittest
        {
            struct Foo
            {
                mixin ModelSchema!(Record);

                static struct Record
                {
                    int bar;
                    int foo;
                }
            }

            enum columns = Foo.columns;
            columns.shouldEqual([Column("bar"), Column("foo")]);
        }
    }

    @describe("columns")
    {
        @it("returns the column with the given name") unittest
        {
            struct Foo
            {
                mixin ModelSchema!(Record);

                static struct Record
                {
                    int bar;
                    int foo;
                }
            }

            enum column = Foo.columns!("foo");
            column.shouldEqual(Column("foo"));
        }
    }

    @describe("tableName")
    {
        @it("returns the table name of the record") unittest
        {
            struct Foo
            {
                mixin ModelSchema!(Record);

                static struct Record {}
            }

            enum tableName = Foo.tableName;
            tableName.shouldEqual("foos");
        }

        @it("pluralizes the table name") unittest
        {
            struct Foo
            {
                mixin ModelSchema!(Record);

                static struct Record {}
            }

            enum tableName = Foo.tableName;
            tableName.shouldEqual("foos");
        }

        @it("converts the table name to lower snake case") unittest
        {
            struct FooBar
            {
                mixin ModelSchema!(Record);

                static struct Record {}
            }

            enum tableName = FooBar.tableName;
            tableName.shouldEqual("foo_bars");
        }
    }
}

@describe("Columns")
{
    @describe("names")
    {
        @it("returns the name of the columns") unittest
        {
            struct Record
            {
                int bar;
                int foo;
            }

            enum fields = reflector!(Record).fields;
            enum columns = Columns!(Record)(fields);

            columns.names.shouldEqual(["bar", "foo"]);
        }
    }
}

@describe("Column")
{
    @describe("fromField")
    {
        @it("converts a field to a column") unittest
        {
            struct Record
            {
                int bar;
            }

            enum field = reflector!(Record).fields!("bar");
            enum column = Column.fromField(field);

            column.shouldEqual(Column("bar"));
        }

        @it("strips a trailing underscore from the field name") unittest
        {
            struct Record
            {
                int bar_;
            }

            enum field = reflector!(Record).fields!("bar_");
            enum name = Column.fromField(field).name;

            name.shouldEqual("bar");
        }
    }
}
