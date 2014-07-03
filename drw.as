package MKTools {
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.text.TextField;

public function drw(o:Object):Object {
    if (!o.parent) return {};

    var r:int = int(Math.random() * 10);
    var rand_color:Number = [0, 0x00FF00, 0x0000FF, 0xFF0000, 0xFFFFFF, 0x008080, 0x660099, 0x003399, 0x4169e1, 0x03c03c][r];

    var border:Sprite = new Sprite();
    border.graphics.lineStyle(1, rand_color);
    border.graphics.drawRect(o.x, o.y, o.width, o.height);

    var result:Object = {};
    o.parent.addChild(border);
    result.parent = o.parent;

    var center:Sprite = new Sprite();
    center.graphics.lineStyle(3, rand_color);
    center.graphics.drawCircle(0, 0, 2);

    if (!(o is DisplayObjectContainer)) {
        if (!(o is TextField)) return {};
        o = (o as TextField).parent;
    }
    o.addChild(center);

    result.border = border;
    result.center = center;
    result.object = o;

    return result;
}
}
