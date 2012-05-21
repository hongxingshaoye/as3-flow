package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.dummies.ViewDummy;

	import org.flexunit.asserts.assertTrue;

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

		[Test]
		public function animateOutCurrent_calls_view_exitAnimation():void
		{
			flowManager.animateInNew(view1);
			flowManager.animateOutCurrent();

			assertTrue(view1.exitAnimationIsCalled);
		}

		[Test]
		public function animateInNew_calls_view_exitAnimation_first():void
		{
			flowManager.animateInNew(view1);

			assertTrue(view1.exitAnimationIsCalled);
		}

		[Test]
		public function animateInNew_calls_view_enterAnimation():void
		{
			flowManager.animateInNew(view1);

			assertTrue(view1.enterAnimationIsCalled);
		}

		[Test]
		public function swap_calls_old_view_exitAnimation():void
		{
			flowManager.animateInNew(view1);
			flowManager.swap(view2);

			assertTrue(view1.exitAnimationIsCalled);
		}

		[Test]
		public function swap_calls_new_view_exitAnimation_first():void
		{
			flowManager.animateInNew(view1);
			flowManager.swap(view2);

			assertTrue(view2.exitAnimationIsCalled);
		}

		[Test]
		public function swap_calls_new_view_enterAnimation():void
		{
			flowManager.animateInNew(view1);
			flowManager.swap(view2);

			assertTrue(view2.enterAnimationIsCalled);
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