package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;

class Bullet extends Entity {
	public function new(x:Int, y:Int, sprt:String, arr:Array<Int>,
		xMovement:Int, yMovement:Int, target:String = "Bullet") {
		_sprite = new Spritemap(sprt, 10, 10);
		_sprite.add("idle", arr, arr.length * 4);
		_sprite.play("idle");
		_sprite.centerOrigin();

		super(x, y, _sprite);

		setHitbox(6, 6, 1, 3);
		type = target;

		layer = Constants.LAYER_BULLETS;

		_xMovement = xMovement;
		_yMovement = yMovement;
	}

	override public function update() {
		x += _xMovement * HXP.elapsed;
		y += _yMovement * HXP.elapsed;

		if (x > HXP.camera.x + HXP.width + 50 || x < HXP.camera.x - 50)
			HXP.scene.remove(this);

		var bcollide = collide(type == "Bullet" ? "PBullet" : "Bullet", x, y);
		if (bcollide != null) {
			HXP.scene.remove(this);
			HXP.scene.remove(bcollide);
		}
	}

	private var _sprite:Spritemap;
	private var _xMovement:Int;
	private var _yMovement:Int;
}