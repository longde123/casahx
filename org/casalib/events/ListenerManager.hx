/*
	import org.casalib.core.UInt;
	import org.casalib.util.ArrayUtil;
						
							return this._listenerManager.getTotalEventListeners(type);
						}
						
		#if flash
		#end
			if (!ListenerManager._proxyMap.exists(dispatcher))
		#end
		#if flash
		#else
		public function addEventListener(type:String, listener:Dynamic->Void, ?useCapture:Bool, ?priority:Int, ?useWeakReference:Bool):Int {
			
			return -1;
		#end
		#if flash
		#else
		public function removeEventListener(type:String, listener:Dynamic->Void, ?useCapture:Bool):Void {
		}
		#end
		
			return (type == null) ? this._events.length : ArrayUtil.getItemsByKey(this._events, 'type', type).length;
		}

			#if flash
			ListenerManager._proxyMap.delete(this._eventDispatcher);
			
		
		#if !flash
		public function RemoveByID(inType:String,inID:Int) : Void {}
		#end

	private class EventInfo {