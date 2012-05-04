package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.events.FlowEvent;

	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class StageAccesAsyncTest
	{
		private var environment:IVisualTestEnvironment;
		private var container:Sprite;
		private var eventDispatcher:IEventDispatcher;
		private var flowManager:FlowManager;
		private var view1:Sprite;
		private var view2:Sprite;

		[Before]
		public function before():void
		{
			environment = TestRunner.environment;

			container = new Sprite();
			environment.addChild(container);

			eventDispatcher = new EventDispatcher();

			flowManager = new FlowManager(container, eventDispatcher, FlowEvent, .1);

			view1 = new Sprite();
			view2 = new Sprite();
		}

		[Test(async)]
		public function ANIMATE_OUT_CURRENT_removes_view_from_stage():void
		{
			Async.proceedOnEvent(this, view1, Event.REMOVED_FROM_STAGE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_OUT_CURRENT));
		}

		[Test(async)]
		public function ANIMATE_IN_NEW_adds_view_to_stage():void
		{
			Async.proceedOnEvent(this, view1, Event.ADDED_TO_STAGE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
		}

		[Test(async)]
		public function SWAP_removes_old_view_from_stage():void
		{
			Async.proceedOnEvent(this, view1, Event.REMOVED_FROM_STAGE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.SWAP, view2));
		}

		[Test(async)]
		public function SWAP_adds_new_view_to_stage():void
		{
			Async.proceedOnEvent(this, view2, Event.ADDED_TO_STAGE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.SWAP, view2));
		}

		[After]
		public function after():void
		{
			view2 = null;
			view1 = null;

			flowManager.destruct();
			flowManager = null;

			eventDispatcher = null;

			environment.removeChild(container);

			container = null;
		}
	}
}
