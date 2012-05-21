package nl.folkamsterdam.flow
{
	import com.greensock.core.Animation;

	public interface IAnimationEnabled
	{
		function get exitAnimation():Animation;

		function get enterAnimation():Animation;
	}
}