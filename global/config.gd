extends Node

const BallRadius := 0.3

const BounceArchRadius := 9.0
const WorldSize := Vector3(20,1,20)

const BottomSize := Vector2(WorldSize.x, WorldSize.z)
const BottomCenter := Vector3(WorldSize.x/2, 0, WorldSize.z/2)
const TopCenter := Vector3(WorldSize.x/2, WorldSize.y, WorldSize.z/2)

const WestSize := Vector2(WorldSize.y, WorldSize.z)	
const WestCenter := Vector3(0, WorldSize.y/2, WorldSize.z/2)
const EastCenter := Vector3(WorldSize.x, WorldSize.y/2, WorldSize.z/2)

const NorthSize := Vector2(WorldSize.x, WorldSize.y)
const NorthCenter := Vector3(WorldSize.x/2, WorldSize.y/2, 0)
const SouthCenter := Vector3(WorldSize.x/2, WorldSize.y/2, WorldSize.z)


var tex_array = [
	preload("res://BallTexture/ball1.tres"),	
	preload("res://BallTexture/ball2.tres"),	
	preload("res://BallTexture/ball3.tres"),	
	preload("res://BallTexture/ball4.tres"),	
	preload("res://BallTexture/ball5.tres"),	
	preload("res://BallTexture/ball6.tres"),	
	preload("res://BallTexture/ball7.tres"),	
	preload("res://BallTexture/ball8.tres"),	
	preload("res://BallTexture/ball9.tres"),	
	preload("res://BallTexture/ball10.tres"),	
	preload("res://BallTexture/ball11.tres"),	
	preload("res://BallTexture/ball12.tres"),	
	preload("res://BallTexture/ball13.tres"),	
	preload("res://BallTexture/ball14.tres"),	
	preload("res://BallTexture/ball15.tres"),	
]
