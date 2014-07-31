package MKTools
{
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public function drwBtnAndAddTo(useFlash:Boolean, parent:*, clicked:Function, w:int = 500, h:int = 500):void
	{
		if (useFlash)
		{
			import flash.display.Stage

			var myTxtBtn:MyTxtBtn = new MyTxtBtn(clicked, 'click_me');
			myTxtBtn.x = 100;
			myTxtBtn.y = 0;
			parent.addChild(myTxtBtn);
		} else
		{
			import starling.display.DisplayObjectContainer;
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
