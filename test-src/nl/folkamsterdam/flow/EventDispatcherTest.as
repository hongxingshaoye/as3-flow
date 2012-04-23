package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.events.FlowEvent;

	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	import flash.display.Sprite;
	import flash.events.EventDispatcher;

	public class EventDispatcherTest
	{
		private var container:Sprite;
		private var eventDispatcher:EventDispatcher;
		private var flowManager:FlowManager;

		[Before]
		public function before():void
		{
			container = new Sprite();
			eventDispatcher = new EventDispatcher();
			flowManager = new FlowManager(container, eventDispatcher);
		}

		[Test]
		public function constructor_adds_ANIMATE_OUT_CURRENT_listener():void
		{
			assertTrue(eventDispatcher.hasEventListener(FlowEvent.ANIMATE_OUT_CURRENT));
		}

		[Test]
		public function constructor_adds_ANIMATE_IN_NEW_listener():void
		{
			assertTrue(eventDispatcher.hasEventListener(FlowEvent.ANIMATE_IN_NEW));
		}

		[Test]
		public function constructor_adds_SWAP_listener():void
		{
			assertTrue(eventDispatcher.hasEventListener(FlowEvent.SWAP));
		}

		[Test]
		public function destruct_removes_ANIMATE_OUT_CURRENT_listener():void
		{
			flowManager.destruct();

			assertFalse(eventDispatcher.hasEventListener(FlowEvent.ANIMATE_OUT_CURRENT));
		}

		[Test]
		public function destruct_removes_ANIMATE_IN_NEW_listener():void
		{
			flowManager.destruct();

			assertFalse(eventDispatcher.hasEventListener(FlowEvent.ANIMATE_IN_NEW));
		}

		[Test]
		public function destruct_removes_SWAP_listener():void
		{
			flowManager.destruct();

			assertFalse(eventDispatcher.hasEventListener(FlowEvent.SWAP));
		}

		[After]
		public function after():void
		{
			flowManager.destruct();
			flowManager = null;

			eventDispatcher = null;

			container = null;
		}
	}
}