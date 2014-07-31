package MKTools
{
	import data.FriendsLock;

	import flash.utils.describeType;

	import net.Connection;
	import net.socialapi.AAASocApi;
	import net.socialapi.Data.FriendsAllList;
	import net.socialapi.Data.FriendsAppList;
	import net.socialapi.Data.SocApiUser;

	import utils.LangManager;

	public class preview_methods
	{
		public static function getFriends():void
		{
//			Используемая логика выбора друга
//			Поиск по друзьям онлайн, играющим в игру и платящим и те, кого не было в игре больше 2ух дней
//			Если таких нет - по друзьям онлайн, играющим в игру и не платящим и которых не было в игре более 2ух дней
//			+++Если таких нет - поиск среди не играющих друзей, которые онлайн
//			Если таких нет - поиск по друзьям оффлайн, играющим в игру и платящим и те, кого не было в игре больше 2ух дней
//			Если таких нет - по друзьям оффлайн, играющим в игру и не платящим и которых не было в игре более 2ух дней
//			+++Если таких нет - по друзьям не в сети, не играющим в игру
//			Если таких нет - поиск по друзьям онлайн, которые дольше всех не заходили в игру и платящие
//			Если таких нет - по друзьям онлайн, которые дольше всех не заходили в игру и не платящие
//			Если таких нет - по друзьям не в сети, которые дольше всех не заходили в игру и платящие
//			Если таких нет - которые дольше всех не заходили в игру и неплатящие

//			Поиск по друзьям онлайн, играющим в игру и платящим и те, кого не было в игре больше 2ух дней
//			по друзьям онлайн, играющим в игру и не платящим и которых не было в игре более 2ух дней
//			поиск по друзьям оффлайн, играющим в игру и платящим и те, кого не было в игре больше 2ух дней
//			по друзьям оффлайн, играющим в игру и не платящим и которых не было в игре более 2ух дней
//			поиск по друзьям онлайн, которые дольше всех не заходили в игру и платящие
//			по друзьям онлайн, которые дольше всех не заходили в игру и не платящие
//			по друзьям не в сети, которые дольше всех не заходили в игру и платящие
//			которые дольше всех не заходили в игру и неплатящие
			var idx:int = int(Math.random() * 7);
			var _randFriend:Object = getFriend();
			var msg:String = "invite_request" + (idx == 0 ? "" : "_" + idx);

//			CONFIG::ru{
//				AAASocApi.api.sendRequest( LangManager.get( msg ), new <String>['260387100'],function ok(){}, function fail(){},function cancel(){});
//			}
//			CONFIG::int{
//				AAASocApi.api.sendInvite( LangManager.get( msg ), new <String>[_randFriend.network_id],function ok(){}, function fail(){}, function cancel(){});
//			}

			function getFriend():Object
			{
				var random_user:SocApiUser = null;
				var user:SocApiUser;
				for each (user in FriendsAllList.getSmartListForRequests())
				{
					if (!FriendsLock.instance.isLocked(user.network_id, Connection.FRIEND_REQUEST_DAILY) && !FriendsAppList.issetFriendById(user.network_id))
					{
						random_user = user;
						FriendsAllList.moveToBottom_viralList(user);
						break;
					}

				}
				return random_user as Object;
			}
		}

		public static function sendRequest():void
		{
			var idx:int = int(Math.random() * 13);
			var msg:String = "post_invite_" + (idx == 0 ? "1" : idx);
			AAASocApi.api.sendRequest(LangManager.get(msg), new <String>['260387100'], null);
		}

		public static function showDialog(cls:Class):Function
		{
			var root:XML = describeType(cls);
			var factory:XMLList = root.child('factory');
			var extendsClasses:XMLList = factory.child('extendsClass');
			var has:Boolean = false;
			for each (var extClass:XML in extendsClasses)
			{
				if (extClass.attribute('type') == 'ui.dialogs::Dialog')
				{
					has = true;
					break;
				}
			}

			if (!has) throw new Error();

			return function (...args):Function
			{
				return function ():void
				{
					var dlg:* = new cls();
					if (dlg.hasOwnProperty('showResults'))
					{
						dlg.showResults.apply(null, args);
					}
					else if (dlg.hasOwnProperty('show'))
					{
						dlg.show();
					}
				}

			}
		}
	}
}

class Delegate
{
	public static function create(handler:Function, ...args):Function
	{
		return function (...innerArgs):void
		{
			handler.apply(this, innerArgs.concat(args));
		}
	}
}

