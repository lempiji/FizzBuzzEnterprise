module fizzbuzz.strategy.interfaces;

import fizzbuzz.common.types : FizzBuzzLoopCounter;

///
enum isIsEvenlyDivisibleStrategy(T) = is(typeof((T strategy, in FizzBuzzLoopCounter theInteger) {
    strategy.isEvenlyDivisible(theInteger);
}));

///
interface IsEvenlyDivisibleStrategy
{
    bool isEvenlyDivisible(in FizzBuzzLoopCounter theInteger);
}

@("isIsEvenlyDivisibleStrategy by IsEvenlyDivisibleStrategy is true")
unittest
{
    static assert(isIsEvenlyDivisibleStrategy!IsEvenlyDivisibleStrategy);
}

///
IsEvenlyDivisibleStrategy evenlyDivisibleStrategyObject(T)(auto ref T strategy)
out(obj; obj !is null)
do
{
    static if (is(T : IsEvenlyDivisibleStrategy))
    {
        return strategy;
    }
    else static if (isIsEvenlyDivisibleStrategy!T)
    {
        static class IsEvenlyDivisibleStrategyObject : IsEvenlyDivisibleStrategy
        {
            T strategy;

            this(T strategy) pure nothrow @safe @nogc
            {
                this.strategy = strategy;
            }

            this(ref T strategy) pure nothrow @safe @nogc
            {
                this.strategy = strategy;
            }
            
            bool isEvenlyDivisible(in FizzBuzzLoopCounter theInteger)
            {
                return this.strategy.isEvenlyDivisible(theInteger);
            }
        }

        return new IsEvenlyDivisibleStrategyObject(strategy);
    }
    else
    {
        static assert(false);
    }
}

@("Usage evenlyDivisibleStrategyObject")
unittest
{
    static struct MyStrategy
    {
        bool isEvenlyDivisible(in FizzBuzzLoopCounter counter)
        {
            return counter == 1;
        }
    }

    MyStrategy strategy;
    IsEvenlyDivisibleStrategy strategyObject = evenlyDivisibleStrategyObject(strategy);
    assert(strategyObject !is null);
    assert(strategyObject.isEvenlyDivisible(FizzBuzzLoopCounter(1)));
}

