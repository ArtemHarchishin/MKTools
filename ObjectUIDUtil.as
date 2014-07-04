package MKTools
{
	import flash.utils.Dictionary;
	public class ObjectUIDUtil {
		private static var _uids:Dictionary = new Dictionary(true);
		private static var _cter:uint = 1;
		public static function getUID(obj:Object):uint {
			var ret:uint = _uids[obj];
			return (ret == 0) ? (_uids[obj] = _cter++) : ret;
		}
	}
}
