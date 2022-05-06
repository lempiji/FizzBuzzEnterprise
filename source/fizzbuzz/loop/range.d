module fizzbuzz.loop.range;

import fizzbuzz.common.types : FizzBuzzLoopCounter;

struct FizzBuzzLoopCounterRange
{
    private FizzBuzzLoopCounter counter;
    private const int limit;

    this(in int init, in int limit)
    {
        this.counter = FizzBuzzLoopCounter(init);
        this.limit = limit;
    }

    bool empty() const
    {
        return counter > limit;
    }

    FizzBuzzLoopCounter front() const
    {
        return counter;
    }

    void popFront()
    {
        counter += 1;
    }

    FizzBuzzLoopCounterRange save()
    {
        return this;
    }
}

@("Usage FizzBuzzLoopCounterRange")
unittest
{
    int[] loopIndexResult;

    foreach (FizzBuzzLoopCounter i; FizzBuzzLoopCounterRange(1, 100))
    {
        assert(1 <= i);
        assert(i <= 100);

        loopIndexResult ~= i;
    }

    assert(loopIndexResult.length == 100);
    assert(loopIndexResult[0] == 1);
    assert(loopIndexResult[99] == 100);
}
