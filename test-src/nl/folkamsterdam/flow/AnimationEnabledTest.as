package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.dummies.ViewDummy;

	import org.flexunit.async.Async;

	import flash.display.Sprite;

	public class AnimationEnabledTest
	{
		private var container:Sprite;
		private var flowManager:FlowManager;
		private var view1:ViewDummy;
		private var view2:ViewDummy;

		[Before]
		public function before():void
		{
			container = new Sprite();
			flowManager = new FlowManager(container);
			view1 = new ViewDummy();
			view2 = new ViewDummy();
		}

		[Test(async)]
		public function animateOutCurrent_calls_view_exitAnimation():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);

			flowManager.animateInNew(view1);
			flowManager.animateOutCurrent();
		}

		[Test(async)]
		public function animateInNew_calls_view_exitAnimation_first():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);

			flowManager.animateInNew(view1);
		}

		[Test(async)]
		public function animateInNew_calls_view_enterAnimation():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.ENTER_COMPLETE);

			flowManager.animateInNew(view1);
		}

		[Test(async)]
		public function swap_calls_old_view_exitAnimation():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);

			flowManager.animateInNew(view1);
			flowManager.swap(view2);
		}

		[Test(async)]
		public function swap_calls_new_view_exitAnimation_first():void
		{
			Async.proceedOnEvent(this, view2, ViewDummy.EXIT_COMPLETE);

			flowManager.animateInNew(view1);
			flowManager.swap(view2);
		}

		[Test(async)]
		public function swap_calls_new_view_enterAnimation():void
		{
			Async.proceedOnEvent(this, view2, ViewDummy.ENTER_COMPLETE);

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

			container = null;
		}
	}
}