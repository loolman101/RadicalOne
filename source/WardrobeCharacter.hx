package;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;

using StringTools;

class WardrobeCharacter extends FlxSprite
{
    public var animOffsets:Map<String, Array<Dynamic>>;

    public var isLikeBF:Bool = false;

    public var char:String;

    public function new(x:Float, y:Float, char:String)
    {
        animOffsets = new Map<String, Array<Dynamic>>();
        super(x, y);

        this.char = char;

        switch (char)
        {
            case 'Old Radical':
                var tex = FlxAtlasFrames.fromSparrow(Character.charPath + 'OgRacial.png', Character.charPath + 'OgRacial.xml');
                frames = tex;
                animation.addByPrefix('idle', 'BF idle dance', 24, true);
                
                addOffset('idle', -5);
                
                playAnim('idle');
                
                flipX = true;

                isLikeBF = true;
            case 'Radical Babby':
                var tex = FlxAtlasFrames.fromSparrow(Character.charPath + 'babRad.png', Character.charPath + 'babRad.xml');
                frames = tex;
                animation.addByPrefix('idle', 'idle', 24, true);
                
                addOffset('idle', -5);
                
                playAnim('idle');
                
                flipX = true;

                isLikeBF = true;
            case 'Sussy Radical':
                var tex = FlxAtlasFrames.fromSparrow(Character.charPath + 'SUSSY_RACIAL.png', Character.charPath + 'SUSSY_RACIAL.xml');
                frames = tex;
                animation.addByPrefix('idle', 'SUSSY RACIAL0', 24, true);
                
                addOffset('idle', 0, -50);
                
                playAnim('idle');
                
                flipX = true;

                isLikeBF = true;
            case 'Chaotic Radical':
                var tex = FlxAtlasFrames.fromSparrow(Character.charPath + 'Chaotic_Radical.png', Character.charPath + 'Chaotic_Radical.xml');
                frames = tex;
                animation.addByPrefix('idle', 'Idle', 24, true);
                
                addOffset('idle', -85, -65);
                
                playAnim('idle');
                
                flipX = true;
            case 'RedBall':
                var tex = FlxAtlasFrames.fromSparrow(Character.charPath + 'radicalball.png', Character.charPath + 'radicalball.xml');
                frames = tex;
                animation.addByPrefix('idle', 'Dad idle dance', 24, true);
                
                addOffset('idle', 215 - 144, -57 + 28);
                
                playAnim('idle');
            case 'Radical':
                frames = FlxAtlasFrames.fromSparrow(Character.charPath + 'racial.png', Character.charPath + 'racial.xml');
                animation.addByPrefix('idle', 'Racial Spiteful Jig', 24);
                
                addOffset('idle', 0, 0);
                
                playAnim('idle');
                
                flipX = true;
            case 'Gaming Radical':
                frames = FlxAtlasFrames.fromSparrow(Character.charPath + 'gaming_racial.png', Character.charPath + 'gaming_racial.xml');
                animation.addByPrefix('idle', 'Racial Spiteful Jig', 24);
                
                addOffset('idle', -65, -45);
                
                playAnim('idle');
                
                flipX = true;
            case 'Namebe Radical':
                frames = FlxAtlasFrames.fromSparrow(Character.charPath + 'Radical_Namebe.png', Character.charPath + 'Radical_Namebe.xml');
                animation.addByPrefix('idle', 'Racial Spiteful Jig', 24);
                
                addOffset('idle', -65, -45);
                
                playAnim('idle');
                
                flipX = true;
            case 'Racial Pride':
                frames = FlxAtlasFrames.fromSparrow(Character.charPath + 'racial.png', Character.charPath + 'racial.xml');
                animation.addByPrefix('idle', 'Pride Racial Spiteful Jig', 24);
                
                addOffset('idle', 0, 0);
                
                playAnim('idle');
                
                flipX = true;
            case 'RadiFAIL': 
                frames = FlxAtlasFrames.fromSparrow(Character.charPath + 'racial.png', Character.charPath + 'racial.xml');
                animation.addByPrefix('idle', 'Racial Spiteful Jig', 24);

                addOffset('idle', 0, 0);

                playAnim('idle');
                
                flipX = true;
            case 'Business Radical':
                frames = FlxAtlasFrames.fromSparrow(Character.charPath + 'racial-buisiness.png', Character.charPath + 'racial-buisiness.xml');
                animation.addByPrefix('idle', 'Racial Spiteful Jig', 24);
                playAnim('idle');
                flipX = true;
        }

        flipX = !flipX;
    }

    public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
        animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(animation.curAnim.name);
		if (animOffsets.exists(animation.curAnim.name))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);
	}

    public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}