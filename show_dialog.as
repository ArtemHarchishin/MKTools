package MKTools
{
	import data.Game;

	import flash.utils.describeType;

	import games.bubble.BubbleMain;

	import ui.dialogs.lists.FriendData;

	public function show_dialog(cls:Class):Function
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

				new InstanceNameShow(dlg);

				if (dlg.hasOwnProperty('showBeat'))
				{
					// for dialog BeatFriendOnLevelDialogMobile
					var friendData:FriendData = new FriendData();
					BubbleMain.friendMaxScoreOnCurrentLevel = friendData;
					// for dialog BeatFriendOnLevelDialogMobile
					friendData.currentLevelScore = 20;
					friendData.photoUrl = 'https://pp.vk.me/c313222/v313222553/7397/OPRH8BZL-uo.jpg';
					friendData.network_id = '27563553';
					BubbleMain.friendBeforeTheTopCurrentLevel = friendData;
					dlg.showBeat.apply(null, args);
				}
				else if (dlg.hasOwnProperty('showAtEnd'))
				{
					dlg.showAtEnd.apply(null, args);
				}
				else if (dlg.hasOwnProperty('showBooster'))
				{
					dlg.showBooster.apply(null, args);
				}
				else if (dlg.hasOwnProperty('showHelp'))
				{
					dlg.showHelp.apply(null, args);
				}
				else if (dlg.hasOwnProperty('proof'))
				{
					dlg.proof.apply(null, args);
				}
				else if (dlg.hasOwnProperty('showResults'))
				{
					if (args.length >= 2 && args[1] is FakeGame) (args[1] as FakeGame).level = FakeGame.level_id;
					dlg.showResults.apply(null, args);
				}
				else if (dlg.hasOwnProperty('showLevelInfo'))
				{
					dlg.showLevelInfo.apply(null, args);
				}
				else if (dlg.hasOwnProperty('show'))
				{
					dlg.show();
				}
			}

		}
	}
}
