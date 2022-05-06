module fizzbuzz.common.math;

import fizzbuzz.common.types : FizzBuzzLoopCounter;
import fizzbuzz.comparator : ThreeWayComparator, isFirstEqualsSecond;

bool isMultipleOfAnotherNumber(in FizzBuzzLoopCounter firstNumber, in int secondNumber) pure nothrow @safe @nogc
{
    const int nDivideFirstIntegerBySecondIntegerResult = firstNumber / secondNumber;
    const int nMultiplyDivisionResultBySecondIntegerResult = nDivideFirstIntegerBySecondIntegerResult * secondNumber;

    const compareResult = ThreeWayComparator.compare(firstNumber, nMultiplyDivisionResultBySecondIntegerResult);

    if (isFirstEqualsSecond(compareResult))
    {
        return true;
    }
    else
    {
        return false;
    }
}

@("Usage isMultipleOfAnotherNumber")
unittest
{
    assert(isMultipleOfAnotherNumber(FizzBuzzLoopCounter(10), 2));
    assert(!isMultipleOfAnotherNumber(FizzBuzzLoopCounter(20), 9));
}
