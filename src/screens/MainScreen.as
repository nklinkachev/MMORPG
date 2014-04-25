package screens 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import events.NavigationEvent;
	import feathers.controls.ImageLoader;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import com.smartfoxserver.v2.core.SFSEvent;
	/**
	 * ...
	 * @author N.Klinkachev
	 */
	public class MainScreen extends BaseScreen 
	{
		private var usernameTxt:TextInput;
		private var passwordTxt:TextInput;
		private var connectBtn:Button;
		
		public function MainScreen() 
		{
			super();
			
			id = "main_screen";
			
			var btnTexture:Texture = Assets.getTexture("ButtonTex");
			var bgSkin:Image = new Image(btnTexture);
			
			usernameTxt = new TextInput();
			usernameTxt.width = 400;
			usernameTxt.height = 30;
			usernameTxt.backgroundSkin = new Image(btnTexture);
			usernameTxt.x = 150;
			usernameTxt.y = 300;
			
			passwordTxt = new TextInput();
			passwordTxt.width = 400;
			passwordTxt.height = 30;
			passwordTxt.backgroundSkin = new Image(btnTexture);
			passwordTxt.x = 150;
			passwordTxt.y = 340;
			
			connectBtn = new Button(btnTexture, "Login");
			connectBtn.width = btnTexture.width;
			connectBtn.height = btnTexture.height;
			connectBtn.x = 150;
			connectBtn.y = 380;
			
			this.addChild(usernameTxt);
			this.addChild(passwordTxt);
			this.addChild(connectBtn);
		}
		
		override protected function onTriggered(event:Event):void 
		{
			super.onTriggered(event);
			var button:Button = event.target as Button;
			if (button == connectBtn)
			{
				// try logging in
				Game.sfs.send(new LoginRequest(usernameTxt.text, passwordTxt.text, "MMORPG"));
			}
		}
		
		override public function initialize():void 
		{
			super.initialize();
			Game.sfs.addEventListener(SFSEvent.LOGIN, onLogin);
			Game.sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
		}
		
		override public function terminate():void
		{
			super.terminate();
			Game.sfs.removeEventListener(SFSEvent.LOGIN, onLogin);
			Game.sfs.removeEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
		}
		
		private function onLogin(event:SFSEvent):void
		{
			trace("Logged in!");
			dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id:"ingame_screen" }, true));
		}
		
		private function onLoginError(event:SFSEvent):void
		{
			trace("Login failed: " + event.params.errorMessage);
		}
	}
}