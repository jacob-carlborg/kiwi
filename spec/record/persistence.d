module spec.record.persistence;

import spec.spec_helper;
import kiwi.record.persistence;
import kiwi.model.dirty_tracking;

@describe("Persistence")
{
    @describe("isNewRecord")
    {
        @context("initial state")
        {
            @it("returns true") unittest
            {
                struct Foo
                {
                    mixin Persistence!("foo", "bar");

                    int foo;
                    int bar;
                }

                Foo foo;
                foo.isNewRecord.shouldEqual(true);
            }
        }
    }

    @describe("isNewRecord")
    {
        @context("initial state")
        {
            @it("returns false") unittest
            {
                struct Foo
                {
                    mixin Persistence!("foo", "bar");

                    int foo;
                    int bar;
                }

                Foo foo;
                foo.isPersisted.shouldEqual(false);
            }
        }
    }
}
