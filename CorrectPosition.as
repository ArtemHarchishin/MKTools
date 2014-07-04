package MKTools
{
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import ui.Container;

	public class CorrectPosition
	{
		private function row(...cols):void
		{
			TraceOnStage.trace_to(_stage, cols);
		}

		private var _target:Container;
		private var _stage:Sprite;

		public function CorrectPosition(stage:Sprite, target:Container)
		{
			_stage = stage;
			_target = target;

			var height:int = 30;
			var width:int = 30;

			var left:Quad = new Quad(width, height, 0x00ff00);
			left.addEventListener(TouchEvent.TOUCH, onLeft);
			left.x = height;
			left.y = height * 2;
			addChild(left);

			var top:Quad = new Quad(width, height, 0xff0000);
			top.addEventListener(TouchEvent.TOUCH, onTop);
			top.x = height * 2;
			top.y = height;
			addChild(top);

			var right:Quad = new Quad(width, height, 0x0000ff);
			right.addEventListener(TouchEvent.TOUCH, onRight);
			right.x = height * 3;
			right.y = height * 2;
			addChild(right);

			var down:Quad = new Quad(width, height, 0xffff00);
			down.addEventListener(TouchEvent.TOUCH, onDown);
			down.x = height * 2;
			down.y = height * 2;
			addChild(down);
		}

		private function addChild(child:DisplayObject):DisplayObject
		{
			if (_stage) return _stage.addChild(child);
			return null;
		}

		private function onDown(e:TouchEvent):void
		{
			if (!isClicked(e)) return;
			_target.y += 1;
			row('.x =', _target.x, '.y =', _target.y);
			mtr(1, '.x =', _target.x, '.y =', _target.y);
		}

		private function onTop(e:TouchEvent):void
		{
			if (!isClicked(e)) return;
			_target.y -= 1;
			row('.x =', _target.x, '.y =', _target.y);
			mtr(1, '.x =', _target.x, '.y =', _target.y);
		}

		private function onRight(e:TouchEvent):void
		{
			if (!isClicked(e)) return;
			_target.x += 1;
			row('.x =', _target.x, '.y =', _target.y);
			mtr(1, '.x =', _target.x, '.y =', _target.y);
		}

		private function onLeft(e:TouchEvent):void
		{
			if (!isClicked(e)) return;
			_target.x -= 1;
			row('.x =', _target.x, '.y =', _target.y);
			mtr(1, '.x =', _target.x, '.y =', _target.y);
		}

		private function isClicked(e:TouchEvent):Boolean
		{
			var t:Touch = e.touches[0];
			if (t == null || t.target == null || t.phase != TouchPhase.ENDED)
				return false;
			return true;
		}
	}
}
