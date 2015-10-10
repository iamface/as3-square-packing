package classes{
	import flash.display.Sprite;
	
	public class SquarePacking extends Sprite{

		private var _gridHeight:int;
		private var _gridWidth:int;
		private var _squareSizes:Array;
		private var _unitSize:int;
		
		private var gridMatrix_arr:Array;
		
		public function SquarePacking(){
		}
		
		public function fillGrid(gridWidth:int, gridHeight:int, unitSize:int, squareSizes:Array):void{
			this.gridWidth = gridWidth;
			this.gridHeight = gridHeight;
			this.unitSize = unitSize;
			this.squareSizes = squareSizes;
			
			gridMatrix_arr = new Array();
			var x:uint = 0;
			var y:uint = 0;
			
			for(var i:uint = 0; i < gridWidth/unitSize; i++){ // build new row
				var row:Array = new Array();
				x = 0;
				
				for(var j:uint = 0; j < gridHeight/unitSize; j++){ // build new col unit in row
					var rowInfo:Object = new Object();
					rowInfo['occupied'] = false;
					rowInfo['x'] = x;
					rowInfo['y'] = y;
					
					row.push(rowInfo);
					x += unitSize;
				}
				gridMatrix_arr.push(row);
				y += unitSize;
			}
			squareSizes = squareSizes.sort(Array.NUMERIC); // sorts squares smallest to largest, to determine smallest unit
			fitSquare();
		}

		private function fitSquare():void{
			for(var rowNum:uint = 0; rowNum < gridWidth/unitSize; rowNum++){
				for(var colNum:uint = 0; colNum < gridHeight/unitSize; colNum++){
					if(gridMatrix_arr[rowNum][colNum].occupied == false){ // current unit is not occupied
						var validSquare:Boolean = false;
						
						while(!validSquare){
							var square:Sprite = randomSquare(); // select a random size square
							var canBePlaced:Boolean = true; // assume the square is empty
							
							for(var i:uint = rowNum; i < rowNum+square.width/unitSize; i++){ // check if all square units are not occupied
								for(var j:uint = colNum; j < colNum+square.height/unitSize; j++){
									if((gridMatrix_arr[i] != undefined) && (gridMatrix_arr[i][j] != undefined)){ // unit exists in grid matrix
										if(gridMatrix_arr[i][j].occupied == true){
											canBePlaced = false; // square cannot be placed without overlap
										}
									}
								}
							}
							
							if(canBePlaced){ // square can be placed without overlapping other units
								if(((gridWidth/unitSize - rowNum) >= square.width/unitSize) && ((gridHeight/unitSize - colNum) >= square.height/unitSize)){ // square fits without 'falling off' any edge
									this.addChild(square); // add square
									square.x = gridMatrix_arr[rowNum][colNum].x;
									square.y = gridMatrix_arr[rowNum][colNum].y;
									
									for(var i2:uint = rowNum; i2 < rowNum+square.width/unitSize; i2++){ // mark all area units in square as occupied
										for(var j2:uint = colNum; j2 < colNum+square.height/unitSize; j2++){
											gridMatrix_arr[i2][j2].occupied = true;
										}
									}
									validSquare = true; // square was validated to fit and placed, move on
								}
							}
						}
					}
				}
			}
		}
		
		private function randomSquare():Sprite{
			var size:int = Math.random() * squareSizes.length;
			var sq:Sprite = new Sprite();
			sq.graphics.beginFill(Math.random() * 0xFFFFFF);
			sq.graphics.drawRect(0, 0, squareSizes[size], squareSizes[size]);
			return sq;
		}

		public function get gridHeight():int{
			return _gridHeight;
		}
		public function set gridHeight(height:int):void{
			_gridHeight = height;
		}
		
		public function get gridWidth():int{
			return _gridWidth;
		}
		public function set gridWidth(width:int):void{
			_gridWidth = width;
		}
		
		public function get squareSizes():Array{
			return _squareSizes;
		}
		public function set squareSizes(squares:Array):void{
			_squareSizes = squares;
		}
		
		public function get unitSize():int{
			return _unitSize;
		}
		public function set unitSize(size:int):void{
			_unitSize = size;
		}
	}
}