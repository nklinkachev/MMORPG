package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author N.Klinkachev
	 */
	public class NavigationEvent extends Event 
	{
		public static const CHANGE_SCREEN:String = "CHANGE_SCREEN";
		public var params:Object;
		
		public function NavigationEvent(type:String, params:Object=null, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			this.params = params;
		}
		
	}

}