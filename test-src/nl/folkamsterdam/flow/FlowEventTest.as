package nl.folkamsterdam.flow
{
	import nl.folkamsterdam.flow.events.FlowEvent;
	public class FlowEventTest
	{
		[Test(expects="Error")]
		public function using_type_ANIMATE_IN_NEW_without_view_throws_Error():void
		{
			new FlowEvent(FlowEvent.ANIMATE_IN_NEW); 
		}
		
		[Test(expects="Error")]
		public function using_type_SWAP_CURRENT_VIEW_WITH_NEW_without_view_throws_Error():void
		{
			new FlowEvent(FlowEvent.SWAP); 
		}
	}
}