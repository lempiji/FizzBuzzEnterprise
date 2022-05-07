module fizzbuzz.solution.solution;

import fizzbuzz.common.types;
import fizzbuzz.strategy.integer;
import fizzbuzz.writer.interfaces : Writer, writerObject;
import fizzbuzz.printer.basic;

class EnterpriseGradeSolution
{
    private Writer writer;
    private StrategyPrinterPair[] pairs;

    this(T)(auto ref T writer)
    {
        this.writer = writerObject(writer);

        initializeStrategyAndPrinters();
    }

    private void initializeStrategyAndPrinters()
    in(writer !is null)
    do
    {
        pairs ~= strategyPrinterPair(new FizzStrategy, new FizzPrinter(writer));
		pairs ~= strategyPrinterPair(new BuzzStrategy, new BuzzPrinter(writer));
		pairs ~= strategyPrinterPair(new NoFizzNoBuzzStrategy, new IntegerPassThroughPrinter(writer));
		pairs ~= strategyPrinterPair(new EverythingPassThroughStrategy, new NewLinePrinter(writer));
    }

    void executeStep(in FizzBuzzLoopCounter counter)
    {
        foreach (pair; pairs)
        {
            if (pair.strategy.isEvenlyDivisible(counter))
            {
                pair.printer.print(counter);
            }
        }
    }
}
