package main
import rl "vendor:raylib"
import "core:fmt"

gui_1::proc(){

	rl.InitWindow(1280,720, "First Window")
	player_pos := rl.Vector2{640,320}
	player_vel : rl.Vector2
	player_touching_ground : bool
	player_flip : bool
	player_run_texture := rl.LoadTexture("7842665.png")
	player_run_num_frames := 3
	//frame times
	player_run_frame_timer : f32
	player_run_current_frame : int
	player_run_frame_length := f32(0.1)


	for !rl.WindowShouldClose(){
		//debug details --
		fmt.print("/n Frame rate : ",rl.GetFrameTime())


		rl.BeginDrawing()
		rl.ClearBackground(rl.BEIGE)
		//key press check

		if rl.IsKeyDown(.LEFT){
			player_vel.x = -400
			player_flip = true
		}else if rl.IsKeyDown(.RIGHT){
			player_vel.x = 400
			player_flip = false

		}else {
			player_vel.x = 0
		}
		player_vel.y += 2000 * rl.GetFrameTime()



		if (rl.IsKeyPressed(.SPACE) ||rl.IsKeyPressed(.UP)) && player_touching_ground{
			player_vel.y = -800
			player_touching_ground = false
		}


		player_pos += player_vel*rl.GetFrameTime()

		player_run_width := f32(player_run_texture.width)
		player_run_height := f32(player_run_texture.height)

		//keep the player in the screen space of the window
		//checks if the player is on the ground
		if player_pos.y > f32(rl.GetScreenHeight() - 100){
			player_pos.y = f32(rl.GetScreenHeight() - 100)
			player_touching_ground = true
		}

		player_run_frame_timer += rl.GetFrameTime()

		for player_run_frame_timer > player_run_frame_length{
			player_run_current_frame +=1
			player_run_frame_timer-= player_run_frame_length
			if player_run_current_frame == player_run_num_frames{
				player_run_current_frame = 0
			}
		}

		draw_player_source := rl.Rectangle{
			x= f32(player_run_current_frame) * player_run_width/ f32(player_run_num_frames),// shift this position to shift to next frame
			y=0,
			width = player_run_width/ (f32(player_run_num_frames)),
			height = player_run_height/2,
		}

		if player_flip{
			draw_player_source.width = -draw_player_source.width
		}

		draw_player_dest := rl.Rectangle{
			x = player_pos.x,
			y = player_pos.y,
			width = player_run_width*0.1 / f32(player_run_num_frames),
			height = player_run_height*0.1/2,

		}
		rl.DrawTexturePro(player_run_texture,draw_player_source,draw_player_dest, 0,0, rl.WHITE)
		rl.EndDrawing()
	}
	rl.CloseWindow()
}
