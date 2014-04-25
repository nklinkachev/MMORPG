package screens 
{
	import events.NavigationEvent;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author N.Klinkachev
	 */
	public class BaseScreen extends Sprite 
	{
		public var id:String;
		
		public function BaseScreen() 
		{
			super();
			id = "base_screen";
		}
		
		public function initialize():void
		{
			this.visible = true;
			this.addEventListener(Event.TRIGGERED, onTriggered);
		}
		
		public function terminate():void
		{
			this.visible = false;
			this.removeEventListener(Event.TRIGGERED, onTriggered);
		}
		
		public function navigate(screenID:String):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id:screenID }, true));
		}
		
		protected function onTriggered(event:Event):void
		{
			
		}
		
		 
		
	}

}