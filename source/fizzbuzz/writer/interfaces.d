module fizzbuzz.writer.interfaces;

///
enum isWriter(T) = is(typeof((T Writer, in string text) {
            Writer.write(text);
            Writer.writeln(text);
            Writer.writeln();
        }));

///
interface Writer
{
    void write(in string text);
    void writeln(in string text);
    void writeln();
}

@("isWriter!Writer must be true")
unittest
{
    static assert(isWriter!Writer);
}

///
class WriterObject(T) : Writer if (isWriter!T)
{
    T writer;

    this(T writer)
    {
        this.writer = writer;
    }

    this(ref T writer)
    {
        this.writer = writer;
    }

    void write(in string text)
    {
        this.writer.write(text);
    }
    
    void writeln(in string text)
    {
        this.writer.writeln(text);
    }

    void writeln()
    {
        this.writer.writeln();
    }
}

///
Writer writerObject(T)(auto ref T writer)
{
    static if (is(T : Writer))
    {
        return writer;
    }
    else static if (isWriter!T)
    {
        return new WriterObject!T(writer);
    }
    else
    {
        static assert(false);
    }
}
