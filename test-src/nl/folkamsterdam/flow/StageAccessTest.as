package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.events.FlowEvent;

	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;

	import flash.display.Sprite;
	import flash.events.Event;

	public class StageAccessTest
	{
		private var environment:IVisualTestEnvironment;
		private var container:Sprite;
		private var flowManager:FlowManager;
		private var view1:Sprite;
		private var view2:Sprite;

		[Before]
		public function before():void
		{
			environment = TestRunner.environment;

			container = new Sprite();
			environment.addChild(container);

			flowManager = new FlowManager(container, null, FlowEvent, .1);

			view1 = new Sprite();
			view2 = new Sprite();
		}

		[Test(async)]
		public function animateOutCurrent_removes_view_from_stage():void
		{
			Async.proceedOnEvent(this, view1, Event.REMOVED_FROM_STAGE);

			flowManager.animateInNew(view1);
			flowManager.animateOutCurrent();
		}

		[Test(async)]
		public function animateInNew_adds_view_to_stage():void
		{
			Async.proceedOnEvent(this, view1, Event.ADDED_TO_STAGE);

			flowManager.animateInNew(view1);
		}

		[Test(async)]
		public function swap_removes_old_view_from_stage():void
		{
			Async.proceedOnEvent(this, view1, Event.REMOVED_FROM_STAGE);

			flowManager.animateInNew(view1);
			flowManager.swap(view2);
		}

		[Test(async)]
		public function swap_adds_new_view_to_stage():void
		{
			Async.proceedOnEvent(this, view2, Event.ADDED_TO_STAGE);

			flowManager.animateInNew(view1);
			flowManager.swap(view2);
		}

		[After]
		public function after():void
		{
			view2 = null;
			view1 = null;

			flowManager.destruct();
			flowManager = null;

			environment.removeChild(container);

			container = null;
		}
	}
}