package MKTools
{
	import starling.display.DisplayObjectContainer;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class InstanceNameShow
	{
		private var _downVisible:Boolean;
		public function InstanceNameShow(resource:DisplayObjectContainer, downVisible:Boolean = false, show_all:* = 1)
		{
			_downVisible = downVisible;
			resource.addEventListener(TouchEvent.TOUCH, onFingerTouch);
			mtr(1, resource.name + " numChildren = " + resource.numChildren);
			if (show_all) show_all_children(resource, 0);
		}

		private function show_all_children(resource:DisplayObjectContainer, tab:int):int
		{
			for (var i:int = 0; i < resource.numChildren; i++)
			{
				var child:* = resource.getChildAt(i);
				trace(get_tab(tab) + i + '.   ' + child.name + get_tab(tab) + '\t' + child);
				if (child.hasOwnProperty('numChildren') && child.numChildren > 0)
				{
					tab++;
					tab = show_all_children(child, tab);
				}
			}

			return --tab;
		}

		private function onFingerTouch(e:TouchEvent):void
		{
			var t:Touch = e.touches[0];
			if (t == null || t.target == null || t.phase != TouchPhase.ENDED)
			{
				return;
			}

			trace('---', t.target, t.target.name);
			var parent:DisplayObjectContainer = t.target.parent;
			if (_downVisible) t.target.visible = false;
			var i:int = 0;
			while (parent)
			{
				trace(get_tab(i) + parent, parent.name, parent.numChildren);
				parent = parent.parent;
				i++;
			}
		}

		private static function get_tab(tab:int):String
		{
			var s:String = '';
			for (var i:int = 0; i < tab; i++)
			{
				s += ' ';
			}
			return  s;
		}
	}
}

