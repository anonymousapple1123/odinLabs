package main
import rl "vendor:raylib"
import "core:fmt"

gui_1::proc(){
	rl.InitWindow(1280,720, "First Window")
	player_pos := rl.Vector2{640,320}
	player_vel : rl.Vector2
	player_touching_ground : bool
	for !rl.WindowShouldClose(){
		//debug details --
		fmt.print("/n Frame rate : ",rl.GetFrameTime())


		rl.BeginDrawing()
		rl.ClearBackground(rl.BEIGE)
		//key press check

		if rl.IsKeyDown(.LEFT){
			player_vel.x = -400
		}else if rl.IsKeyDown(.RIGHT){
			player_vel.x = 400
		}else {
			player_vel.x = 0
		}
		player_vel.y += 2000 * rl.GetFrameTime()



		if rl.IsKeyPressed(.SPACE) && player_touching_ground{
			player_vel.y = -800
			player_touching_ground = false
		}


		player_pos += player_vel*rl.GetFrameTime()

		//keep the player in the screen space of the window
		//checks if the player is on the ground
		if player_pos.y > f32(rl.GetScreenHeight() - 64){
			player_pos.y = f32(rl.GetScreenHeight() - 64)
			player_touching_ground = true
		}

		rl.DrawRectangleV(player_pos, {64,64}, rl.BLACK)
		rl.EndDrawing()
	}
	rl.CloseWindow()
}
