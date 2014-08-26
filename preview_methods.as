package MKTools
{
	import assets.GUI_mob.FreeMovesAdditionalPort;

	import com.freshplanet.ane.AirFacebook.Facebook;

	import flash.utils.getTimer;

	import managers.StuckManager;

	import net.Connection;
	import net.socialapi.AAASocApi;
	import net.socialapi.Data.FriendsAppList;
	import managers.FriendsManager;
	import net.socialapi.Data.SocApiUser;
	import net.socialapi.Networks.WallPostImageType;
	import net.socialapi.VKConnect;

	import ui.UIParser;
	import ui.WebBrowser;

	import utils.LangManager;
	import utils.Log;

	public class preview_methods
	{
		public static function getFriends_3moves():void
		{

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

				return random_user as Object;
			}
		}

		public static function sendRequest():void
		{
			var idx:int = int(Math.random() * 13);
			var msg:String = "post_invite_" + (idx == 0 ? "1" : idx);
			AAASocApi.api.sendRequest(LangManager.get(msg), new <String>['260387100'], null);
		}

		public static function try_add_child():void
		{
			UIParser.parse(new FreeMovesAdditionalPort())
		}

		public static function share():void
		{
			VKConnect.api('wall.post', {owner_id: '2118332', message: 'hi'}, function (r:Object)
			{
				var r:* = 0;
			});
			return;

			VKConnect.api('apps.sendRequest', {user_id: '2118332', text: 'hi', type: 'invite'}, function (r:Object)
			{
				var r:* = 0;
			});
			return;
			var idx:int = int(Math.random() * 13);
			var msg:String = "post_invite_" + (idx == 0 ? "1" : idx);
			AAASocApi.api.sendNoticeOnWall('', LangManager.get(msg), WallPostImageType.GAME_UPDATE, 0, share_via_api);
		}

		public static function share_via_api(do_share:Boolean = true):void
		{
			var before:Array;
			var after:Array;
			VKConnect.api('wall.get', {owner_id: 27563553, filter: 'owner', offset: 27563553}, function (...args):void
			{
				before = args;
				var idx:int = int(Math.random() * 13);
				var msg:String = "post_invite_" + (idx == 0 ? "1" : idx);
				WebBrowser.dispatcher.addEventListener('WebBrowserClosed', function (e:*):void
				{
					VKConnect.api('wall.get', {owner_id: 27563553, filter: 'owner', offset: 27563553}, function (...args):void
					{
						after = args;
					});
				});
				AAASocApi.api.sendNoticeOnWall('', LangManager.get(msg), WallPostImageType.GAME_UPDATE, 0, null);
			});
		}

		public static function increment_level():void
		{
			FakeGame.level_id += 1;
		}

		public static function jammed_friends():void
		{
			/*public function toString():String
			{
				var s:String = '';
				for each (var socApiUser:SocApiUser in _allFriends)
				{
					s += socApiUser + ' , ';
				}
				return s;
			}*/
			var users:Array = friends_for_test();
			var socApiUsers:Array = [];
			for each (var user:Object in users)
			{
				var sau:SocApiUser = new SocApiUser();
				sau.network_id = user.network_id;
				sau.dbID = user.dbID;
				sau.first_name = user.first_name;
				sau.last_name = user.last_name;
				sau.level = user.level;
				sau.vip = user.vip;
				sau.email = user.email;
				sau.score = user.score;
				sau.last_level_score = user.last_level_score;
				sau.total_score = user.total_score;
				sau.sex = user.sex;
				sau.bdate = user.bdate;
				sau.country = user.country;
				sau.online = user.online;
//				sau.jammed = user.jammed;
//				sau.jammed = true;
				sau.collected = user.collected;
				sau.in_top_friends_list = user.in_top_friends_list;
				sau.last_days_visit = user.last_days_visit;
				sau.paying = user.paid;
				sau.friends_count = user.friends_count;
				sau.photo = user._photo;
				socApiUsers.push(sau);
			}
		}

		public static function wall_posts():void
		{
			VKConnect.api('wall.get', {owner_id: '275635530', filter: 'owner', offset: '275635530'}, function (response:Object):void
			{
				if (response.hasOwnProperty('error'))
				{
//				VKConnect:response {"response":[330]}
//				VKConnect:response {"error":{"error_code":18)
					trace(response);

				}

			});

			var o:Object = {prop: "i_am_value" };
			var s:int = getTimer();
			for (var i:int = 0; i < 100000; i++)
			{
				if (o.hasOwnProperty('prop')) var r:* = true;
			}
			trace(getTimer() - s);

			s = getTimer();
			for (var j:int = 0; j < 100000; j++)
			{
				if (o.prop) var rr:* = true;
			}
			trace(getTimer() - s);
			var r:* = 0;

		}

		public static function load_jammed_friends():void
		{
			StuckManager.instance.updateStuckList();
//			Connection.loadJammedFriends(function (r:String):void
//			{
//				var d:Object = JSON.parse(r);
//				if (d.friends_jammed)
//				{
//					StuckManager.instance.setStuckList(d.friends_jammed);
//				}
//			});
			var j_data:Object = {};
			j_data["action"] = "check";
			j_data["user_id"] = '27563553';
			Connection.accept_help_jammed_level({"j_data":JSON.stringify(j_data)}, function(r:* = null):void {
				var data : Object = JSON.parse(r);
				trace(data['can_help']);
				trace(data);
				if (data['can_help']){

				}
			});

		}

		public static function buy_booster():void
		{
			Connection.buyBoosterForSeeds(new FakeBooster(), function(r:* = null):void {
				var rr:* = 0;
			});
//			new FakeGame();
//			new FakeGamePanel().testProceedTouch();
		}

		public static function random_msg():void
		{
			var idx:int = int(Math.random() * 14);
			var msg:String = "post_invite_" + (idx == 0 ? "1" : idx);
			trace(msg);
			trace(idx);
			trace(LangManager.get(msg));

//			public function toString():String
//			{
//				return "SocApiUser{network_id=" + String(network_id) + ",first_name=" + String(first_name) + ",last_name=" + String(last_name) + ",level=" + String(level) + ",vip=" + String(vip) + ",score=" + String(score) + ",last_level_score=" + String(last_level_score) + ",total_score=" + String(total_score) + ",online=" + String(online) + ",jammed=" + String(jammed) + ",collected=" + String(collected) + ",in_top_friends_list=" + String(in_top_friends_list) + ",last_days_visit=" + String(last_days_visit) + ",paying=" + String(paying) + ",friends_count=" + String(friends_count) + "}";
//			}
		}

		public static function ask3moves():void
		{
			Connection.ask3Moves('155257');
		}

		public static function tryFB():void
		{
			var response:Object = {"params":"request=835306913155858&to%5B0%5D=100008193036547","accessToken":"CAAJnUHN4bRkBAGZCgr772l9Dc9kdr6dKuhjmRO2dBbZC5DZCB76i39mejySVxDjxkwAv7sVywZBGvL71XgRCsd4KvoVO2nc56FQIyva4FD3G1cUpoMFkZC7nJY92aOHaVpkT8J0CbxHFlvgPeMPzKiybTYd5t1x62jyKpJr5vMo91JvDK2oWQZCo36txTH6ZAcXs2DpHwPrsnPaVtyobTUBDSGe2isi6LC8nXw2yikZBvRZB9WXVhmQFe"};

			/*
			{"params":"request=1465173580410881&to%5B0%5D=100008193036547","accessToken":"CAAJnUHN4bRkBAGZCgr772l9Dc9kdr6dKuhjmRO2dBbZC5DZCB76i39mejySVxDjxkwAv7sVywZBGvL71XgRCsd4KvoVO2nc56FQIyva4FD3G1cUpoMFkZC7nJY92aOHaVpkT8J0CbxHFlvgPeMPzKiybTYd5t1x62jyKpJr5vMo91JvDK2oWQZCo36txTH6ZAcXs2DpHwPrsnPaVtyobTUBDSGe2isi6LC8nXw2yikZBvRZB9WXVhmQFe"}

			{"cancel":true,"accessToken":"CAAJnUHN4bRkBAGZCgr772l9Dc9kdr6dKuhjmRO2dBbZC5DZCB76i39mejySVxDjxkwAv7sVywZBGvL71XgRCsd4KvoVO2nc56FQIyva4FD3G1cUpoMFkZC7nJY92aOHaVpkT8J0CbxHFlvgPeMPzKiybTYd5t1x62jyKpJr5vMo91JvDK2oWQZCo36txTH6ZAcXs2DpHwPrsnPaVtyobTUBDSGe2isi6LC8nXw2yikZBvRZB9WXVhmQFe"}

			{"cancel":true,"accessToken":"CAAJnUHN4bRkBAGZCgr772l9Dc9kdr6dKuhjmRO2dBbZC5DZCB76i39mejySVxDjxkwAv7sVywZBGvL71XgRCsd4KvoVO2nc56FQIyva4FD3G1cUpoMFkZC7nJY92aOHaVpkT8J0CbxHFlvgPeMPzKiybTYd5t1x62jyKpJr5vMo91JvDK2oWQZCo36txTH6ZAcXs2DpHwPrsnPaVtyobTUBDSGe2isi6LC8nXw2yikZBvRZB9WXVhmQFe"}

			{"params":"request=762358390471855&to%5B0%5D=100008193036547","accessToken":"CAAJnUHN4bRkBAGZCgr772l9Dc9kdr6dKuhjmRO2dBbZC5DZCB76i39mejySVxDjxkwAv7sVywZBGvL71XgRCsd4KvoVO2nc56FQIyva4FD3G1cUpoMFkZC7nJY92aOHaVpkT8J0CbxHFlvgPeMPzKiybTYd5t1x62jyKpJr5vMo91JvDK2oWQZCo36txTH6ZAcXs2DpHwPrsnPaVtyobTUBDSGe2isi6LC8nXw2yikZBvRZB9WXVhmQFe"}

			{"params":"request=265603846979640&to%5B0%5D=100008193036547","accessToken":"CAAJnUHN4bRkBAGZCgr772l9Dc9kdr6dKuhjmRO2dBbZC5DZCB76i39mejySVxDjxkwAv7sVywZBGvL71XgRCsd4KvoVO2nc56FQIyva4FD3G1cUpoMFkZC7nJY92aOHaVpkT8J0CbxHFlvgPeMPzKiybTYd5t1x62jyKpJr5vMo91JvDK2oWQZCo36txTH6ZAcXs2DpHwPrsnPaVtyobTUBDSGe2isi6LC8nXw2yikZBvRZB9WXVhmQFe"}

			{"params":"request=835306913155858&to%5B0%5D=100008193036547","accessToken":"CAAJnUHN4bRkBAGZCgr772l9Dc9kdr6dKuhjmRO2dBbZC5DZCB76i39mejySVxDjxkwAv7sVywZBGvL71XgRCsd4KvoVO2nc56FQIyva4FD3G1cUpoMFkZC7nJY92aOHaVpkT8J0CbxHFlvgPeMPzKiybTYd5t1x62jyKpJr5vMo91JvDK2oWQZCo36txTH6ZAcXs2DpHwPrsnPaVtyobTUBDSGe2isi6LC8nXw2yikZBvRZB9WXVhmQFe"}

			{"params":"request=687623421315798&to%5B0%5D=100008193036547","accessToken":"CAAJnUHN4bRkBAGZCgr772l9Dc9kdr6dKuhjmRO2dBbZC5DZCB76i39mejySVxDjxkwAv7sVywZBGvL71XgRCsd4KvoVO2nc56FQIyva4FD3G1cUpoMFkZC7nJY92aOHaVpkT8J0CbxHFlvgPeMPzKiybTYd5t1x62jyKpJr5vMo91JvDK2oWQZCo36txTH6ZAcXs2DpHwPrsnPaVtyobTUBDSGe2isi6LC8nXw2yikZBvRZB9WXVhmQFe"}*/

			if (response == null)
			{
				var onCancel = null;
				return;
			}

			if (response.error && response.error == 'null')
			{
				var onCancel = null;
				return;
			}

			var callBackParams = [];
			if (response["params"])
			{
				var params:Array = response["params"].split("&");
				for (var i:int = 0; i < params.length; i++)
				{
					var param:Array = params[i].split("=");
					if (param[0] && param[0].indexOf("to[") != -1 && param[1])
					{
						callBackParams.push(param[1]);
					}
				}


				var newCall = callBackParams;
			} else {
							var fail = 0;
			}
		}

		public static function fb_online():void
		{
//			user_online_presence or friends_online_presence permissions to view: online_presence
			var query:String = "SELECT uid, first_name, last_name, pic_square, pic_big, online_presence, sex FROM user WHERE uid IN (" + FriendsManager.instance.allFriendsHash.getKeys().join(",") + ")";
			Facebook.getInstance().requestWithGraphPath("/fql", {"q": query}, "GET",
					function (r:Object, fail:Object = null):void
					{
						Log.e("preview_methods.fb_online: " + JSON.stringify(r));
					});
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

