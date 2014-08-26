package MKTools
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class MyTxtBtn extends TextField
	{
		private var _clicked:Function;
		const size:int = 12;
		public function MyTxtBtn(clicked:Function, text:String)
		{
			_clicked = clicked;
			this.border = true;
			this.borderColor = 0x363433;

			this.background = true;
			this.backgroundColor = 0x141414;

			this.selectable = false;

			this.text = text;
			//"Arial"
			this.setTextFormat(new TextFormat(null, size, 0x999999, true));
			//this.embedFonts = true;
			this.autoSize = "left";
			this.mouseEnabled = true;
			this.alpha = 0.7;

			addEventListener(MouseEvent.MOUSE_OVER, highlight);
			addEventListener(MouseEvent.MOUSE_OUT, lowlight);
			addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(e:MouseEvent):void
		{
			if (_clicked != null) _clicked();
			e.stopImmediatePropagation();
			e.stopPropagation();
		}

		public function highlight(e:MouseEvent = null):void
		{
			//"Arial"
			this.setTextFormat(new TextFormat(null, size, 0xffffff, true));
		}

		public function lowlight(e:MouseEvent = null):void
		{
			//"Arial"
			this.setTextFormat(new TextFormat(null, size, 0x999999, true));
		}

	}
}
