package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Enemy extends Entity {
	public function new(x:Int, y:Int) {
		var msk = new Pixelmask(Assets.GRAPHIC_SHIP, -16, -16);

		_img = new Image(Assets.GRAPHIC_ENEMY);
		_img.centerOrigin();

		super(x, y, _img, msk);

		type = "Enemy";

		layer = Constants.LAYER_ENEMY;
	}

	override public function added() {
		_killed = false;
	}

	override public function update() {
		if (y < 32 && speedY < 0)
			speedY *= -1;
		else if (y > HXP.height - 32 && speedY > 0)
			speedY *= -1;

		y += speedY * HXP.elapsed;

		if (x < HXP.camera.x - 100 - width)
			destroy();

		var collidedBullet = collide("Bullet", x, y);
		if (collidedBullet != null) {
			HXP.scene.remove(collidedBullet);
			_killed = true;
			destroy();
		}

		if (_fireDelay < 0)
			fire()
		else
			_fireDelay -= HXP.elapsed;
	}

	private function fire() {
		HXP.scene.create(
			Bullet, true, [
				x, y, Assets.GRAPHIC_ENEMY_BULLET, [0, 1, 2],
				-400, 0, "PBullet"
			]
		);

		_fireDelay = 2;
	}

	private function destroy() {
		if (_killed) {
			Variables.points += 100;
			Variables.currentHUD.updatePoints();
			Variables.particleEmitter.explosion(Std.int(x), Std.int(y));
		}
		HXP.scene.remove(this);
	}

	private var _img:Image;
	private var speedY:Int = 50;
	private var _killed:Bool;
	private var _fireDelay:Float = 2;
}