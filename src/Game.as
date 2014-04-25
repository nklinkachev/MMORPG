package  
{
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.SmartFox;
	import events.NavigationEvent;
	import flash.utils.Dictionary;
	import screens.*;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import com.smartfoxserver.v2.core.SFSEvent;
	
	/**
	 * ...
	 * @author N.Klinkachev
	 */
	public class Game extends Sprite 
	{
		private var screens:Dictionary;
		private var current_screen:BaseScreen;
		
		public static var sfs:SmartFox;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			sfs = new SmartFox();
			sfs.debug = false;
         
			// Add SFS2X event listeners
			sfs.addEventListener(SFSEvent.CONNECTION, onConnection)
			sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost)
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess)
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure)
			sfs.addEventListener(SFSEvent.LOGOUT, onLogout);
			
			trace("SmartFox API: " + sfs.version)
		}
		
		private function onAddedToStage(event:Event):void
		{	
			trace("Starling Framework Initialized");
			
			screens = new Dictionary();
			screens["main_screen"] = new MainScreen();
			screens["ingame_screen"] = new IngameScreen();
			screens["disconnected_screen"] = new DisconnectedScreen();
			screens["register_screen"] = new RegisterScreen();
			
			try_connect();
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			var id:String = event.params.id;
			if (screens[id])
				changeScreen(id);
		}
		
		private function changeScreen(screenID:String):void
		{
			if (current_screen != null) {
				this.removeChild(current_screen);
				current_screen.terminate();
			}
			
			current_screen = screens[screenID];
			current_screen.initialize();
			this.addChild(current_screen);
		}
		
		private function try_connect():void
		{
			//TODO: load configuration from xml
			sfs.connect("77.100.221.120", 9933);
			
			/*
			// Load the default configuration file, config.xml
			sfs.loadConfig()
			*/
		}
	 
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// SFS2X event handlers
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 
		private function onConnection(evt:SFSEvent):void
		{
			if (evt.params.success)
			{
				trace("Connection Success!");
				changeScreen("main_screen");
			}
			else
			{
				trace("Connection Failure: " + evt.params.errorMessage)
			}
		}
		 
		private function onConnectionLost(evt:SFSEvent):void
		{
			trace("Connection was lost. Reason: " + evt.params.reason);
			changeScreen("disconnected_screen");
		}
		 
		private function onConfigLoadSuccess(evt:SFSEvent):void
		{
			trace("Config load success!");
			trace("Server settings: " + sfs.config.host + ":" + sfs.config.port);
		}
		 
		private function onConfigLoadFailure(evt:SFSEvent):void
		{
			trace("Config load failure!!!")
		}
		
		private function onLogout(evt:SFSEvent):void
		{
			trace("Logged out!");
			changeScreen("login_screen");
		}
	}

}