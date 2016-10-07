module spec.core.static_bit_array_spec;

import spec.spec_helper;
import kiwi.core.static_bit_array;

@describe("StaticBitArray")
{
    @describe("this")
    {
        @it("initializes the array") unittest
        {
            StaticBitArray!(1) array;
            array.element!(0).shouldBeFalse;
        }

        @context("when values are given")
        {
            @it("initializes the array with the given values") unittest
            {
                auto array = StaticBitArray!(2)(true, true);
                auto result = [array.element!(0), array.element!(1)];

                result.shouldEqual([true, true]);
            }

            @context("when the given values are too many")
            {
                @it("doesn't compile") unittest
                {
                    auto result = __traits(compiles,
                        { auto array = StaticBitArray!(1)(true, true); }
                    );

                    result.shouldBeFalse;
                }
            }
        }
    }

    @describe("this[size_t]")
    {
        @it("gets the element at the specified index") unittest
        {
            auto array = StaticBitArray!(1)(true);
            array[0].shouldBeTrue;
        }

        @context("when the index is out of bounds")
        {
            @it("fails to compile with an assert error") unittest
            {
                import core.exception : AssertError;

                StaticBitArray!(1) array;
                shouldThrow!(AssertError)(array[1]);
            }
        }
    }

    @describe("this[size_t] = bool")
    {
        @it("sets the element at the specified index") unittest
        {
            StaticBitArray!(1) array;
            array[0] = true;

            array[0].shouldBeTrue;
        }

        @context("when the index is out of bounds")
        {
            @it("fails to compile with an assert error") unittest
            {
                import core.exception : AssertError;

                StaticBitArray!(1) array;
                shouldThrow!(AssertError)(array[1] = true);
            }
        }
    }
    @describe("element!(size_t)")
    {
        @it("gets the element at the specified index") unittest
        {
            auto array = StaticBitArray!(1)(true);
            array.element!(0).shouldBeTrue;
        }

        @context("when the index is out of bounds")
        {
            @it("fails to compile with a static assert") unittest
            {
                auto result = __traits(compiles,
                    {
                        StaticBitArray!(1) array;
                        array.element!(1);
                    }
                );

                result.shouldBeFalse;
            }
        }
    }

    @describe("element!(size_t)(bool)")
    {
        @it("sets the element at the specified index") unittest
        {
            StaticBitArray!(1) array;
            array.element!(0)(true);

            array.element!(0).shouldBeTrue;
        }

        @context("when the index is out of bounds")
        {
            @it("fails to compile with a static assert") unittest
            {
                auto result = __traits(compiles,
                    {
                        StaticBitArray!(1) array;
                        array.element!(1)(true);
                    }
                );

                result.shouldBeFalse;
            }
        }
    }

    @describe("all =")
    {
        @context("when the given value is 'false'")
        {
            @it("it sets all the elements to 'false'") unittest
            {
                auto array = StaticBitArray!(2)(true, true);
                array.all = false;
                auto result = [array.element!(0), array.element!(1)];

                result.shouldEqual([false, false]);
            }
        }

        @context("when the given value is 'true'")
        {
            @it("it sets all the elements to 'true'") unittest
            {
                StaticBitArray!(2) array;
                array.all = true;
                auto result = [array.element!(0), array.element!(1)];

                result.shouldEqual([true, true]);
            }
        }
    }
}
