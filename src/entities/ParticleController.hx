package entities;

import flash.display.BitmapData;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Ease;

class ParticleController extends Entity {
	public function new() {
		_emitter = new Emitter(new BitmapData(3, 3, false, 0xFFFFFF), 3, 3);
		_emitter.newType("explosion", [0]);
		_emitter.setMotion("explosion", 0, 100, 2, 360, -200, Ease.quadOut);
		_emitter.setAlpha("explosion", 1, 0.1);

		graphic = _emitter;
		layer = Constants.LAYER_PARTICLES;

		super();
	}

	public function explosion(posX:Int, posY:Int, color1:Int = 0xFFFFFF, color2:Int = 0xFFFFFF, particles:Int = 20) {
		_emitter.setColor("explosion", color1, color2);

		for (i in 0...particles)
			_emitter.emit("explosion", posX, posY); 
	}

	private var _emitter:Emitter;
}