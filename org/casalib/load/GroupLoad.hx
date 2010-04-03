﻿/*
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import org.casalib.core.UInt;
	import org.casalib.errors.ArguementTypeError;
	import org.casalib.util.StringUtil;
	/*[Event(name="ioError", type="flash.events.IOErrorEvent")]*/
					import flash.events.IOErrorEvent;
							this._groupLoad.addEventListener(IOErrorEvent.IO_ERROR, this._onError);
						
						protected function _onError(e:IOErrorEvent):void {
							trace("There was an error");
							this._groupLoad.removeLoad(this._groupLoad.erroredLoads[0]);
						}
		private static var _instanceMap:Hash<GroupLoad>;
		public var id(getId, null): String;
		public var erroredLoads(getErroredLoads, null) : Array<LoadItem>;
		public var loadingAndCompletedLoads(getLoadingAndCompletedLoads, null) : Array<LoadItem>;
		public var errored(getErrored, null):Bool;
		public var bytesLoaded(getBytesLoaded, null):Float;
		public var bytesTotal(getBytesTotal, null):Float;
		var _id:String;
		
		/**
			Returns an instance of GroupLoad.
			
			@param id: The unique identifier for the GroupLoad instance.
			@return A previously created instance of GroupLoad or <code>null</code> if no instance with that identifier exists.
		*/
		public static function getGroupLoadById(id:String):GroupLoad {
			if (GroupLoad._instanceMap == null)
				return null;
			
			return GroupLoad._instanceMap.get(id);
		}
		
		/**
			Returns the instance of GroupLoad which contains a specific file.
			
			@param request: A <code>String</code> or an <code>URLRequest</code> reference to the file.
			@return The instance of GroupLoad which contains a specific file.
			@throws ArguementTypeError if you pass a type other than a <code>String</code> or an <code>URLRequest</code> to parameter <code>request</code>.
		*/
		public static function getGroupLoadByAsset(request:Dynamic):GroupLoad {
			if (GroupLoad._instanceMap != null)
				for (group in GroupLoad._instanceMap)
					if (group.hasAsset(request, false))
						return group;
			
			return null;
		}
			
			@param id: The optional unique identifier for the instance of GroupLoad.
			@throws Error if the identifier provided is not unique or <code>null</code>.
			if (id != null && GroupLoad.getGroupLoadById(id) != null)
				throw 'The identifier provided is not unique.';
				
			if (id==null) {
				do {
					this._id = StringUtil.uuid();
				} while (GroupLoad.getGroupLoadById(_id) != null);
			} else {
				this._id = id;
			}
			
			if (GroupLoad._instanceMap == null) GroupLoad._instanceMap = new Hash<GroupLoad>();
			GroupLoad._instanceMap.set(_id, this);
			
			@param load: Load to be added to the group. Can be any class that extends from {@link LoadItem} or another <code>GroupLoad</code> instance.
			@param percentOfGroup: Defines the percentage of the total group the size of the load item represents; defaults to equal increments.
			@throws ArguementTypeError if you pass a type other than a <code>LoadItem</code> or a <code>GroupLoad</code> to parameter <code>load</code>.
			@throws Error if you try to add the same <code>GroupLoad</code> to itself.
			if (!Std.is(load, LoadItem) && !Std.is(load, GroupLoad))
				throw new ArguementTypeError('load');
			
			if (load == this)
				throw 'You cannot add the same GroupLoad to itself.';
		
			@throws ArguementTypeError if you pass a type other than a <code>LoadItem</code> or a <code>GroupLoad</code> to parameter <code>load</code>.
			if (!Std.is(load, LoadItem) && !Std.is(load, GroupLoad))
				throw new ArguementTypeError('load');
			
			
			if (this.running)
				this._checkTotalPercentValidity();
			
			@param load: The load item to search for. Can be any class that extends from {@link LoadItem} or another <code>GroupLoad</code> instance.
			@param recursive: If any child of this GroupLoad is also a GroupLoad search its children <code>true</code>, or only search this GroupLoad's children <code>false</code>.
			@return Returns <code>true</code> if the GroupLoad contains the load item; otherwise <code>false</code>.
			@throws ArguementTypeError if you pass a type other than a <code>LoadItem</code> or a <code>GroupLoad</code> to parameter <code>load</code>.
			if (!Std.is(load, LoadItem) && !Std.is(load, GroupLoad))
				throw new ArguementTypeError('load');
			
			return this.hasProcess(load, recursive);
		}
		
		/**
			Gets a load item from this GroupLoad, or a child GroupLoad, by its request.
			
			@param request: A <code>String</code> or an <code>URLRequest</code> reference to the file.
			@return The requested LoadItem instance.
			@throws ArguementTypeError if you pass a type other than a <code>String</code> or an <code>URLRequest</code> to parameter <code>request</code>.
		*/
		public function getLoad(request:Dynamic):LoadItem {
			var url:String = this._getFileUrl(request);
			var items = this.loads;
			var l = items.length;
			var i;
			
			while (l-- > 0) {
				i = items[l];
				
				if (Std.is(i,GroupLoad)) {
					i = cast(i,GroupLoad).getLoad(request);
					
					if (i != null)
						return i;
				} else
					if (i.url == url)
						return i;
			}
			
			return null;
		}
		
		/**
			Determines if this instance of GroupLoad contains a specific file.
			
			@param request: A <code>String</code> or an <code>URLRequest</code> reference to the file.
			@param recursive: If any child of this GroupLoad is also a GroupLoad search its children <code>true</code>, or only search this GroupLoad's children <code>false</code>.
			@return Returns <code>true</code> if this instance contains the file; otherwise <code>false</code>.
			@throws ArguementTypeError if you pass a type other than a <code>String</code> or an <code>URLRequest</code> to parameter <code>request</code>.
		*/
		public function hasAsset(request:Dynamic, recursive:Bool = true):Bool {
			var url:String = this._getFileUrl(request);
			
			if (!recursive)
				return ArrayUtil.getItemByKey(this.loads, 'url', url) != null;
			
			var items = this.loads;
			var l = items.length;
			var i;
			
			while (l-- > 0) {
				i = cast items[l];
				
				if (Std.is(i,GroupLoad)) {
					if (cast(i,GroupLoad).hasAsset(request, true))
						return true;
				} else {
					if (i.url == url)
						return true;
				}
			}
			
			return false;
		}
		
		/**
			The identifier name for this instance of GroupLoad, if specified.
		*/
		private function getId():String {
			return this._id;
		}
		
		/**
			The loads that could not complete because of an error.
		*/
		private function getErroredLoads():Array<LoadItem> {
			return cast ArrayUtil.getItemsByKey(this.processes, 'errored', true);
		}
		
		/**
			The loads that are either currently loading or that have completed.
		*/
		private function getLoadingAndCompletedLoads():Array<LoadItem> {
			return this.loadingLoads.concat(this.completedLoads);
		}
		
		/**
			Determines if the GroupLoad could not complete because of an error <code>true</code>, or hasn't encountered an error <code>false</code>.
		*/
		public function getErrored():Bool {
			return this.erroredLoads.length > 0;
		}
		
		/**	
			The number of bytes loaded.
		*/
		public function getBytesLoaded():Float {
			return ArrayUtil.sum(ArrayUtil.getValuesByKey(this.loadingAndCompletedLoads, 'bytesLoaded'));
		}
		
		/**
			The total number of bytes that will be loaded if the loading process succeeds.
			
			@usageNote Will return <code>Infinity</code> until all loads in group have started loading.
		*/
		public function getBytesTotal():Float {
			var total = this.loads.length;
			var l = this.loadingAndCompletedLoads;
			
			if (total == l.length && total != 0)
				return ArrayUtil.sum(ArrayUtil.getValuesByKey(l, 'bytesTotal'));
			
			return Math.POSITIVE_INFINITY;
		}
			this._percentMap = new IntHash<Percent>();
			
			super.destroyProcesses(recursive);
		}
			Calls <code>destroy</code> on all loads in the group and removes them from the GroupLoad.
			
			@param recursive: If any child of this GroupLoad is also a GroupLoad destroy its children <code>true</code>, or only destroy this GroupLoad's children <code>false</code>.
		*/
		public function destroyLoads(recursive:Bool = true):Void {
			this.destroyProcesses(recursive);
		}
			
			GroupLoad._instanceMap.remove(id);
				for (i in this._percentMap.keys()){
					this._percentMap.get(i).decimalPercentage = this._percentMap.get(i).decimalPercentage / perTotal;
				}
			}
			process.addEventListener(IOErrorEvent.IO_ERROR, this._onLoadError, false, 0, true);
			process.removeEventListener(IOErrorEvent.IO_ERROR, this._onLoadError);
			if (this._Bps != Bps || this._progress.decimalPercentage != perTotal) {
				this._Bps                        = Bps;
				this._progress.decimalPercentage = perTotal;
			}
		
		/**
			@sends IOErrorEvent#IO_ERROR - Dispatched if a requested load cannot be loaded and the download terminates.
		*/
		private function _onLoadError(e:IOErrorEvent):Void {
			this.dispatchEvent(e);
			
			this._checkThreads();
		}
			if (this.erroredLoads.length > 0)
				return;
		
				this._progress.decimalPercentage = 1;
				this.dispatchEvent(this._createDefinedLoadEvent(LoadEvent.PROGRESS));
			}
		
		private function _getFileUrl(request:Dynamic):String {
			var url:String;
			
			if (Std.is(request, String))
				url = request;
			else if (Std.is(request, URLRequest))
				url = request.url;
			else
				throw new ArguementTypeError('request');
			
			return url;
		}