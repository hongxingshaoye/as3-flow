package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.dummies.ViewDummyAsync;
	import nl.folkamsterdam.flow.events.FlowEvent;

	import org.flexunit.async.Async;

	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class AnimationEnabledAsyncTest
	{
		private var container:Sprite;
		private var eventDispatcher:IEventDispatcher;
		private var flowManager:FlowManager;
		private var view1:ViewDummyAsync;
		private var view2:ViewDummyAsync;

		[Before]
		public function before():void
		{
			container = new Sprite();
			eventDispatcher = new EventDispatcher();
			flowManager = new FlowManager(container, eventDispatcher);
			view1 = new ViewDummyAsync();
			view2 = new ViewDummyAsync();
		}

		[Test(async)]
		public function ANIMATE_OUT_CURRENT_calls_view_exitAnimation():void
		{
			flowManager.animateInNew(view1);

			Async.proceedOnEvent(this, view1, ViewDummyAsync.EXIT_COMPLETE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_OUT_CURRENT, view1));
		}

		[Test(async)]
		public function ANIMATE_IN_NEW_calls_view_exitAnimation_first():void
		{
			Async.proceedOnEvent(this, view1, ViewDummyAsync.EXIT_COMPLETE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
		}

		[Test(async)]
		public function ANIMATE_IN_NEW_calls_view_enterAnimation():void
		{
			Async.proceedOnEvent(this, view1, ViewDummyAsync.ENTER_COMPLETE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
		}

		[Test(async)]
		public function SWAP_calls_old_view_exitAnimation():void
		{
			flowManager.animateInNew(view1);

			Async.proceedOnEvent(this, view1, ViewDummyAsync.EXIT_COMPLETE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.SWAP, view2));
		}

		[Test(async)]
		public function SWAP_calls_new_view_exitAnimation_first():void
		{
			flowManager.animateInNew(view1);

			Async.proceedOnEvent(this, view2, ViewDummyAsync.EXIT_COMPLETE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.SWAP, view2));
		}

		[Test(async)]
		public function SWAP_calls_new_view_enterAnimation():void
		{
			flowManager.animateInNew(view1);

			Async.proceedOnEvent(this, view2, ViewDummyAsync.ENTER_COMPLETE);

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

			container = null;
		}
	}
}
