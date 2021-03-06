package ru.inspirit.surf 
{

	/**
	 * SURF Options
	 * 
	 * @author Eugene Zatepyakin
	 */
	public final class SURFOptions 
	{
		public static const OCTAVES_DEFAULT:uint = 3;
		public static const INTERVALS_DEFAULT:uint = 4;
		public static const SAMPLE_STEP_DEFAULT:uint = 2;
		public static const MAX_POINTS_DEFAULT:uint = 200;
		public static const THRESHOLD_DEFAULT:Number = 0.004;
		
		public var octaves:uint;
		public var intervals:uint;
		public var sampleStep:uint;
		public var maxPoints:uint;
		public var threshold:Number;
		public var width:uint;
		public var height:uint;
		public var useOrientation:uint;
		
		public var imageProcessor:ImageProcessor;
		public var imageROI:RegionOfInterest;
		
		/**
		 * @param width					width of the provided image source
		 * @param height				height of the provided image source
		 * @param maxPoints				max points allowed to be detected (this number is limited to 35000 inside C lib)
		 * @param threshold				blob strength threshold
		 * @param useOrientation		specify if you need orientation based descriptors (needed for different sources matching)
		 * @param octaves				number of octaves to calculate
		 * @param intervals				number of intervals per octave
		 * @param sampleStep			initial sampling step
		 */
		
		public function SURFOptions(width:uint, height:uint, maxPoints:uint = MAX_POINTS_DEFAULT, threshold:Number = THRESHOLD_DEFAULT, useOrientation:Boolean = true, octaves:uint = OCTAVES_DEFAULT, intervals:uint = INTERVALS_DEFAULT, sampleStep:uint = SAMPLE_STEP_DEFAULT)
		{
			this.width = width;
			this.height = height;
			this.maxPoints = maxPoints;
			this.threshold = Math.max(threshold, 0);
			this.useOrientation = useOrientation ? 1 : 0;
			this.octaves = Math.min(octaves, 5);
			this.intervals = intervals;
			this.sampleStep = Math.max(1, Math.min(sampleStep, 6));
			
			this.imageROI = new RegionOfInterest(0, 0, width, height);
		}

		public function compare(options:SURFOptions):Boolean
		{
			if(width != options.width) return false;
			if(height != options.height) return false;
			if(maxPoints != options.maxPoints) return false;
			if(threshold != options.threshold) return false;
			if(useOrientation != options.useOrientation) return false;
			if(octaves != options.octaves) return false;
			if(intervals != options.intervals) return false;
			if(sampleStep != options.sampleStep) return false;
			if(!imageROI.equals(options.imageROI)) return false;
			
			return true;
		}
		
		public function clone():SURFOptions
		{
			var opt:SURFOptions = new SURFOptions(width, height, maxPoints, threshold, useOrientation ? true : false, octaves, intervals, sampleStep);
			opt.imageROI = RegionOfInterest.fromRectangle(imageROI);
			opt.imageProcessor = imageProcessor;
			
			return opt;
		}

		public function toString():String 
		{
			return "SURFOptions{width:" + width + ', height:' + height + ', maxPoints:' + maxPoints + ', threshold:' + threshold + ', useOrientation:' + useOrientation + ', octaves:' + octaves + ', intervals:' + intervals + ', sampleStep:' + sampleStep + '}';
		}
	}
}
