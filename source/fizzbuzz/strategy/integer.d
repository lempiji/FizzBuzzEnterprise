module fizzbuzz.strategy.integer;

import fizzbuzz.common.types : FizzBuzzLoopCounter;
import fizzbuzz.strategy.interfaces;
import fizzbuzz.common.math : isMultipleOfAnotherNumber;

mixin template IsMultipleOfAnotherNumberStrategy(int DivideNumber)
{
    bool isEvenlyDivisible(in FizzBuzzLoopCounter theInteger)
    {
        if (isMultipleOfAnotherNumber(theInteger, DivideNumber))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}

enum FIZZ_INTEGER_CONSTANT_VALUE = 3;

class FizzStrategy : IsEvenlyDivisibleStrategy
{
    mixin IsMultipleOfAnotherNumberStrategy!FIZZ_INTEGER_CONSTANT_VALUE;
}

@("Usage FizzStrategy")
unittest
{
    auto fizzStrategy = new FizzStrategy;

    assert(fizzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(3)));
    assert(fizzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(6)));
    assert(fizzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(9)));
    assert(!fizzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(10)));
}

enum BUZZ_INTEGER_CONSTANT_VALUE = 5;

class BuzzStrategy : IsEvenlyDivisibleStrategy
{
    mixin IsMultipleOfAnotherNumberStrategy!BUZZ_INTEGER_CONSTANT_VALUE;
}

@("Usage BuzzStrategy")
unittest
{
    auto buzzStrategy = new BuzzStrategy;

    assert(buzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(5)));
    assert(buzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(10)));
    assert(buzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(15)));
    assert(!buzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(1)));
}

enum NO_FIZZ_INTEGER_CONSTANT_VALUE = FIZZ_INTEGER_CONSTANT_VALUE;
enum NO_BUZZ_INTEGER_CONSTANT_VALUE = BUZZ_INTEGER_CONSTANT_VALUE;

class NoFizzNoBuzzStrategy : IsEvenlyDivisibleStrategy
{

    bool isEvenlyDivisible(in FizzBuzzLoopCounter theInteger)
    {
        if (!isMultipleOfAnotherNumber(theInteger, NO_FIZZ_INTEGER_CONSTANT_VALUE))
        {
            if (!isMultipleOfAnotherNumber(theInteger, NO_BUZZ_INTEGER_CONSTANT_VALUE))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else if (!isMultipleOfAnotherNumber(theInteger, NO_BUZZ_INTEGER_CONSTANT_VALUE))
        {
            if (!isMultipleOfAnotherNumber(theInteger, NO_FIZZ_INTEGER_CONSTANT_VALUE))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
}

@("Usage NoFizzNoBuzzStrategy")
unittest
{
    auto noFizzNoBuzzStrategy = new NoFizzNoBuzzStrategy;

    assert(noFizzNoBuzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(1)));
    assert(noFizzNoBuzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(2)));
    assert(noFizzNoBuzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(4)));
    assert(noFizzNoBuzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(7)));
    assert(!noFizzNoBuzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(3)));
    assert(!noFizzNoBuzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(5)));
    assert(!noFizzNoBuzzStrategy.isEvenlyDivisible(FizzBuzzLoopCounter(15)));
}

///
class EverythingPassThroughStrategy : IsEvenlyDivisibleStrategy
{

    bool isEvenlyDivisible(in FizzBuzzLoopCounter _)
    {
        return true;
    }
}