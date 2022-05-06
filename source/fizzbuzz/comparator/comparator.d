module fizzbuzz.comparator.comparator;

import fizzbuzz.common.types;
import fizzbuzz.comparator.result;

struct ThreeWayComparator
{
    @disable this();
    @disable this(this);

    static FizzBuzzComparisonResult compare(in int first, in int second) pure nothrow @safe @nogc
    {
        if (first == second)
        {
            return firstEqualsSecond();
        }
        else if (first < second)
        {
            return firstIsLessThanSecond();
        }
        else if (first > second)
        {
            return firstIsGreaterThanSecond();
        }
        else
        {
            return comparisonError();
        }
    }
}

@("Usage ThreeWayComparator")
unittest
{
    const FizzBuzzLoopCounter one = 1;
    const FizzBuzzLoopCounter two = 2;

    const equalsSecond = ThreeWayComparator.compare(one, one);
    assert(isFirstEqualsSecond(equalsSecond));
    assert(isFizzBuzzCompareSuccess(equalsSecond));

    const lessThanSecond = ThreeWayComparator.compare(one, two);
    assert(isFirstIsLessThanSecond(lessThanSecond));
    assert(isFizzBuzzCompareSuccess(lessThanSecond));

    const greaterThanSecond = ThreeWayComparator.compare(two, one);
    assert(isFirstIsGreaterThanSecond(greaterThanSecond));
    assert(isFizzBuzzCompareSuccess(greaterThanSecond));
}
