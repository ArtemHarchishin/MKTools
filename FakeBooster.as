package MKTools
{
	import data.Booster;
	import data.ShopListItems;

	import starling.display.Sprite;

	public class FakeBooster extends Booster
	{
		public function FakeBooster()
		{
			super({
				name: "Booster",
				id: ShopListItems.BOOST_CAT,
				price: 10,
				price_level: 10,
				need: "need",
				type: TYPE_BOOSTER,
				image: new Sprite(),
				count: 10,
				expires: "expires",
				outOfDate: "outOfDate",
				time: "time",
				atlasName: "texture_atlas"
			});
		}
	}
}
