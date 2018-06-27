package entities;

import flash.display.BitmapCompressColorSpace;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Spritemap;

class HUD extends Entity {
	public function new() {
		lives = new Array<Spritemap>();
		var glist = new Graphiclist();

		var bg = Image.createRect(HXP.width, 20, 0x000000);
		bg.scrollX = 0;
		bg.scrollY = 0;
		bg.alpha = 0.5;
		glist.add(bg);

		pointsText = new Text("Points: 0", HXP.width - 200, 2, 200);
		pointsText.scrollX = 0;
		pointsText.scrollY = 0;
		glist.add(pointsText);

		for (i in 1...4) {
			var life = new Spritemap(Assets.GRAPHIC_LIVES, 16, 16);
			life.add("idle", [0]);
			life.add("die", [1, 2, 3, 4], 4, false);
			life.scrollX = 0;
			life.scrollY = 0;
			life.x = 10 + i * 16;
			life.y = 2;
			lives.push(life);
			glist.add(life);
		}

		super(0, 0);

		graphic = glist;
		layer = Constants.LAYER_HUD;
	}

	public function updatePoints() {
		pointsText.text = "Points: " + Variables.points;
	}

	public function updateLives() {
		if (Variables.lives >= 0 && Variables.lives < lives.length) 
			lives [Variables.lives].play("die");
	}

	private var lives:Array<Spritemap>;
	private var pointsText:Text; 
}