package nl.folkamsterdam.flow
{
	import org.flexunit.async.Async;
	import nl.folkamsterdam.flow.events.FlowEvent;
	import nl.folkamsterdam.flow.dummies.ViewDummy;
	import nl.folkamsterdam.flow.dummies.events.CustomFlowEvent;

	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class CustomEventsTest
	{
		private var container:Sprite;
		private var eventDispatcher:IEventDispatcher;
		private var flowManager:FlowManager;
		private var view1:ViewDummy;
		private var view2:ViewDummy;

		[Before]
		public function before():void
		{
			container = new Sprite();
			eventDispatcher = new EventDispatcher();
			flowManager = new FlowManager(container, eventDispatcher, CustomFlowEvent);
			view1 = new ViewDummy();
			view2 = new ViewDummy();
		}
		
		[Test(async)]
		public function does_not_listen_to_FlowEvent_ANIMATE_OUT_CURRENT():void
		{
			flowManager.animateInNew(view1);
			
			Async.failOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);
			
			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_OUT_CURRENT));
		}
		
		[Test(async)]
		public function listens_to_CustomFlowEvent_ANIMATE_OUT_CURRENT():void
		{
			flowManager.animateInNew(view1);
			
			Async.proceedOnEvent(this, view1, ViewDummy.EXIT_COMPLETE);
			
			eventDispatcher.dispatchEvent(new CustomFlowEvent(CustomFlowEvent.ANIMATE_OUT_CURRENT));
		}
		
		[Test(async)]
		public function does_not_listen_to_FlowEvent_ANIMATE_IN_NEW():void
		{
			Async.failOnEvent(this, view1, ViewDummy.ENTER_COMPLETE);
			
			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.ANIMATE_IN_NEW, view1));
		}
		
		[Test(async)]
		public function listens_to_CustomFlowEvent_ANIMATE_IN_NEW():void
		{
			Async.proceedOnEvent(this, view1, ViewDummy.ENTER_COMPLETE);
			
			eventDispatcher.dispatchEvent(new CustomFlowEvent(CustomFlowEvent.ANIMATE_IN_NEW, view1));
		}
		
		[Test(async)]
		public function does_not_listen_to_FlowEvent_SWAP():void
		{
			flowManager.animateInNew(view1);
			
			Async.failOnEvent(this, view2, ViewDummy.ENTER_COMPLETE);
			
			eventDispatcher.dispatchEvent(new FlowEvent(FlowEvent.SWAP, view2));
		}
		
		[Test(async)]
		public function listens_to_CustomFlowEvent_SWAP():void
		{
			flowManager.animateInNew(view1);
			
			Async.proceedOnEvent(this, view2, ViewDummy.ENTER_COMPLETE);
			
			eventDispatcher.dispatchEvent(new CustomFlowEvent(CustomFlowEvent.SWAP, view2));
		}
		
		[After]
		public function after():void
		{
			view2 = null;
			view1 = null;

			flowManager.destruct();
			flowManager = null;

			eventDispatcher = null;

			container = null;
		}
	}
}