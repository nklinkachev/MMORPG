package 
{
	import flash.display.Sprite;
	import starling.core.Starling;
	import net.hires.debug.Stats;
	
	[SWF(frameRate="60", width="800", height="600", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private var stats:Stats;
		private var starling:Starling;
		
		public function Main()
		{
			new Assets();
			stats = new Stats();
			addChild(stats);
			
			starling = new Starling(Game, stage);
			starling.antiAliasing = 1;
			starling.start();
		}
	}
	
}