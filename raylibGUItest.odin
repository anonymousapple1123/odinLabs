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

	draw_player_dest := rl.Rectangle {
		x      = pos.x,
		y      = pos.y,
		width  = width * 0.1 / f32(a.num_frames),
		height = height * 0.1 / 2,
	}
	rl.DrawTexturePro(a.texture, source, draw_player_dest, 0, 0, rl.WHITE)
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

flappy_flappy :: proc() {

	rl.InitWindow(1280, 720, "First Window")
	player_pos := rl.Vector2{640, 320}
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
		if player_pos.y > f32(rl.GetScreenHeight() - 100) {

			player_pos.y = f32(rl.GetScreenHeight() - 100)
			player_touching_ground = true

		}
		update_animation(&current_anim)
		draw_animation(current_anim, player_pos, player_flip)

		rl.EndDrawing()
	}
	rl.CloseWindow()
}
