/*
	import org.casalib.core.UInt;
	
		/**
			Searches for an item in an array and returns the index position of the item.
		*/
		public static function indexOf(inArray:Array<Dynamic>, match:Dynamic, ?fromIndex:Int = 0):Int {
			var i = fromIndex-1;
			while (++i < inArray.length) {
				if (inArray[i] == match) return i;
			}
			return -1;
		}
		
		/**
			Searches for an item in an array, working backward from the last item, and returns the index position of the matching item.
		*/
		public static function lastIndexOf(inArray:Array<Dynamic>, match:Dynamic, ?fromIndex:UInt):Int {
			var i:UInt;
			if (fromIndex == null) {
				i = inArray.length;
			} else {
				i = Math.round(Math.min(inArray.length,fromIndex+1));
			}
			
			while (--i >= 0) {
				if (inArray[i] == match) return i;
			}
			return -1;
		}
		
		/**
			Executes a test function on each item in the array and constructs a new array for all items that return true for the specified function. If an item returns false, it is not included in the new array.
			
		*/
		public static function filter(inArray:Array<Dynamic>, callBack:Dynamic):Array<Dynamic> {
			var newArray = [];
			var i = 0;
			while (i++ < inArray.length) {
				if (callBack(inArray[i],i,inArray)) {
					newArray.push(inArray[i]);
				}
			}
			return newArray;
		}
		
			for (i in items){
				tarArray.insert(index++,i);
			}
			var c = inArray.copy();
			var lowest = inArray[0];
			for (i in inArray) {
				lowest = NumberUtil.min(i,lowest);
			}
			for (i in inArray) {
				lowest = NumberUtil.max(i,lowest);
			}