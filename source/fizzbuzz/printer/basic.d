module fizzbuzz.printer.basic;

import fizzbuzz.common.types;
import fizzbuzz.printer.interfaces;
import fizzbuzz.writer.interfaces;
import Constants = fizzbuzz.constants;

final class FizzPrinter : Printer
{
    private Writer writer;

    this(T)(T writer) if (isWriter!T)
    {
        this.writer = writerObject(writer);
    }

    void print(in FizzBuzzLoopCounter _)
    {
        this.writer.write(Constants.FIZZ);
    }
}

final class BuzzPrinter : Printer
{
    private Writer writer;

    this(T)(T writer) if (isWriter!T)
    {
        this.writer = writerObject(writer);
    }

    void print(in FizzBuzzLoopCounter _)
    {
        this.writer.write(Constants.BUZZ);
    }
}

final class IntegerPassThroughPrinter : Printer
{
    private Writer writer;

    this(T)(T writer) if (isWriter!T)
    {
        this.writer = writerObject(writer);
    }

    void print(in FizzBuzzLoopCounter counter)
    {
        import std.format : format;

        this.writer.write(format!"%3d"(counter.value));
    }
}

final class NewLinePrinter : Printer
{
    private Writer writer;

    this(T)(T writer) if (isWriter!T)
    {
        this.writer = writerObject(writer);
    }

    void print(in FizzBuzzLoopCounter _)
    {
        this.writer.writeln();
    }
}
