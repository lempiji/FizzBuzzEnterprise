module fizzbuzz.common.types;

private import fizzbuzz.constants : DEFAULT_FIZZ_BUZZ_UPPER_LIMIT_VALUE;

///
struct FizzBuzzLoopCounter
{
    int value;
    alias value this;

    this(int value) pure nothrow @safe @nogc
    {
        this.value = value;
    }

    invariant ()
    {
        assert(1 <= value, "counter must be greater or equal than 1");
        assert(value <= DEFAULT_FIZZ_BUZZ_UPPER_LIMIT_VALUE, "counter must be less or equal than 100");
    }
}

@("Usage FizzBuzzLoopCounter")
unittest
{
    for (FizzBuzzLoopCounter i = 1; i <= 100; i++)
    {
        // body
    }
}

@("Usage FizzBuzzLoopCounter underflow")
unittest
{
    import core.exception : AssertError;

    try
    {
        for (FizzBuzzLoopCounter i = -1; i <= DEFAULT_FIZZ_BUZZ_UPPER_LIMIT_VALUE;
            i++)
        {

        }
    }
    catch (AssertError)
    {
        return;
    }
    assert(false);
}

@("Usage FizzBuzzLoopCounter overflow")
unittest
{
    import core.exception : AssertError;

    try
    {
        for (FizzBuzzLoopCounter i = -1; i <= DEFAULT_FIZZ_BUZZ_UPPER_LIMIT_VALUE + 1;
            i++)
        {

        }
    }
    catch (AssertError)
    {
        return;
    }
    assert(false);
}

import fizzbuzz.strategy.interfaces : IsEvenlyDivisibleStrategy, evenlyDivisibleStrategyObject;
import fizzbuzz.printer.interfaces : Printer, printerObject;

struct StrategyPrinterPair
{
    IsEvenlyDivisibleStrategy strategy;
    Printer printer;
}

StrategyPrinterPair strategyPrinterPair(TStrategy, TPrinter)(
    auto ref TStrategy strategy, auto ref TPrinter printer)
{
    return StrategyPrinterPair(evenlyDivisibleStrategyObject(strategy), printerObject(printer));
}
