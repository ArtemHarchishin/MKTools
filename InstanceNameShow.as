package MKTools
{
	import flash.utils.getQualifiedClassName;

	import starling.display.DisplayObjectContainer;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class InstanceNameShow
	{
		private var _downVisible:Boolean;

		public function InstanceNameShow(resource:*, downVisible:Boolean = false, isFromTop:Boolean = true, show_direct_hierarchy:Boolean = true)
		{
			_downVisible = downVisible;
			if (resource.hasOwnProperty('numChildren')) mtr(1, resource.name + " numChildren = " + resource.numChildren);
			if (isFromTop)
			{
				startFromTopObject(resource, show_direct_hierarchy);
			} else
			{
				startFromBottomObject(resource);
			}
		}

		/*
		 Object in the display hierarchy
		 */
		private function startFromBottomObject(resource:*):void
		{
			var r:* = resource.parent;
			var i:int = 0;
			while (r)
			{
				trace(get_tab(i) + r, r.name, getQualifiedClassName(r));
				r = r.parent;
				i++;
			}
			resource.addEventListener(TouchEvent.TOUCH, onFingerTouchBottomObject);
		}

		private function onFingerTouchBottomObject(e:TouchEvent):void
		{
			var t:Touch = e.touches[0];
			if (t == null || t.target == null || t.phase != TouchPhase.ENDED)
			{
				return;
			}

			trace('---', t.target, t.target.name, t.target.hasOwnProperty('text') ? 'text=' + t.target['text'] : '');
			var parent:DisplayObjectContainer = t.target.parent;
			if (_downVisible) t.target.visible = false;
			var i:int = 0;
			while (parent)
			{

				trace(get_tab(i) + parent, parent.name, parent.numChildren, parent.hasOwnProperty('text') ? 'text=' + t['text'] : '');
				parent = parent.parent;
				i++;
			}
		}

		/*
		 Object in the display hierarchy
		 */
		private function startFromTopObject(resource:*, show_direct_hierarchy:Boolean = true):void
		{
			resource.addEventListener(TouchEvent.TOUCH, onFingerTouchTopObject);
			if (show_direct_hierarchy) show_all_children(resource, 0);

			function show_all_children(resource:DisplayObjectContainer, tab:int):int
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
		}

		private function onFingerTouchTopObject(e:TouchEvent):void
		{
			var t:Touch = e.touches[0];
			if (t == null || t.target == null || t.phase != TouchPhase.ENDED)
			{
				return;
			}

			trace('---', t.target, t.target.name, t.target.hasOwnProperty('text') ? 'text=' + t.target['text'] : '');
			var parent:DisplayObjectContainer = t.target.parent;
			if (_downVisible) t.target.visible = false;
			var i:int = 0;
			while (parent)
			{

				trace(get_tab(i) + parent, parent.name, parent.numChildren, parent.hasOwnProperty('text') ? 'text=' + t['text'] : '');
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

