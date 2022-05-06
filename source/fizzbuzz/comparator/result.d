module fizzbuzz.comparator.result;

import std.sumtype : SumType, match;

///
struct FirstIsLessThanSecond
{

}

///
struct FirstEqualsSecond
{

}

///
struct FirstIsGreaterThanSecond
{

}

///
struct ComparisonError
{
    string message;
}

///
alias FizzBuzzComparisonResult = SumType!(
    FirstIsLessThanSecond,
    FirstEqualsSecond,
    FirstIsGreaterThanSecond,
    ComparisonError
);

///
FizzBuzzComparisonResult firstIsLessThanSecond() pure nothrow @safe @nogc
{
    return FizzBuzzComparisonResult(FirstIsLessThanSecond());
}

/// ditto
@("Usage firstIsLessThanSecond")
unittest
{
    FizzBuzzComparisonResult result = firstIsLessThanSecond();

    assert(result.match!((in FirstIsLessThanSecond _) => true, _ => false));
}

///
FizzBuzzComparisonResult firstEqualsSecond() pure nothrow @safe @nogc
{
    return FizzBuzzComparisonResult(FirstEqualsSecond());
}

/// ditto
@("Usage firstEqualsSecond")
unittest
{
    FizzBuzzComparisonResult result = firstEqualsSecond();

    assert(result.match!((in FirstEqualsSecond _) => true, _ => false));
}

///
FizzBuzzComparisonResult firstIsGreaterThanSecond() pure nothrow @safe @nogc
{
    return FizzBuzzComparisonResult(FirstIsGreaterThanSecond());
}

/// ditto
@("Usage firstIsGreaterThanSecond")
unittest
{
    FizzBuzzComparisonResult result = firstIsGreaterThanSecond();

    assert(result.match!((in FirstIsGreaterThanSecond _) => true, _ => false));
}

///
FizzBuzzComparisonResult comparisonError() pure nothrow @safe @nogc
{
    import Constants = fizzbuzz.comparator.constants;

    return FizzBuzzComparisonResult(ComparisonError(Constants.THE_INTEGERS_COULD_NOT_BE_COMPARED));
}

/// ditto
@("Usage comparisonError")
unittest
{
    FizzBuzzComparisonResult result = comparisonError();

    assert(result.match!((in ComparisonError _) => true, _ => false));
}

///
bool isFizzBuzzCompareSuccess(in FizzBuzzComparisonResult result) pure nothrow @safe @nogc
{
    return result.match!(
        (in FirstIsLessThanSecond _) => true,
        (in FirstEqualsSecond _) => true,
        (in FirstIsGreaterThanSecond _) => true,
        _ => false,
    );
}

/// ditto
@("Usage isFizzBuzzCompareSuccess")
unittest
{
    const lessThanSecond = firstIsLessThanSecond();
    const equalsSecond = firstEqualsSecond();
    const greaterThanSecond = firstIsGreaterThanSecond();
    const err = comparisonError();

    assert(isFizzBuzzCompareSuccess(lessThanSecond));
    assert(isFizzBuzzCompareSuccess(equalsSecond));
    assert(isFizzBuzzCompareSuccess(greaterThanSecond));
    assert(!isFizzBuzzCompareSuccess(err));
}

private bool matchAnyOf(T)(in FizzBuzzComparisonResult result) pure nothrow @safe @nogc
{
    static assert(is(T == FirstEqualsSecond) || is(T == FirstIsLessThanSecond) || is(
            T == FirstIsGreaterThanSecond) || is(T == ComparisonError), "mismatch T at matchAnyOf");

    return result.match!((in T _) => true, _ => false);
}

///
bool isFirstEqualsSecond(in FizzBuzzComparisonResult result) pure nothrow @safe @nogc
{
    return matchAnyOf!FirstEqualsSecond(result);
}

///
bool isFirstIsGreaterThanSecond(in FizzBuzzComparisonResult result) pure nothrow @safe @nogc
{
    return matchAnyOf!FirstIsGreaterThanSecond(result);
}

///
bool isFirstIsLessThanSecond(in FizzBuzzComparisonResult result) pure nothrow @safe @nogc
{
    return matchAnyOf!FirstIsLessThanSecond(result);
}

///
bool isComparisonError(in FizzBuzzComparisonResult result) pure nothrow @safe @nogc
{
    return matchAnyOf!ComparisonError(result);
}
