module spec.model.dirty_tracking_spec;

import spec.spec_helper;
import kiwi.model.dirty_tracking;

@describe("DirtyTracking")
{
    @describe("fieldHasChanged")
    {
        @context("when the field has changed")
        {
            @it("returns true") unittest
            {
                struct Foo
                {
                    mixin DirtyTracking!("foo", "bar");
                }

                Foo foo;
                foo.fieldWillChange!("foo");

                foo.fieldHasChanged!("foo").shouldBeTrue;
            }
        }

        @context("when the field has not changed")
        {
            @it("returns false") unittest
            {
                struct Foo
                {
                    mixin DirtyTracking!("foo", "bar");
                }

                Foo foo;

                foo.fieldHasChanged!("foo").shouldBeFalse;
            }
        }

        @context("when the field does not exist")
        {
            @it("will fail to compile with a static assert") unittest
            {
                struct Foo
                {
                    mixin DirtyTracking!("foo");
                }

                Foo foo;
                auto compiles = __traits(compiles, foo.fieldHasChanged!("bar"));

                compiles.shouldBeFalse;
            }
        }
    }

    @describe("fieldWillChange")
    {
        @it("marks the given field as been changed") unittest
        {
            struct Foo
            {
                mixin DirtyTracking!("foo", "bar");
            }

            Foo foo;
            foo.fieldWillChange!("foo");

            foo.fieldHasChanged!("foo").shouldBeTrue;
        }

        @context("when the field does not exist")
        {
            @it("will fail to compile with a static assert") unittest
            {
                struct Foo
                {
                    mixin DirtyTracking!("foo");
                }

                Foo foo;
                auto compiles = __traits(compiles, foo.fieldHasChanged!("bar"));

                compiles.shouldBeFalse;
            }
        }
    }

    @describe("resetChanges")
    {
        @it("resets all changes") unittest
        {
            struct Foo
            {
                mixin DirtyTracking!("foo", "bar");
            }

            Foo foo;
            foo.fieldWillChange!("foo");
            foo.fieldWillChange!("bar");
            foo.resetChanges();

            foo.fieldHasChanged!("foo").shouldBeFalse;
            foo.fieldHasChanged!("bar").shouldBeFalse;
        }
    }
}
