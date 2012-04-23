package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.dummies.ViewDummy;
	import nl.folkamsterdam.flow.events.FlowEvent;

	import org.flexunit.async.Async;

	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class AnimationEnabledMethodInvocationTest
	{
		private var container:Sprite;
		private var eventDispatcher:IEventDispatcher;
		private var flowManager:FlowManager;
		private var view1:ViewDummy;
		private var view2:ViewDummy;

		[Before]
		public function before():void
		{
			container = new Sprite();
			eventDispatcher = new EventDispatcher();
			flowManager = new FlowManager(container, eventDispatcher);
			view1 = new ViewDummy();
			view2 = new ViewDummy();
		}

		[Test(async)]
		public function invoking_animateOutCurrent_directly_uses_views_exitAnimation_method():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);

			flowManager.animateInNew(view1);
			flowManager.animateOutCurrent();
		}

		[Test(async)]
		public function invoking_animateInNew_directly_uses_views_enterAnimation_method():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.ENTER_COMPLETE);

			flowManager.animateInNew(view1);
		}

		[Test(async)]
		public function invoking_swap_directly_uses_current_views_exitAnimation_method():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);

			flowManager.animateInNew(view1);
			flowManager.swap(view2);
		}

		[Test(async)]
		public function invoking_swap_directly_uses_new_views_enterAnimation_method():void
		{
			Async.proceedOnEvent(this, view2, ViewDummy.ENTER_COMPLETE);

			flowManager.animateInNew(view1);
			flowManager.swap(view2);
		}

		[Test(async)]
		public function invoking_animateOutCurrent_through_eventDispatcher_uses_views_exitAnimation_method():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_OUT_CURRENT));
		}

		[Test(async)]
		public function invoking_animateInNew_through_eventDispatcher_uses_views_enterAnimation_method():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.ENTER_COMPLETE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
		}

		[Test(async)]
		public function invoking_swap_through_eventDispatcher_uses_current_views_exitAnimation_method():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);

			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.SWAP, view2));
		}

		[Test(async)]
		public function invoking_swap_through_eventDispatcher_uses_new_views_enterAnimation_method():void
		{
			Async.proceedOnEvent(this, view2, ViewDummy.ENTER_COMPLETE);

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

			container = null;
		}
	}
}