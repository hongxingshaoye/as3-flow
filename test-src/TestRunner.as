package
{
	import nl.folkamsterdam.flow.FlowManagerSuite;

	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;

	import flash.display.Sprite;
	import flash.events.Event;

	public class TestRunner extends Sprite
	{
		public static var environment:IVisualTestEnvironment;
		
		private var core:FlexUnitCore;

		public function TestRunner()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);

			if (stage)
				init();
		}

		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			environment = VisualTestEnvironmentBuilder.getInstance(this).buildVisualTestEnvironment();

			core = new FlexUnitCore();
			core.visualDisplayRoot = this;
			core.addListener(new TraceListener());
			core.run(FlowManagerSuite);
		}
	}
}