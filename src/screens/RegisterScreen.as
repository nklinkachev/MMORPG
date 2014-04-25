package screens 
{
	import com.smartfoxserver.v2.requests.LoginRequest;
	import feathers.controls.TextInput;
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.Image;
	
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	
	/**
	 * ...
	 * @author N.Klinkachev
	 */
	public class RegisterScreen extends BaseScreen 
	{
		
		private var usernameTxt:TextInput;
		private var passwordTxt:TextInput;
		private var emailTxt:TextInput;
		private var registerBtn:Button;
		
		// The SignUp extension command
		private var CMD_SUBMIT:String = "$SignUp.Submit";
		
		public function RegisterScreen() 
		{
			super();
			
			id = "register_screen";
			
			var btnTexture:Texture = Assets.getTexture("ButtonTex");
			var bgSkin:Image = new Image(btnTexture);
			
			usernameTxt = new TextInput();
			usernameTxt.width = 400;
			usernameTxt.height = 30;
			usernameTxt.backgroundSkin = new Image(btnTexture);
			usernameTxt.textEditorProperties.fontFamily = "Verdana";
			usernameTxt.textEditorProperties.fontSize = 16;
			usernameTxt.textEditorProperties.color = 0xFFFFFF;
			usernameTxt.x = 150;
			usernameTxt.y = 300;
			
			passwordTxt = new TextInput();
			passwordTxt.width = 400;
			passwordTxt.height = 30;
			passwordTxt.backgroundSkin = new Image(btnTexture);
			passwordTxt.textEditorProperties.fontFamily = "Verdana";
			passwordTxt.textEditorProperties.fontSize = 16;
			passwordTxt.textEditorProperties.color = 0xFFFFFF;
			passwordTxt.x = 150;
			passwordTxt.y = 340;
			
			emailTxt = new TextInput();
			emailTxt.width = 400;
			emailTxt.height = 30;
			emailTxt.backgroundSkin = new Image(btnTexture);
			emailTxt.textEditorProperties.fontFamily = "Verdana";
			emailTxt.textEditorProperties.fontSize = 16;
			emailTxt.textEditorProperties.color = 0xFFFFFF;
			emailTxt.textEditorProperties.bold = true;
			emailTxt.x = 150;
			emailTxt.y = 380;
			
			registerBtn = new Button(btnTexture, "Register");
			registerBtn.width = btnTexture.width;
			registerBtn.height = btnTexture.height;
			registerBtn.fontColor = 0xffffff;
			registerBtn.fontName = "Verdana";
			registerBtn.fontSize = 16;
			registerBtn.fontBold = true;
			registerBtn.x = 150;
			registerBtn.y = 420;
			
			this.addChild(usernameTxt);
			this.addChild(passwordTxt);
			this.addChild(emailTxt);
			this.addChild(registerBtn);
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			Game.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			Game.sfs.addEventListener(SFSEvent.LOGIN, onLogin);
			Game.sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			
			Game.sfs.send(new LoginRequest("", "", "Registration"));
		}
		
		override public function terminate():void 
		{
			super.terminate();
			Game.sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			Game.sfs.removeEventListener(SFSEvent.LOGIN, onLogin);
			Game.sfs.removeEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
		}
		
		override protected function onTriggered(event:Event):void 
		{
			super.onTriggered(event);
			var button:Button = event.target as Button;
			
			if (button == registerBtn)
			{
				sendSignUpData();
			}
		}
		
		private function onLogin(event:SFSEvent):void
		{
			trace("Logged in registration zone.");
		}
		
		private function onLoginError(event:SFSEvent):void
		{
			trace("Loggin failed:" + event.params.errorMessage);
		}
		
		// Send the registration data
		private function sendSignUpData():void
		{
			var sfso:SFSObject = new SFSObject();
			sfso.putUtfString("username", usernameTxt.text);
			sfso.putUtfString("password", passwordTxt.text);
			sfso.putUtfString("email", emailTxt.text);
			 
			Game.sfs.send(new ExtensionRequest(CMD_SUBMIT, sfso));
}
 
		private function onExtensionResponse(evt:SFSEvent):void
		{
			var cmd:String = evt.params["cmd"];
			var sfso:ISFSObject = evt.params["params"];
			 
			if (cmd == CMD_SUBMIT)
			{
				if (sfso.containsKey("success"))
					trace("Success, thanks for registering");
				else
					trace("SignUp Error:" + sfso.getUtfString("errorMessage"));
			}
		}
	}

}