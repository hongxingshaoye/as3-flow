package nl.folkamsterdam.flow
{
	import com.greensock.core.TweenCore;

	public interface IAnimationEnabled
	{
		function get exitAnimation():TweenCore;

		function get enterAnimation():TweenCore;
	}
}