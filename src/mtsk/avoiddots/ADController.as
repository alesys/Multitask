package mtsk.avoiddots
{	
	public class ADController
	{
		private var model:ADModel;
		public function ADController(model:ADModel)
		{
			this.model = model;
		}
		public function pause():void
		{
			this.model.pause();
		}
		public function unpause():void
		{
			this.model.unpause();	
		}
	}
}