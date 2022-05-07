module fizzbuzz.printer.interfaces;

import fizzbuzz.common.types;
import fizzbuzz.writer.interfaces : Writer, writerObject;

///
enum isPrinter(T) = is(typeof((T printer, in FizzBuzzLoopCounter counter) {
            printer.print(counter);
        }));

///
interface Printer
{
    void print(in FizzBuzzLoopCounter counter);
}

@("isPrinter!Printer must be true")
unittest
{
    static assert(isPrinter!Printer);
}

///
class PrinterObject(T) : Printer if (isPrinter!T)
{
    private T printer;

    this(T printer)
    {
        this.printer = printer;
    }

    this(ref T printer)
    {
        this.printer = printer;
    }

    void print(in FizzBuzzLoopCounter counter)
    {
        printer.print(counter);
    }
}

///
Printer printerObject(T)(auto ref T printer)
{
    static if (is(T : Printer))
    {
        return printer;
    }
    else static if (isPrinter!T)
    {
        return new PrinterObject!T(printer);
    }
    else
    {
        static assert(false);
    }
}
