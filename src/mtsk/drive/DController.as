package mtsk.drive
{
	public class DController
	{
		private var model:DModel;
		public function DController(model:DModel)
		{
			this.model = model;
		}
		public function intro():void
		{
			this.model.transition();
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