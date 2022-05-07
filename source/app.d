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
		import fizzbuzz.printer.basic : FizzPrinter, BuzzPrinter, IntegerPassThroughPrinter, NewLinePrinter;

		// TODO make configurable
		import fizzbuzz.solution.solution : EnterpriseGradeSolution;

		auto solution = new EnterpriseGradeSolution(new StdOutWriter);

		// TODO TODO Refactor: Extract as Executor.
		foreach (FizzBuzzLoopCounter loopCounter; FizzBuzzLoopCounterRange(Constants.LOOP_INIT_VALUE, Constants
				.DEFAULT_FIZZ_BUZZ_UPPER_LIMIT_VALUE))
		{
			solution.executeStep(loopCounter);
		}
	}
}
