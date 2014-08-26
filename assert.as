package MKTools
{
	[Inline]
	public function assert(truth:*): void
	{
//		ASSERT::enabled
//		{
			if (!truth)
			{
				var error:Error = new Error("Assertion failed!");
				trace(error.getStackTrace());
				throw error;
			}
//		}
		return; // <-- added
	}
}
