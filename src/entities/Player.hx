package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

import scenes.TextScene;

class Player extends Entity {
	public function new(x:Int, y:Int) {
		_img = new Image(Assets.GRAPHIC_SHIP);
		_img.centerOrigin();
		_img.alpha = 1;

		super(x, y, _img);

		setHitboxTo(_img);
		type = "Player";

		layer = Constants.LAYER_PLAYER;
	}

	override public function update() {
		handleInput()

		if (x < 32 + HXP.camera.x)
			x = 32 + HXP.camera.x;
		else if (x > HXP.width - 32 + HXP.camera.x)
			x = HXP.width - 32 + HXP.camera.x;

		if (y < 32)
			y = 32;
		else if (y > HXP.height - 32)
			y = HXP.height - 32;

		if (_img.alpha >= 1) {
			if (collide("Enemy", x, y) != null
				|| collide("PBullet", x, y) != null) {
				kill();
			}
		} else {
			_img.alpha += HXP.elapsed;
		}

		if (_fireDelay > 0) {
			_fireDelay -= HXP.elapsed;
		} else if (Input.check("fire")) {
			fire();
		}
	}

	private function handleInput() {
		if (Input.check("right"))
			x += _moveSpeed * HXP.elapsed;
		else if (Input.check("left"))
			x -= _moveSpeed * HXP.elapsed;
		else if (Input.check("up"))
			y -= _moveSpeed * HXP.elapsed;
		else if (Input.check("down"))
			y += _moveSpeed * HXP.elapsed;
	}

	private function fire() {
		HXP.scene.create(
			Bullet, true,
			[x, y + 10, Assets.GRAPHIC_PLAYER_BULLET, [0, 1, 2], 400, 0]
		);
		HXP.scene.create(
			Bullet, true,
			[x, y - 10, Assets.GRAPHIC_PLAYER_BULLET, [0, 1, 2], 400, 0]
		);
		_fireDelay = 0.2;
	}

	private function kill() {
		Variables.particleEmitter.explosion(Std.int(x), Std.int(y));
		Variables.lives--;
		Variables.currentHUD.updateLives();
		
		if (Variables.lives < 0)
			HXP.scene.end();
		x = 32 + HXP.camera.x;
		y = HXP.halfHeight;
		_img.alpha = 0;
	}

	private var _img:Image;
	private var _fireDelay:Float = 0;
	private var _moveSpeed:Float = 200;
}