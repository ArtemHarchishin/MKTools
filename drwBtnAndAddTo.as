package MKTools
{
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class drwBtnAndAddTo
	{
		private static var _last_x:int = 50;
		//	/Main.as:610
		public function drwBtnAndAddTo(useFlash:Boolean, parent:*, clicked:Function, txt:String = 'click_me'):void
		{
			if (useFlash)
			{
				import flash.display.Stage

				var myTxtBtn:MyTxtBtn = new MyTxtBtn(clicked, txt);
				myTxtBtn.x = _last_x;
				myTxtBtn.y = 0;
				parent.addChild(myTxtBtn);
				_last_x = myTxtBtn.x + myTxtBtn.width;
			} else
			{
				import starling.display.DisplayObjectContainer;

				var w:int = 500, h:int = 500;
				var btn:Quad = new Quad(w, h, 0xff0000);

				function onBtn(e:TouchEvent):void
				{
					if (!isClicked(e)) return;
					clicked(e);
				}

				btn.addEventListener(TouchEvent.TOUCH, onBtn);
				btn.x = parent.width / 2;
				btn.y = parent.height / 2;
				parent.addChild(btn);

				function isClicked(e:TouchEvent):Boolean
				{
					var t:Touch = e.touches[0];
					if (t == null || t.target == null || t.phase != TouchPhase.ENDED)
						return false;
					return true;
				}
			}
		}
	}
}


