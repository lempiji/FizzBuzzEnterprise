module app;

version (unittest)
{

}
else
{
	void main()
	{
		import fizzbuzz.common.types : FizzBuzzLoopCounter;
		import fizzbuzz.loop.range : FizzBuzzLoopCounterRange;
		import Constants = fizzbuzz.constants;

		import fizzbuzz.common.types : StrategyPrinterPair, strategyPrinterPair;

		import fizzbuzz.strategy.integer : FizzStrategy, BuzzStrategy, NoFizzNoBuzzStrategy, EverythingPassThroughStrategy;
		import fizzbuzz.writer.standard : StdOutWriter;
		import fizzbuzz.printer.basic : FizzPrinter,BuzzPrinter,IntegerPassThroughPrinter,NewLinePrinter;

		auto stanardOutputWriter = new StdOutWriter;

		StrategyPrinterPair[] strategyAndPrinterPairs;
		strategyAndPrinterPairs ~= strategyPrinterPair(new FizzStrategy, new FizzPrinter(stanardOutputWriter));
		strategyAndPrinterPairs ~= strategyPrinterPair(new BuzzStrategy, new BuzzPrinter(stanardOutputWriter));
		strategyAndPrinterPairs ~= strategyPrinterPair(new NoFizzNoBuzzStrategy, new IntegerPassThroughPrinter(stanardOutputWriter));
		strategyAndPrinterPairs ~= strategyPrinterPair(new EverythingPassThroughStrategy, new NewLinePrinter(stanardOutputWriter));

		foreach (FizzBuzzLoopCounter loopCounter; FizzBuzzLoopCounterRange(Constants.LOOP_INIT_VALUE, Constants.DEFAULT_FIZZ_BUZZ_UPPER_LIMIT_VALUE))
		{
			foreach (strategyAndPrinter; strategyAndPrinterPairs)
			{
				if (strategyAndPrinter.strategy.isEvenlyDivisible(loopCounter))
				{
					strategyAndPrinter.printer.print(loopCounter);
				}
			}
		}
	}
}
