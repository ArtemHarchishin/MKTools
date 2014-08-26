package MKTools
{
	public const mtr:Function = init_trace();
}

function init_trace():Function
{
	var selected_tr:Function;
	try
	{
		import flash.system.ApplicationDomain;

		ApplicationDomain.currentDomain.getDefinition("net.mobile.MobileNetworkingManager");

		import net.mobile.MobileNetworkingManager;

		import utils.Log;

		if (['ipad2', 'iphone4'].indexOf(MobileNetworkingManager.device_name) >= 0) selected_tr = Log.add;
	} catch (e:ReferenceError)
	{
		// ignore
	}

	if (!selected_tr) selected_tr = trace;

	return function (condition:*, ...rest):Boolean
	{
		if (!condition) return false;

		for each(var o:* in rest)
		{
			if (o is Object)
			{
				var o_print:String = "\nit's Object: ";
				var is_p:Boolean = false;
				for (var p:String in o)
				{
					o_print += p + " = " + o[p] + ', ';
					is_p = true;
				}
				if (is_p)
				{
					selected_tr(o_print.slice(0, o_print.length - 2));
					selected_tr('\n');
				}
			}
		}

		var new_rest:Array = [];
		for each(var o:* in rest)
		{
			new_rest.push(o == null ? 'null' : o);
		}

//          Error
//			наш метод
//		 	at net::Connection$/save()[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:284]  // здесь написан наш трейс
//		 	at net::Connection$/load()[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:1197] // откуда вызван метод в котором наш трейс
//		 	at net::Connection$/onSendComplete()[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:812]
//		 	at flash.events::EventDispatcher/dispatchEventFunction()
//		 	at flash.events::EventDispatcher/dispatchEvent()
//		 	at flash.net::URLLoader/onComplete()

		var trace:Array = new Error().getStackTrace().split('\n');
		var our_call:Array = trace[2].split('[');
//		 	at net::Connection$/save()[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:284]

//		 	at net::Connection$/save()
// 			[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:284]

		try
		{
			var from_our_call:Array = trace[3].split('[');
//		 	at net::Connection$/load()[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:1197]

//		 	at net::Connection$/load()
// 			[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:1197]
		} catch (e:Error)
		{
			return false;
		}

		var t:Array = our_call[0].split('/');
//		 	at net::Connection$/
// 			save()
		var tt:Array = from_our_call[0].split('/');
//		 	at net::Connection$/
// 			load()

		var call_m:String = t[t.length - 1];
// 			save()
		var from_call_m:String = tt[tt.length - 1];
// 			load()

		call_m = call_m.slice(0, call_m.length - 2);
// 			save
		from_call_m = from_call_m.slice(0, from_call_m.length - 2);
// 			load

		if (call_m.indexOf(':') >= 0)
		{
			t = call_m.split(':');
			call_m = t[t.length - 1];
		}

		var call_l:String = our_call[1];
// 			[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:284]
		var from_call_l:String = from_our_call[1];
// 			[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:1197]

		call_l = call_l.split(':')[2];
// 			[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:
// 			284]
		from_call_l = from_call_l.split(':')[2];
// 			[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:
// 			1197]

		var ta:Array;
		var call_class:String;
		var from_call_class:String;

		ta = our_call[1].split(':')[1].split("\\");
		call_class = ta[ta.length - 1];
// 			[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:284]
		ta = from_our_call[1].split(':')[1].split("\\");
		from_call_class = ta[ta.length - 1];
// 			[D:\Projects\zombieranch\front_end_mobile\src\net\Connection.as:1197]

		call_l = call_l.slice(0, call_l.length - 1);
// 			284
		from_call_l = from_call_l.slice(0, from_call_l.length - 1);
// 			1197

		if (rest.length == 0) selected_tr('--->', call_m + ":" + call_l, '<---');
		else selected_tr(from_call_class + "." + from_call_m + ":" + from_call_l + " " + call_class + "." + call_m + ":" + call_l, "->", new_rest.join(" :: "), '<-');
		return true;
	}
}
