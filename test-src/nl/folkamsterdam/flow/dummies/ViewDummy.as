package nl.folkamsterdam.flow.dummies
{
	import nl.folkamsterdam.flow.IAnimationEnabled;

	import com.greensock.TweenLite;
	import com.greensock.core.Animation;

	import flash.display.Sprite;

	public class ViewDummy extends Sprite implements IAnimationEnabled
	{
		private var _exitAnimationIsCalled:Boolean;
		private var _enterAnimationIsCalled:Boolean;

		public function get exitAnimationIsCalled():Boolean
		{
			return _exitAnimationIsCalled;
		}

		public function get enterAnimationIsCalled():Boolean
		{
			return _enterAnimationIsCalled;
		}

		public function get exitAnimation():Animation
		{
			_exitAnimationIsCalled = true;

			return new TweenLite(this, .1, {});
		}

		public function get enterAnimation():Animation
		{
			_enterAnimationIsCalled = true;

			return new TweenLite(this, .1, {});
		}
	}
}