package MKTools
{
	import data.Game;

	import games.bubble.BubbleField;
	import games.bubble.BubbleMain;

	import ui.dialogs.lists.FriendData;

	public class FakeGame extends Game
	{
		public static var level_id:int = 0;

		public function FakeGame()
		{
			var o:Object = {level: {tileMap: [
				[0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0],
			],
				id: 20}
			};
			super(o);
			try
			{
				new BubbleMain(o);
			} catch (e:Error)
			{
				// do nothing
			}
			new BubbleField(this);
		}
	}
}
