package MKTools
{
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;

	public function trace_to(stage:DisplayObjectContainer, ...rest):void
	{
		var logger:TextField = new TextField(100, 50, '',"Verdana", 40, 0xffffff, true);
		logger.text = rest.join(",") + "\n";
		logger.border = true;
		stage.addChild(logger);
	}
}
