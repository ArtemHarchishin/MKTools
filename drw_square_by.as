package MKTools
{
	/*
	 * {x: 0, y:0, width: 0, height: 0, parent: null}
	 */

	public function drw_square_by(o:Object, useFlash:Boolean):Object
	{
		if (!o.parent) return {};
		var r:int = int(Math.random() * 10);
		var border:*;
		var rand_color:Number = [0, 0x00FF00, 0x0000FF, 0xFF0000, 0xFFFFFF, 0x008080, 0x660099, 0x003399, 0x4169e1, 0x03c03c][r];
		var result:Object = {};
		if (useFlash)
		{
			import flash.display.DisplayObjectContainer;
			import flash.display.Sprite;
			import flash.text.TextField;

			border = new Sprite();
			border.graphics.lineStyle(1, rand_color);
			border.graphics.drawRect(o.x, o.y, o.width, o.height);

			o.parent.addChild(border);
			result.parent = o.parent;

			var center:Sprite = new Sprite();
			center.graphics.lineStyle(3, rand_color);
			center.graphics.drawCircle(0, 0, 2);

			if (!(o is DisplayObjectContainer))
			{
				if (!(o is TextField)) return {};
				o = (o as TextField).parent;
			}
			if (o.hasOwnProperty('addChild'))
				o.addChild(center);

			result.border = border;
			result.center = center;
			result.object = o;

		} else
		{
			import starling.display.Quad;

			border = new Quad(o.width, o.height, rand_color);
			border.alpha = 0.5;
			border.x = o.x;
			border.y = o.y;
			o.parent.addChild(border);
			result.parent = o.parent;

			result.border = border;
			result.center = center;
			result.object = o;
		}
		return result;
	}
}
