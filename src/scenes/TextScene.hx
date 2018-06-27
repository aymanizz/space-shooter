package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
using com.haxepunk.utils.Input;

class TextScene extends Scene {
	public function new(txt:String) {
		super();

		var text = new Text(txt);
		text.align = "center";
		
		var screen = new Entity(HXP.halfWidth - (text.width / 2), HXP.halfHeight, text);
		add(screen);
	}

	override public function update() {
		super.update();

		if (Input.check("begin"))
				HXP.scene = new GameScene();
	}
}