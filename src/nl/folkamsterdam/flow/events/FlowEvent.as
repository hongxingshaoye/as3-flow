package nl.folkamsterdam.flow.events
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	public class FlowEvent extends Event
	{
		public static const ANIMATE_OUT_CURRENT:String = "animateOutCurrent";
		public static const ANIMATE_IN_NEW:String = "animateInNew";
		public static const SWAP:String = "swap";
		private var _view:DisplayObject;

		public function get view():DisplayObject
		{
			return _view;
		}

		public function FlowEvent(type:String, view:DisplayObject = null)
		{
			_view = view;

			super(type);

			if ((type == ANIMATE_IN_NEW || type == SWAP) && !view)
				throw new Error(type + " requires a view to be present");
		}

		override public function clone():Event
		{
			return new FlowEvent(type, view);
		}

		override public function toString():String
		{
			return "[FlowEvent type=\"" + type + "\" view=\"" + view + "\"]";
		}
	}
}