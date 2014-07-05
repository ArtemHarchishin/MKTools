package MKTools
{
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;

	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;

	public class TraceOnStage
	{
		private static const queue:Dictionary = new Dictionary(true);
		private static var counter:int = 0;

		public static function trace_to(stage:DisplayObjectContainer, ...rest):void
		{
			if (stage == null)
			{
				trace('>>>>>>>>>>>>>> Stage is NULL !!! <<<<<<<<<<<<<<<<');
				return;
			}

			var logger:TextField;
			if (queue[stage] != null)
			{
				logger = (queue[stage] as TextField);
				if (logger.text.length > 150) logger.text = '';
				logger.text = rest.join(',') + ';';
			} else
			{
				logger = new TextField(stage.width / 2, 50, rest.join(','), "Verdana", 40, 0xffffff, true);
				logger.border = true;
				logger.touchable = false;
				stage.addChild(logger);
				queue[stage] = logger;
			}
		}

		public static function need_delay_trace_to(stage:DisplayObjectContainer, ...rest):void
		{
			if (stage.parent == null)
			{
				if (counter >= 20)
				{
					counter = 0;
					return;
				}

				setTimeout(function ()
				{
					need_delay_trace_to(stage, rest);
				}, 1000);

				counter++;

				return;
			} else
			{
				trace_to(stage, rest);
			}
		}

		public static function getObjectMemoryHash(obj:*):String
		{
			var memoryHash:String;
			try
			{
				FakeClass(obj);
			}
			catch (e:Error)
			{
				memoryHash = String(e).replace(/.*([@|\$].*?) to .*$/gi, '$1');
			}
			return memoryHash
		}
	}
}
internal final class FakeClass
{
}
