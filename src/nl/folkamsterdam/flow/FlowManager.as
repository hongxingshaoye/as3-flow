package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.events.FlowEvent;

	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.IEventDispatcher;

	public class FlowManager
	{
		private var container:DisplayObjectContainer;
		private var current:DisplayObject;
		private var _sharedTimeline:TimelineMax;
		private var eventDispatcher:IEventDispatcher;
		private var eventClass:Class;
		private var defaultTweenDuration:Number;

		private function get animationIsPlaying():Boolean
		{
			return (_sharedTimeline && _sharedTimeline._active);
		}

		private function get sharedTimeline():TimelineMax
		{
			if (!_sharedTimeline)
			{
				_sharedTimeline = new TimelineMax();
				_sharedTimeline.vars.onComplete = function():void
				{
					_sharedTimeline = null;
				};
			}

			return _sharedTimeline;
		}

		public function FlowManager(container:DisplayObjectContainer, eventDispatcher:IEventDispatcher = null, eventClass:Class = null, defaultTweenDuration:Number = 1)
		{
			this.container = container;

			// using Null Object strategy:
			current = new Shape();
			container.addChild(current);

			if (eventDispatcher)
			{
				this.eventDispatcher = eventDispatcher;

				eventDispatcher.addEventListener(FlowEvent.ANIMATE_OUT_CURRENT, handleAnimateOutCurrent);
				eventDispatcher.addEventListener(FlowEvent.ANIMATE_IN_NEW, handleAnimateInNew);
				eventDispatcher.addEventListener(FlowEvent.SWAP, handleSwap);
			}

			this.eventClass = eventClass || FlowEvent;

			this.defaultTweenDuration = defaultTweenDuration;
		}

		public function animateOutCurrent():Animation
		{
			if (animationIsPlaying)
				sharedTimeline.seek(sharedTimeline.totalDuration());

			sharedTimeline.append(getExitAnimation(current));

			attemptPlay();

			return sharedTimeline;
		}

		public function animateInNew(view:DisplayObject):Animation
		{
			var animation:Animation = getExitTween(view);

			animation.seek(animation.totalDuration(), false);

			sharedTimeline.append(getEnterAnimation(view));

			attemptPlay();

			current = view;

			return sharedTimeline;
		}

		public function swap(view:DisplayObject):Animation
		{
			animateOutCurrent();
			animateInNew(view);

			return sharedTimeline;
		}

		public function destruct():void
		{
			if (animationIsPlaying)
				sharedTimeline.seek(sharedTimeline.totalDuration(), false);

			_sharedTimeline = null;

			if (eventDispatcher)
			{
				eventDispatcher.removeEventListener(FlowEvent.ANIMATE_OUT_CURRENT, handleAnimateOutCurrent);
				eventDispatcher.removeEventListener(FlowEvent.ANIMATE_IN_NEW, handleAnimateInNew);
				eventDispatcher.removeEventListener(FlowEvent.SWAP, handleSwap);

				eventDispatcher = null;
			}

			current = null;
			container = null;
		}

		private function attemptPlay():void
		{
			if (!animationIsPlaying)
				sharedTimeline.play();
		}

		private function getExitAnimation(view:DisplayObject):Animation
		{
			return buildTimeline(getExitTween(view), new TweenLiteVars().onComplete(container.removeChild, [view]));
		}

		private function getEnterAnimation(view:DisplayObject):Animation
		{
			return buildTimeline(getEnterTween(view), new TweenLiteVars().onStart(container.addChild, [view]));
		}

		private function buildTimeline(tween:Animation, variables:TweenLiteVars):Animation
		{
			// Wrap the tweens in a timeline so we don't accidently overwrite the provided tweens' onStart parameters:
			const timeline:TimelineLite = new TimelineLite(variables);

			timeline.append(tween);

			return timeline;
		}

		private function getExitTween(view:DisplayObject):Animation
		{
			return (view is IAnimationEnabled) ? IAnimationEnabled(view).exitAnimation : buildDefaultTween(view, 0);
		}

		private function getEnterTween(view:DisplayObject):Animation
		{
			return (view is IAnimationEnabled) ? IAnimationEnabled(view).enterAnimation : buildDefaultTween(view, 1);
		}

		private function buildDefaultTween(view:DisplayObject, targetAlpha:Number):Animation
		{
			return TweenMax.to(view, defaultTweenDuration, {autoAlpha:targetAlpha});
		}

		private function handleAnimateOutCurrent(event:FlowEvent):void
		{
			(event is eventClass) && animateOutCurrent();
		}

		private function handleAnimateInNew(event:FlowEvent):void
		{
			(event is eventClass) && animateInNew(event.view);
		}

		private function handleSwap(event:FlowEvent):void
		{
			(event is eventClass) && swap(event.view);
		}
	}
}