package main
import "core:fmt"
import rl "vendor:raylib"

Animation_Name :: enum {
	Idle,
	Run,
}

Animation :: struct {
	texture:       rl.Texture2D,
	num_frames:    int,
	frame_timer:   f32,
	current_frame: int,
	frame_length:  f32,
	name:          Animation_Name,
}
draw_animation :: proc(a: Animation, pos: rl.Vector2, flip: bool) {
	width := f32(a.texture.width)
	height := f32(a.texture.height)

	source := rl.Rectangle {
		x      = f32(a.current_frame) * width / f32(a.num_frames), // shift this position to shift to next frame
		y      = 0,
		width  = width / (f32(a.num_frames)),
		height = height / 2,
	}

	if flip {
		source.width = -source.width
	}

	dest := rl.Rectangle {
		x      = pos.x,
		y      = pos.y,
		width  = width / f32(a.num_frames),
		height = height / 2,
	}
	rl.DrawTexturePro(a.texture, source, dest, {dest.width/2, dest.height}, 0, rl.WHITE)
}

update_animation :: proc(a: ^Animation) {
	a.frame_timer += rl.GetFrameTime()

	for a.frame_timer > a.frame_length {
		a.current_frame += 1
		a.frame_timer -= a.frame_length
		if a.current_frame == a.num_frames {
			a.current_frame = 0
		}
	}

}

PixelWindowHeight :: 180
flappy_flappy :: proc() {

	rl.InitWindow(1280, 720, "First Window")
	rl.SetWindowPosition(100,100)
	rl.SetWindowState({.WINDOW_RESIZABLE})
	rl.SetTargetFPS(100)

	player_pos : rl.Vector2
	player_vel: rl.Vector2
	player_touching_ground: bool
	player_flip: bool

	player_run := Animation {
		texture      = rl.LoadTexture("7842665.png"),
		num_frames   = 3,
		frame_length = 0.1,
		name         = .Run, //enum is -> Animation_Name.Run
	}

	player_idle := Animation {
		texture      = rl.LoadTexture("7842665.png"),
		num_frames   = 3,
		frame_length = 0.7,
		name         = .Idle, //enum is -> Animation_Name.Idle
	}

	current_anim := player_idle
	platform := rl.Rectangle{-100,200,900,100}
	for !rl.WindowShouldClose() {
		//debug details --
		fmt.print("/n Frame rate : ", rl.GetFrameTime())

		rl.BeginDrawing()
		rl.ClearBackground(rl.BEIGE)
		//key press check

		if rl.IsKeyDown(.LEFT) {
			player_vel.x = -400
			player_flip = true
			if current_anim.name != .Run {
				current_anim = player_run
			}
		} else if rl.IsKeyDown(.RIGHT) {
			player_vel.x = 400
			player_flip = false
			if current_anim.name != .Run {
				current_anim = player_run
			}

		} else {
			player_vel.x = 0
			if current_anim.name != .Idle {
				current_anim = player_idle
			}

		}
		player_vel.y += 2000 * rl.GetFrameTime()

		if (rl.IsKeyPressed(.SPACE) || rl.IsKeyPressed(.UP)) && player_touching_ground {
			player_vel.y = -800
			player_touching_ground = false
		}

		player_pos += player_vel * rl.GetFrameTime()

		//keep the player in the screen space of the window
		//checks if the player is on the ground
		// if player_pos.y > f32(rl.GetScreenHeight() - 180) {

		// 	player_pos.y = f32(rl.GetScreenHeight() - 180)
		// 	player_touching_ground = true

		// }

		player_feet_collider := rl.Rectangle{
			player_pos.x - 80,
			player_pos.y - 200,
			80,
			40,
		}
		player_touching_ground = false
		if rl.CheckCollisionRecs(player_feet_collider,platform) && player_vel.y >0{
			player_vel.y = 0
			player_pos.y = platform.y
			player_touching_ground = true
		}
		update_animation(&current_anim)
		screen_height := f32(rl.GetScreenHeight())
		camera := rl.Camera2D{
			zoom = screen_height/(PixelWindowHeight*20),
			offset = {f32(rl.GetScreenWidth()-PixelWindowHeight), f32(rl.GetScreenHeight())},
			target = player_pos
		}
		rl.BeginMode2D(camera)
		draw_animation(current_anim, player_pos, player_flip)
		rl.DrawRectangleRec(platform, rl.RED)
		rl.DrawRectangleRec(player_feet_collider, rl.BLUE) //DEBUG CODE
		rl.EndMode2D();
		rl.EndDrawing()
	}
	rl.CloseWindow()
}
