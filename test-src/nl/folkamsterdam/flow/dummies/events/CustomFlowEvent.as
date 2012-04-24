package nl.folkamsterdam.flow.dummies.events
{
	import nl.folkamsterdam.flow.events.FlowEvent;

	import flash.display.DisplayObject;

	public class CustomFlowEvent extends FlowEvent
	{
		public static const ANIMATE_OUT_CURRENT:String = "animateOutCurrent";
		public static const ANIMATE_IN_NEW:String = "animateInNew";
		public static const SWAP:String = "swap";
		
		public function CustomFlowEvent(type:String, view:DisplayObject = null)
		{
			super(type, view);
		}
	}
}