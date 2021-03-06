// TitleScreenState.hx
package;

import GameState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxInputText;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

using StringTools;

/*
	Title screen state.
	This is also where mod levels can be loaded.
	I'll work up a nice little front-end for this later but this is how you do it as of now.
 */
class TitleScreenState extends GameState
{
	var funFactsArray:Array<String> = PathsAndStuff.grabText("funFacts.txt").split("\n");
	var transingOut:Bool = false;

	public static var ogmoName:String;
	public static var levName:String;

	override public function new(transingOut:Bool = false)
	{
		this.transingOut = transingOut;
		super();
	}

	var ogmoInput:FlxInputText;
	var levInput:FlxInputText;

	override public function create()
	{
		var text = new FlxText(10, -200, 0, "UNTITLED\nDUNGEON\nCRAWLER", 32, true);
		text.angle = new FlxRandom().int(-20, 20);
		text.alignment = CENTER;
		text.screenCenter(X);
		add(text);
		var funFactText = new FlxText(3, 3, 0, "FUN FACT: ", 16, true);
		if (funFactsArray == null)
			funFactText.text += "funFacts.txt is empty!"
		else
			funFactText.text += funFactsArray[new FlxRandom().int(0, funFactsArray.length - 1)];
		add(funFactText);
		FlxTween.tween(text, {y: 200, angle: 0}, 2, {ease: FlxEase.quintOut});
		var playButton:FlxButton = new FlxButton(10, 500, "Play", playGame);
		playButton.screenCenter(X);
		add(playButton);
		var optionsButton:FlxButton = new FlxButton(10, 505 + playButton.height, "Options", playGame);
		optionsButton.screenCenter(X);
		add(optionsButton);
		ogmoInput = new FlxInputText(3, 6 + funFactText.height, 200, "crawl");
		levInput = new FlxInputText(3, 9 + funFactText.height + ogmoInput.height, 200, "lev1");
		add(ogmoInput);
		add(levInput);
		if (transingOut)
			transOut(FlxColor.RED);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		ogmoName = ogmoInput.text;
		levName = levInput.text;
	}

	function playGame()
	{
		transIn(FlxColor.RED, new LoadingState(FlxColor.RED, new PlayState()));
	}
}
