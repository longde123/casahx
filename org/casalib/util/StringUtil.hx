﻿/*
	import org.casalib.core.UInt;
	
	
		
		inline public static function getWHITESPACE():String {
			return " \n\t\r";
		}
		
		inline public static function getSMALL_WORDS():Array<String> {
			return ['a', 'an', 'and', 'as', 'at', 'but', 'by', 'en', 'for', 'if', 'is', 'in', 'of', 'on', 'or', 'the', 'to', 'v', 'via', 'vs'];
		}
			var pAry:Array<String> = ("[-!\"#$%&'()*+,./:;<=>?@[\\]^_`{|}~]").split("");
			if (allowSpaces) pAry.push(" ");
			return !ArrayUtil.retainItems(source.split(""),pAry);
				return false;
			} else {
				var num = Std.parseFloat(source);
				
				if (Math.isNaN(num)) return false;
				
				if (num != 0) return true;
				
				source = source.toLowerCase();
				
				if (ArrayUtil.retainItems(source.split(""),["0",".","-","x","f"])) return false;
				
				if (!(ArrayUtil.retainItems(source.split(""),["0"])) ) return true;
				
				if (source.length == 1 && source != "0") return false;
				
				if (source.indexOf("0") == -1) return false;
				
				//for -0, -0000...
				if (source.lastIndexOf('-') > 0) return false;
				
				//for 0x0, 0x0000
				var oxo = source.indexOf("0x0");
				if (oxo != -1){
					var noOxO = (source.substr(0,oxo)+source.substr(oxo+3)).split("");
					if (ArrayUtil.retainItems(noOxO,["0",".","-"])) return false;
				}
				
				//for 0.00
				if (StringUtil.contains(source,'.') > 1) return false;
				
				//for 0f, 0.0f...
				var indF = source.indexOf('f');
				if (indF != -1 && indF < source.length-1) return false;
				
				return true;
			}
			var pattern:EReg = new EReg('^[' + removeChars + ']+', '');
			if (removeChars == null) removeChars = StringUtil.WHITESPACE;
			if (removeChars == null) removeChars = StringUtil.WHITESPACE;
			return StringUtil.replace(source, remove, '');