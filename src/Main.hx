import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Main extends Engine {
	override public function init() {
		#if debug
		HXP.console.enable();
		#end
		HXP.scene = new scenes.TextScene("Press ENTER to start playing");

		Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("up", [Key.UP, Key.W]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("fire", [Key.SPACE]);
		Input.define("begin", [Key.ENTER]);
	}

	public static function main() { new Main(); }
}