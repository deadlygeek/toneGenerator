package {
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	
	public class ToneGenerator {
		
		[Bindable]
		public var amp_multiplier_right:Number = 0.15;
		[Bindable]
		public var amp_multiplier_left:Number = 0.15;
		[Bindable]
		public var freq_right:Number = 350;
		[Bindable]
		public var freq_left:Number = 350;
		
		public static const SAMPLING_RATE:int = 44100;
		public static const TWO_PI:Number = 2*Math.PI;
		public static const TWO_PI_OVER_SR:Number = TWO_PI/SAMPLING_RATE;
		
		public var tone:Sound;
		
		public function ToneGenerator() {
		}
		
		public function stopTone():void {
			
			tone.removeEventListener(SampleDataEvent.SAMPLE_DATA, generateSineTone);

		}
		
		public function startTone():void {
				
			tone = new Sound();
			
			tone.addEventListener(SampleDataEvent.SAMPLE_DATA, generateSineTone);
			
			tone.play();
			
		}
		
		public function generateSineTone(e:SampleDataEvent):void {
			
			var sample:Number;
			
			for(var i:int=0;i<8192;i++) {
				sample = Math.sin((i+e.position) * TWO_PI_OVER_SR * freq_left);
				e.data.writeFloat(sample * amp_multiplier_left);
				sample = Math.sin((i+e.position) * TWO_PI_OVER_SR * freq_right);
				e.data.writeFloat(sample * amp_multiplier_right);
			}  
			
		}
		

	}
}