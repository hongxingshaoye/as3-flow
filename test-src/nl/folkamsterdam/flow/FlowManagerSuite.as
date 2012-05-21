package nl.folkamsterdam.flow
{

	[RunWith("org.flexunit.runners.Suite")]
	public class FlowManagerSuite
	{
		public var animationEnabledTest:AnimationEnabledTest;
		public var animationEnabledAsyncTest:AnimationEnabledAsyncTest;
		public var stageAccessTest:StageAccessTest;
		public var flowEventTest:FlowEventTest;
		public var eventDispatcherTest:EventDispatcherTest;
		public var customEventsTest:CustomEventsTest;
	}
}