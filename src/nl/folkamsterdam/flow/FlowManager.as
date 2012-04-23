package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.events.FlowEvent;

	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.core.TweenCore;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.IEventDispatcher;

	public class FlowManager
	{
		private var container:DisplayObjectContainer;
		private var current:DisplayObject;
		private var eventDispatcher:IEventDispatcher;
		private var _sharedTimeline:TimelineMax;
		
		protected var defaultTweenDuration:Number = 1;
		
		private function get animationIsPlaying():Boolean
		{
			return (_sharedTimeline && _sharedTimeline.active);
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

		public function FlowManager(container:DisplayObjectContainer, eventDispatcher:IEventDispatcher = null, defaultTweenDuration:Number = 1)
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
			
			this.defaultTweenDuration = defaultTweenDuration;
		}

		public function animateOutCurrent():TweenCore
		{
			if (animationIsPlaying)
				sharedTimeline.complete();

			sharedTimeline.append(getExitAnimation(current));

			attemptPlay();

			return sharedTimeline;
		}

		public function animateInNew(view:DisplayObject):TweenCore
		{
			sharedTimeline.append(getEnterAnimation(view));

			attemptPlay();

			current = view;

			return sharedTimeline;
		}

		public function swap(view:DisplayObject):TweenCore
		{
			animateOutCurrent();
			animateInNew(view);

			return sharedTimeline;
		}

		public function destruct():void
		{
			if (animationIsPlaying)
				sharedTimeline.complete();

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

		protected function getDefaultExitAnimation(view:DisplayObject):TweenCore
		{
			return TweenMax.to(view, defaultTweenDuration, {autoAlpha:0});
		}

		protected function getDefaultEnterAnimation(view:DisplayObject):TweenCore
		{
			return TweenMax.to(view, defaultTweenDuration, {autoAlpha:1});
		}
		
		private function attemptPlay():void
		{
			if (!animationIsPlaying)
				sharedTimeline.play();
		}

		private function getExitAnimation(view:DisplayObject):TweenCore
		{
			// Wrap the tweens in a timeline so we don't accidently overwrite the provided tweens' onComplete parameters:
			const timeline:TimelineMax = new TimelineMax();
			
			if (view is IAnimationEnabled)
				timeline.append(IAnimationEnabled(view).exitAnimation);
			else
				timeline.append(getDefaultExitAnimation(view));
			
			timeline.vars.onComplete = container.removeChild;
			timeline.vars.onCompleteParams = [view];
			
			return timeline;
		}

		private function getEnterAnimation(view:DisplayObject):TweenCore
		{
			// Wrap the tweens in a timeline so we don't accidently overwrite the provided tweens' onStart parameters:
			const timeline:TimelineMax = new TimelineMax();
			
			if (view is IAnimationEnabled)
			{
				IAnimationEnabled(view).exitAnimation.complete();
				
				timeline.append(IAnimationEnabled(view).enterAnimation);
			}
			else
			{
				getDefaultExitAnimation(view).complete();
				
				timeline.append(getDefaultEnterAnimation(view));
			}
			
			timeline.vars.onStart = container.addChild;
			timeline.vars.onStartParams = [view];			
			
			return timeline;
		}

		private function handleAnimateOutCurrent(event:FlowEvent):void
		{
			animateOutCurrent();
		}

		private function handleAnimateInNew(event:FlowEvent):void
		{
			animateInNew(event.view);
		}

		private function handleSwap(event:FlowEvent):void
		{
			swap(event.view);
		}
	}
}