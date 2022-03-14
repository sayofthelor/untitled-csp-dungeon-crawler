package;

import flixel.math.FlxRandom;
import GameState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

using StringTools;

class TitleScreenState extends GameState
{
	var funFactsArray:Array<String> = PathsAndStuff.grabText("funFacts.txt").split("\n");
	override public function create()
	{
		var text = new FlxText(10, -200, 0, "UNTITLED\nDUNGEON\nCRAWLER", 32, true);
		text.angle = new FlxRandom().int(-20, 20);
		text.alignment = CENTER;
		text.screenCenter(X);
		add(text);
		var funFactText = new FlxText(3, 50, 0, "FUN FACT:", 16, true);
		if (funFactsArray == null) funFactText.text = "FUN FACT: funFacts.txt is empty!" else funFactText.text = "FUN FACT: " + funFactsArray[new FlxRandom().int(0, funFactsArray.length - 1)];
		add(funFactText);
		FlxTween.tween(text, {y: 200, angle:0}, 2, {ease: FlxEase.quintOut});
		var playButton:FlxButton = new FlxButton(10, 600, "Play", playGame);
		playButton.screenCenter(X);
		add(playButton);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function playGame()
	{
		transIn(FlxColor.RED, new PlayState());
	}
}
