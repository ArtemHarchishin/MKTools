package MKTools
{
	import ui.panels.GamePanel;

	public class FakeGamePanel extends GamePanel
	{
		public function FakeGamePanel()
		{
			super();
			_currentBooster = new FakeBooster();
		}

		protected override function initView():void
		{

		}

		public function testProceedTouch():void
		{
			proceedTouch(new FakeBooster());
		}

		public override function deactivateManualBooster(addToUser:Boolean = false):void
		{

		}
	}
}
