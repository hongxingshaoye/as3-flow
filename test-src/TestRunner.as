package
{
	import nl.folkamsterdam.flow.FlowManagerSuite;

	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	[SWF(backgroundColor="#000000", frameRate="30", width="100", height="100")]
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

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			environment = VisualTestEnvironmentBuilder.getInstance(this).buildVisualTestEnvironment();

			core = new FlexUnitCore();
			
			core.addListener(new TraceListener());

			if (ENVIRONMENT::CLI)
				core.addListener(new CIListener());
			
			core.run(FlowManagerSuite);
		}
	}
}