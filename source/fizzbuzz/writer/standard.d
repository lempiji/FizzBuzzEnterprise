module fizzbuzz.writer.standard;

import fizzbuzz.printer.interfaces;
import fizzbuzz.writer.interfaces;

///
class StdOutWriter : Writer
{
    import std.stdio : stdout;

    void write(in string text)
    {
        stdout.write(text);
    }

    void writeln(in string text)
    {
        stdout.writeln(text);
    }

    void writeln()
    {
        stdout.writeln();
    }
}

///
class StdErrWriter : Writer
{
    import std.stdio : stderr;

    void write(in string text)
    {
        stderr.write(text);
    }

    void writeln(in string text)
    {
        stderr.writeln(text);
    }

    void writeln()
    {
        stderr.writeln();
    }
}