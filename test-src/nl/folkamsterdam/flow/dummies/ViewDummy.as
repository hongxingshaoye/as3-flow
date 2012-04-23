package nl.folkamsterdam.flow.dummies
{
	import nl.folkamsterdam.flow.IAnimationEnabled;

	import com.greensock.TweenLite;
	import com.greensock.core.TweenCore;

	import flash.display.Sprite;
	import flash.events.Event;

	public class ViewDummy extends Sprite implements IAnimationEnabled
	{
		public static const EXIT_COMPLETE:String = "exitComplete";
		public static const ENTER_COMPLETE:String = "enterComplete";

		public function get exitAnimation():TweenCore
		{
			const vars:Object = new Object();
			vars.onComplete = dispatchEvent;
			vars.onCompleteParams = [new Event(EXIT_COMPLETE)];

			return new TweenLite(this, .1, vars);
		}

		public function get enterAnimation():TweenCore
		{
			const vars:Object = new Object();
			vars.onComplete = dispatchEvent;
			vars.onCompleteParams = [new Event(ENTER_COMPLETE)];

			return new TweenLite(this, .1, vars);
		}
	}
}
