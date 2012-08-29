
package mtsk.jumpblocks
{
	public class JBController
	{
		private var model:JBModel;
		public function JBController(model:JBModel)
		{
			this.model = model;
		}
		public function intro():void
		{
			this.model.startTransition();
		}
		public function transition():void
		{
			this.model.startTransition();
		}
		public function endTransition():void
		{
			this.model.endTransition();
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