package MKTools
{
	import assets.GUI_mob.FreeMovesAdditionalPort;


	import com.milkmangames.nativeextensions.android.AndroidItemDetails;

	import data.FriendsLock;

	import flash.utils.getTimer;

	import games.bubble.BubbleMain;

	import managers.StuckManager;

	import net.Connection;
	import net.socialapi.AAASocApi;
	import net.socialapi.Data.FriendsAllList;
	import net.socialapi.Data.FriendsAppList;
	import net.socialapi.Data.SocApiUser;
	import net.socialapi.Networks.SocApiNetwork;
	import net.socialapi.Networks.WallPostImageType;
	import net.socialapi.VKConnect;

	import org.osmf.layout.LayoutTargetSprite;

	import ui.UIParser;
	import ui.WebBrowser;
	import ui.panels.GamePanel;

	import utils.LangManager;

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
				var user:SocApiUser;
				for each (user in FriendsAllList.instance.getListFor3MovesRequests())
				{
					if (!FriendsLock.instance.isLocked(user.network_id, Connection.FRIEND_REQUEST_DAILY) && !FriendsAppList.instance.has(user.network_id))
					{
						random_user = user;
//						FriendsAllList.moveToBottom_viralList(user);
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

		public static function friends_3moves():void
		{
			var users:Array = friends_for_test();
			var chunk:int = users.length / 10;
			var rest:int = users.length % 10;
			var settings:Object = {
				A1111n: {online: 1, play: 1, paid: 1, days2: 1, mdays: null, count: chunk},
				B1101n: {online: 1, play: 1, paid: 0, days2: 1, mdays: null, count: chunk},
				C10nnn: {online: 1, play: 0, paid: null, days2: null, mdays: null, count: chunk},
				D0111n: {online: 0, play: 1, paid: 1, days2: 1, mdays: null, count: chunk},
				E0101n: {online: 0, play: 1, paid: 0, days2: 1, mdays: null, count: chunk},
				F00nnn: {online: 0, play: 0, paid: null, days2: null, mdays: null, count: chunk},
				G1n1n1: {online: 1, play: 1, paid: 1, days2: null, mdays: 1, count: chunk},
				H1n0n1: {online: 1, play: 1, paid: 0, days2: null, mdays: 1, count: chunk},
				I0n1n1: {online: 0, play: 1, paid: 1, days2: null, mdays: 1, count: chunk},
				Jnn0n0: {online: null, play: 1, paid: 0, days2: null, mdays: 0, count: chunk + rest}
			};

			var index:int = 0;
			var socApiUsers:Array = [];
			for each (var setO:Object in settings)
			{
				for (var i:int = 0; i < setO.count; i++)
				{
					var userSet:Object = users[index];
					var user:SocApiUser = new SocApiUser();
					user.network_id = userSet.network_id;
					user.dbID = userSet.dbID;
					user.first_name = userSet.first_name;
					user.last_name = userSet.last_name;
					user.level = userSet.level;
					user.vip = userSet.vip;
					user.email = userSet.email;
					user.score = userSet.score;
					user.last_level_score = userSet.last_level_score;
					user.total_score = userSet.total_score;
					user.sex = userSet.sex;
					user.bdate = userSet.bdate;
					user.country = userSet.country;
					user.online = (setO.online == 1);
					user.jammed = userSet.jammed;
					user.collected = userSet.collected;
					user.in_top_friends_list = userSet.in_top_friends_list;
					// days2
					user.last_days_visit = setO.days2 == 1 ? 3 : 1;
					// paid
					user.paying = setO.paid == null ? 0 : setO.paid;
					user.friends_count = userSet.friends_count;
					user.photo = userSet._photo;
					socApiUsers.push(user);
					index++;
				}
			}
//			public function toString():String {
//				return "{network_id:" + String(network_id)+
//						",dbID:" + String(dbID) +
//						",first_name:'" + String(first_name) + "'" +
//						",last_name:'" + String(last_name) + "'" +
//						",level:" + String(level) +
//						",vip:" + String(vip) +
//						",email:" + (email == '' ? "' '" : email) +
//						",score:" + String(score) +
//						",last_level_score:" + String(last_level_score) +
//						",total_score:" + String(total_score) +
//						",sex:" + String(sex) +
//						",bdate:'" + String(bdate) + "'" +
//						",country:" + (country == '' ? "' '" : country) +
//						",online:" + String(online) +
//						",jammed:" + String(jammed) +
//						",collected:" + String(collected) +
//						",in_top_friends_list:" + String(in_top_friends_list) +
//						",last_days_visit:" + String(last_days_visit) +
//						",paying:" + String(paying) +
//						",friends_count:" + String(friends_count) +
//						",_photo:'" + String(_photo) + "'},";
//			}
//            FriendsAllList.allFriends = socApiUsers;
			var A1111n:Array = [];
			var B1101n:Array = [];
			var C10nnn:Array = [];
			var D0111n:Array = [];
			var E0101n:Array = [];
			var F00nnn:Array = [];
			var G1n1n1:Array = [];
			var H1n0n1:Array = [];
			var I0n1n1:Array = [];
			var Jnn0n0:Array = [];
			for each (var sau:SocApiUser in socApiUsers)
			{
				//A1111n: {online:1, play:1, paid:1, days2:1, mdays:null, count:chunk},
				if (sau.online == true && FriendsAppList.instance.has(sau.network_id) == true && sau.paying > 0 && sau.last_days_visit > 2)
				{
					A1111n.push(sau);
					continue;
				}
				//B1101n: {online:1, play:1, paid:0, days2:1, mdays:null, count:chunk},
				if (sau.online == true && FriendsAppList.instance.has(sau.network_id) == true && sau.paying == 0 && sau.last_days_visit > 2)
				{
					B1101n.push(sau);
					continue;
				}
				//C10nnn: {online:1, play:0, paid:null, days2:null, mdays:null, count:chunk},
				if (sau.online == true && FriendsAppList.instance.has(sau.network_id) == false)
				{
					C10nnn.push(sau);
					continue;
				}
				//D0111n: {online:0, play:1, paid:1, days2:1, mdays:null, count:chunk},
				if (sau.online == false && FriendsAppList.instance.has(sau.network_id) == true && sau.paying > 0 && sau.last_days_visit > 2)
				{
					D0111n.push(sau);
					continue;
				}
				//E0101n: {online:0, play:1, paid:0, days2:1, mdays:null, count:chunk},
				if (sau.online == false && FriendsAppList.instance.has(sau.network_id) == true && sau.paying == 0 && sau.last_days_visit > 2)
				{
					E0101n.push(sau);
					continue;
				}
				//F00nnn: {online:0, play:0, paid:null, days2:null, mdays:null, count:chunk},
				if (sau.online == false && FriendsAppList.instance.has(sau.network_id) == false)
				{
					F00nnn.push(sau);
					continue;
				}
				//G111n1: {online:1, play:1, paid:1, days2:null, mdays:1, count:chunk},
				if (sau.online == true && FriendsAppList.instance.has(sau.network_id) == true && sau.paying > 0 && sau.last_days_visit > 2)
				{
					G1n1n1.push(sau);
					continue;
				}
				//H110n1: {online:1, play:1, paid:0, days2:null, mdays:1, count:chunk},
				if (sau.online == true && FriendsAppList.instance.has(sau.network_id) == true && sau.paying == 0 && sau.last_days_visit > 2)
				{
					H1n0n1.push(sau);
					continue;
				}
				//I011n1: {online:0, play:1, paid:1, days2:null, mdays:1, count:chunk},
				if (sau.online == false && FriendsAppList.instance.has(sau.network_id) == true && sau.paying > 0 && sau.last_days_visit > 2)
				{
					I0n1n1.push(sau);
					continue;
				}
				//Jn10n0: {online:null, play:1, paid:0, days2:null, mdays:0, count:chunk + rest}
				if (FriendsAppList.instance.has(sau.network_id) == true && sau.paying == 0 && sau.last_days_visit > 2)
				{
					Jnn0n0.push(sau);
				}
			}

			var resE:Array = A1111n.concat(B1101n).concat(C10nnn).concat(D0111n).concat(E0101n).concat(F00nnn).concat(G1n1n1).concat(H1n0n1).concat(I0n1n1).concat(Jnn0n0)
			trace(A1111n.length + B1101n.length + C10nnn.length + D0111n.length + E0101n.length + F00nnn.length + G1n1n1.length + H1n0n1.length + I0n1n1.length + Jnn0n0.length);

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
				sau.jammed = true;
				sau.collected = user.collected;
				sau.in_top_friends_list = user.in_top_friends_list;
				sau.last_days_visit = user.last_days_visit;
				sau.paying = user.paid;
				sau.friends_count = user.friends_count;
				sau.photo = user._photo;
				socApiUsers.push(sau);
			}
//			FriendsAllList.instance.allFriends = socApiUsers;
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
			new FakeGame();
			new FakeGamePanel().testProceedTouch();
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

