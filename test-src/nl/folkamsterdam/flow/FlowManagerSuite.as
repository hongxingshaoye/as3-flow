package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.events.FlowEventTest;

	[RunWith("org.flexunit.runners.Suite")]
	public class FlowManagerSuite
	{
		public var animationEnabledMethodInvocationTest:AnimationEnabledMethodInvocationTest;
		public var stageAccessTest:StageAccessTest;
		public var flowEventTest:FlowEventTest;
		public var eventDispatcherTest:EventDispatcherTest;
	}
}