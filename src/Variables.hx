import entities.Player;
import entities.HUD;
import entities.ParticleController;

class Variables {
	public static var player:Player;
	public static var particleEmitter:ParticleController;
	public static var currentHUD:HUD;
	public static var lives:Int;
	public static var points:Int;

	public static function reset() {
		player = new Player(64, Std.int(com.haxepunk.HXP.halfHeight));
		currentHUD = new HUD();
		lives = 3;
		points = 0;
		particleEmitter = new ParticleController();
	}
}