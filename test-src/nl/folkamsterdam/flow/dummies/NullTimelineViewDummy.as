package nl.folkamsterdam.flow.dummies
{
	import nl.folkamsterdam.flow.IAnimationEnabled;

	import com.greensock.core.TweenCore;

	import flash.display.Sprite;

	public class NullTimelineViewDummy extends Sprite implements IAnimationEnabled
	{
		public function get exitAnimation():TweenCore
		{
			return null;
		}

		public function get enterAnimation():TweenCore
		{
			return null;
		}
	}
}
