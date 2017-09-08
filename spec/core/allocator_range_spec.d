module spec.core.allocator_range_spec;

import std.algorithm;
import std.experimental.allocator;
import std.range;

import spec.spec_helper;
import kiwi.core.allocator_range;

@describe("AllocatorRange")
{
    auto newRange(IAllocator allocator)
    {
        alias growSize = size => size + 1;
        return AllocatorRange!(int, growSize)(allocator, 1);
    }

    @context("when the default (GC) allocator is being used")
    {
        @it("puts elements in an array allocated by the allocator") unittest
        {
            auto range = newRange(theAllocator);
            0.iota(3).each!(e => range.put(e));

            range.data.shouldEqual([0, 1, 2]);
        }
    }

    @context("when a region allocator is being used")
    {
        @it("puts elements in an array allocated by the allocator") unittest
        {
            import std.experimental.allocator.building_blocks.region;
            import std.experimental.allocator.building_blocks.null_allocator;

            ubyte[44] buffer;
            auto region = Region!(NullAllocator, 1)(buffer[]);
            auto allocator = allocatorObject(&region);
            auto range = newRange(allocator);
            0.iota(3).each!(e => range.put(e));

            (cast(int[]) buffer[]).shouldEqual([0, 1, 2]);
        }
    }
}
