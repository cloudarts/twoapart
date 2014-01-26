package  {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.textures.RenderTexture;
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Level {
		private var emotionManager:EmotionManager;
		
		public const TILE_STATIC_FLOOR_STRING:String = "-";
		public const TILE_STATIC_WALL_STRING:String = "#";
		public const TILE_STATIC_HOLE_STRING:String = "_";
		public const TILE_STATIC_CRUMBLE_STRING:String = "C";
		public const TILE_STATIC_NARROW_VERTICAL_STRING:String = "N";
		public const TILE_STATIC_NARROW_HORIZONTAL_STRING:String = "Z";
		
		public const ENTITY_P1:String = "p1";
		public const ENTITY_P2:String = "p2";
		
		public const ENTITY_JITTERY:String = "jittery";
		public const ENTITY_SELF_CONFIDENT:String = "self-confident";
		public const ENTITY_ANGRY:String = "angry";
		public const ENTITY_HAPPY:String = "happy";
		public const ENTITY_CALM:String = "calm";
		public const ENTITY_SAD:String = "sad";
		public const ENTITY_STONE:String = "stone";
		public const ENTITY_MINE:String = "mine";
		
		public const LINE_SEPARATOR:String = "\r\n";
		public const TOKEN_SEPARATOR:String = ",";
		
		public const ERROR_MSG_WRONG_COUNT:String = "ERROR: Wrong count of tokens";
		
		public var width:int 	= -1;
		public var height:int 	= -1;
		
		private var game : Game;
		
		/**
		 * one-dimensional tile array
		 */ 
		public var tiles:Vector.<Entity> = null;
		
		/**
		 * one-dimensional entities array
		 */ 
		public var entities:Vector.<Entity> = null;
		
		
		public function Level(game : Game) {
			this.game = game;
		}
		
		public function draw(renderTexture : RenderTexture) : void {

			entities = entities.sort(Entity.compareValues);
			
			//Draw our level :)
			for (var i:int = 0; i < tiles.length; i++) {
				tiles[i].draw(renderTexture);
			}
			
			for (var j:int = 0; j < entities.length; j++) 
			{
				entities[j].draw(renderTexture);
			}
			for (var i:int = 0; i < entities.length; i++)
			{
				if (entities[i] instanceof TileWall)
					entities[i].drawDebug(renderTexture);
			}
			emotionManager.draw(renderTexture);
		}
		
		public function update( delta : Number) : void {
			//Update tiles
			for (var i:int = 0; i < tiles.length; i++) {
				tiles[i].update(delta);
			}
			//Update entities
			for (var i:int = 0; i < entities.length; i++) {
				entities[i].update(delta);
			}
			
			emotionManager.update( delta );
		}
		
		/**
		 * parse level definition file into tile array and script variables
		 */
		public function initialize(levelStr:String) : void {
			tiles = new Vector.<Entity>();
			entities = new Vector.<Entity>();
			var lines:Array = levelStr.split(this.LINE_SEPARATOR);
			emotionManager = new EmotionManager(); 
			parse(lines);
			
			var a:int = 0;

		}
		
		public function changeGrumbleToHole( tile:Point):void {
			var hole :TileHole = new TileHole();
			hole.setLevel(this);
			hole.setTile(tile.x, tile.y );
			tiles[tile.x + tile.y * width] = hole;
		}
		
		public function changeHoleToFloor(tile:Point ):void {
			var floor : TileFloor = new TileFloor();
			floor.setLevel(this);
			floor.setTile(tile.x, tile.y );
			var ind : int = (tile.y * width)
			ind += tile.x;
			tiles[ind] = floor;			
		}
		
		public function handleCollisions(player : EntityPlayer , moveVec : Point) : Point {
			var tempP : Point = new Point(0,0);
			tempP.x = player.getOwnBoundingBox().x + moveVec.x;			
			tempP.y = player.getOwnBoundingBox().y;			
			var bbPx : Rectangle = player.getBoundingBox(tempP);
			
			tempP.x = player.getOwnBoundingBox().x;			
			tempP.y = player.getOwnBoundingBox().y + moveVec.y;			
			var bbPy : Rectangle = player.getBoundingBox(tempP);
			
			//Get all tiles and entities
			
			for (var i:int = 0; i < tiles.length; i++) {
				if (tiles[i] instanceof TileCrumble || tiles[i] instanceof TileHole ||
					tiles[i] instanceof TileNarrowHorizontal || tiles[i] instanceof TileNarrowVertical) {
						
					var r : Rectangle = tiles[i].getOwnBoundingBox();
					var hitX : Boolean = checkForCollision(bbPx, r);
					var hitY : Boolean = checkForCollision(bbPy, r);
					
					//Check if we collided sth meaningful
					if (hitX || hitY) {
						if (tiles[i] instanceof TileCrumble) {
							var tile : TileCrumble = tiles[i] as TileCrumble;
							tile.startCrumble();
						} else if (tiles[i] instanceof TileHole) {
							//Handle Player death
							
						} 
					}
				}
			}
			for (var i : int = 0; i < entities.length; i++) {
				var r : Rectangle = entities[i].getOwnBoundingBox();
					var hitX : Boolean = checkForCollision(bbPx, r);
					var hitY : Boolean = checkForCollision(bbPy, r);
					
					//Check if we collided sth meaningful
					if (hitX || hitY) {
						if (entities[i] instanceof TileWall) {
							if (hitX) {
								moveVec.x = 0;
							}
							if (hitY) {
								moveVec.y = 0;
							}
						} else if(entities[i] instanceof EntityPlayer){
								
								if (entities[i] != player) {
									//Finish Level
								}
						} else if (entities[i] instanceof EntityStone) {
							if (player.getEmotion() != Constants.EMOTION_ANGRY && player.getEmotion() != Constants.EMOTION_SELFCONFIDENT) {
								if (hitX) moveVec.x = 0;
								if (hitY) moveVec.y = 0;
							} else if (player.getEmotion() == Constants.EMOTION_ANGRY) {
								entities.splice(i, 1);
							} else if (player.getEmotion() == Constants.EMOTION_SELFCONFIDENT) {
								 moveVec = checkBlockCollisions(entities[i].getOwnBoundingBox(), moveVec);
								 
								 if (moveVec.length > 0) {
									var x:Number;
									var y:Number;
									x = entities[i].getPixelPos().x + moveVec.x;
									y = entities[i].getPixelPos().y + moveVec.y;
									entities[i].setPixelPos(x, y);
									
									var tilePt : Point = entities[i].getTile();
									var tileId : int = tilePt.y * this.width + tilePt.x;
									if (tiles[tileId] instanceof TileHole) {
										changeHoleToFloor(tiles[tileId].getTile());
										entities.splice(i, 1);
									}
								 }
								//move block
							}
						} else if (entities[i] instanceof EntityMine) {
							//Restart Level
						} else if (entities[i] instanceof EntityAngry) {
							emotionManager.push(Constants.EMOTION_ANGRY);
							entities.splice(i, 1);
						}else if (entities[i] instanceof EntityCalm) {
							emotionManager.push(Constants.EMOTION_CALM);
							entities.splice(i, 1);
							
						}else if (entities[i] instanceof EntitySelfConfident) {
							emotionManager.push(Constants.EMOTION_SELFCONFIDENT);
							entities.splice(i, 1);
						}else if (entities[i] instanceof EntityHappy) {
							emotionManager.push(Constants.EMOTION_HAPPY);
							entities.splice(i, 1);
						}else if (entities[i] instanceof EntityJittery) {
							emotionManager.push(Constants.EMOTION_JITTERY);
							entities.splice(i, 1);
						}else if (entities[i] instanceof EntitySad) {
							emotionManager.push(Constants.EMOTION_SAD);
							entities.splice(i, 1);
						}else if (entities[i] instanceof TileNarrowHorizontal) {
							//handle different activities
							if ((player as EntityPlayer).getEmotion() == Constants.EMOTION_SAD) {
								var bbSm:Rectangle = (entities[i] as TileNarrowHorizontal).getSmallBB();
								hitX = checkForCollision(bbSm, bbPx);
								hitY = checkForCollision(bbSm, bbPy);
								if (hitX) {
									moveVec.x = 0;
								}
								if (hitY) {
									moveVec.y = 0;
								}
							} else {
								if (hitX) {
									moveVec.x = 0;
								}
								if (hitY) {
									moveVec.y = 0;
								}
							}
							
							
						} else if (entities[i] instanceof TileNarrowVertical) {
							//Handle Player death
							if ((player as EntityPlayer).getEmotion() == Constants.EMOTION_SAD) {
								var bbSm:Rectangle = (entities[i] as TileNarrowVertical).getSmallBB();
								hitX = checkForCollision(bbSm, bbPx);
								hitY = checkForCollision(bbSm, bbPy);
								if (hitX) {
									moveVec.x = 0;
								}
								if (hitY) {
									moveVec.y = 0;
								}
							}else {
								if (hitX) {
									moveVec.x = 0;
								}
								if (hitY) {
									moveVec.y = 0;
								}
							}
							
						} else if (entities[i] instanceof EntityMine){
							// Push to stack and delete Object
							//stack.push(entities[i].getEmotion());
							//entities.splice(i, 1);
						}
						
					}
			}
			
			
			return new Point( player.getPixelPos().x + moveVec.x, player.getPixelPos().y + moveVec.y);
		}
		
		private function checkBlockCollisions(bb:Rectangle, moveVec:Point):Point {
			var rectToTestDx:Rectangle = bb.clone();
			rectToTestDx.x += moveVec.x;
			var rectToTestDy:Rectangle = bb.clone();
			rectToTestDy.y += moveVec.y;
			for (var i: int = 0; i < tiles.length; i++)
			{
				if (!(tiles[i] instanceof TileHole ) && !(tiles[i] instanceof TileFloor ) && !(tiles[i] instanceof TileCrumble) ){
					var r: Rectangle = tiles[i].getOwnBoundingBox();
					var hitX : Boolean = checkForCollision(rectToTestDx, r);
					var hitY : Boolean = checkForCollision(rectToTestDy, r);
					
					if (hitX) {
						moveVec.x = 0;
					}
					if (hitY) {
						moveVec.y = 0;
					}
				}
			}
			//Check the entities
			for (var i: int = 0; i < entities.length; i++) {
				if (/*(entities[i] instanceof EntityPlayer) ||*/ /*(entities[i] instanceof EntityStone) ||*/
				(entities[i] instanceof TileWall) || (entities[i] instanceof TileNarrowHorizontal) || (entities[i] instanceof TileNarrowVertical)) {
					
					var r: Rectangle = entities[i].getOwnBoundingBox();
					var hitX : Boolean = checkForCollision(rectToTestDx, r);
					var hitY : Boolean = checkForCollision(rectToTestDy, r);
					
					if (hitX) {
						moveVec.x = 0;
					}
					if (hitY) {
						moveVec.y = 0;
					}
				}
			}
			return moveVec;		
		}
		
		//Parse the lines of textfile
		private function parse(lines:Array) : void {
			this.width = Number(lines[0]);
			this.height = Number(lines[1]);
			
			for (var i:int = 3; i < height + 3; i++ ) {
				var line:String = lines[i];
				for (var j:int = 0; j < line.length; j++ ) {
					var entity:Entity = null; 
					switch(line.charAt(j)) {
						case TILE_STATIC_FLOOR_STRING:
							entity = new TileFloor();
							break;
						
						case TILE_STATIC_CRUMBLE_STRING:
							entity = new TileCrumble();
							break;
						
						case TILE_STATIC_WALL_STRING:
							entity = new TileWall();
							break;
						
						case TILE_STATIC_HOLE_STRING:
							entity = new TileHole();
							break;
						
						case TILE_STATIC_NARROW_VERTICAL_STRING:
							entity = new TileNarrowVertical();
							break;
							
						case TILE_STATIC_NARROW_HORIZONTAL_STRING:
							entity = new TileNarrowHorizontal();
							break;
							
						default:
							trace("Token unrecognized");
							break;
					}
					if (entity != null) {
						entity.setLevel(this);
						entity.setTile(j, i - 3);
						if (entity instanceof TileWall || entity instanceof TileNarrowHorizontal || entity instanceof TileNarrowVertical) {
							entities.push(entity);
							var wall : Entity = new TileFloor();
							wall.setTile(j, i - 3);
							tiles.push(wall);
						} else {
							tiles.push(entity);
						}
					}
				}
			}
			for (var i:int = height + 4; i < lines.length; i++ ) {
				var line:String = lines[i];
				var tokens:Array = line.split(this.TOKEN_SEPARATOR);
				var entity:Entity = null; 
				
				switch(tokens[0]) {
					case ENTITY_P1:
						if(tokens.length == 3){
							entity = new EntityPlayer( 0 );
							(entity as EntityPlayer).setLevel(this);
							emotionManager.setPlayer((entity as EntityPlayer), 0);
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}
						break;						
					case ENTITY_P2:
						if(tokens.length == 3){
							entity = new EntityPlayer( 1 );
							(entity as EntityPlayer).setLevel(this);
							emotionManager.setPlayer((entity as EntityPlayer), 1);
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}
						break;
					case ENTITY_JITTERY:
						if (tokens.length == 3) {
							entity = new EntityJittery();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}
						break;
					case ENTITY_SELF_CONFIDENT:
						if (tokens.length == 3) {
							entity = new EntitySelfConfident();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_ANGRY:
						if (tokens.length == 3) {
							entity = new EntityAngry();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_HAPPY:
						if (tokens.length == 3) {
							entity = new EntityHappy();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_CALM:
						if (tokens.length == 3) {
							entity = new EntityCalm();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_STONE:
						if (tokens.length == 3) {
							entity = new EntityStone();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_SAD:
						if (tokens.length == 3) {
							entity = new EntitySad();
						} else trace(ERROR_MSG_WRONG_COUNT);
						break;
					case ENTITY_MINE:
						if (tokens.length > 4 && (tokens.length % 2 == 1)) {
							var waypoints:Array = new Array();
							
							for ( var coord:int = 1; coord < tokens.length; coord += 2 ) {
								var waypoint:Point = new Point(Number(tokens[coord]), Number(tokens[coord + 1]));
								waypoints.push(waypoint);
							}
							
							entity = new EntityMine(waypoints);
														
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					default:
						trace("Token unrecognized");
						break;
				}
					
				if (entity != null) {
					entity.setLevel(this);
					entity.setTile(tokens[1], tokens[2]);
					entities.push(entity);
				}
			}
		}

		public static function checkForCollision(e1 : Rectangle,  e2 : Rectangle) : Boolean{	
			return e1.intersects(e2);
			
		}
		
		public function getNextStackElement() : int{
			return 0;
		}
		
		
	}
}

