package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Backdrop;

import entities.Player;
import entities.Enemy;
import entities.ParticleController;
import entities.HUD;

class GameScene extends Scene {
	override public function begin () {
		Variables.reset();

		add (Variables.currentHUD);
		add (Variables.player);
		add (Variables.particleEmitter);

		var bg_1 = new Backdrop (Assets.GRAPHIC_STARS_1);
		bg_1.scrollX = 0.25;
		bg_1.scrollY = 0.25;

		var bg_2 = new Backdrop (Assets.GRAPHIC_STARS_2);
		bg_2.scrollX = 0.50;
		bg_2.scrollY = 0.50;

		var bg_3 = new Backdrop (Assets.GRAPHIC_STARS_3);
		bg_3.scrollX = 0.75;
		bg_3.scrollY = 0.75;

		var e = new Entity();
		e.graphic = new Graphiclist ([bg_1, bg_2, bg_3]);
		e.layer = Constants.LAYER_BACKGROUND;
		add (e);
	}

	override public function update () {
		super.update();

		camera.x += camSpeed * HXP.elapsed;
		Variables.player.x += camSpeed * HXP.elapsed;
		spawnTimer -= HXP.elapsed;

		if (spawnTimer < 0) {
			spawnTimer = 0.5;
			var enemy = create(
					Enemy, true,
					[HXP.camera.x + HXP.width + 100, HXP.rand (HXP.height)]
			);
		}
	}

	override public function end () {
		HXP.scene = new TextScene(
			"Game Over. Your final score was "
			+ Variables.points
			+ ". Press ENTER to continue."
		);
	}

	private var spawnTimer:Float = 0.5;
	private var camSpeed:Float = 50;
}