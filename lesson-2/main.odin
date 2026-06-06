package main

import rl "vendor:raylib"

main :: proc() {
	screen_width := i32(1280)
	screen_height := i32(720)

	rl.SetConfigFlags({.WINDOW_RESIZABLE})

	rl.InitWindow(screen_width, screen_height, "Lesson 1")
	defer rl.CloseWindow()

	rl.SetTargetFPS(60)

	shader := rl.LoadShader("shaders/vert.glsl", "shaders/frag.glsl")
	defer rl.UnloadShader(shader)

	// Matching raylib internals to GLSL inputs
	shader.locs[rl.ShaderLocationIndex.VERTEX_POSITION] = rl.GetShaderLocationAttrib(
		shader,
		"vertexPosition",
	)
	shader.locs[rl.ShaderLocationIndex.VERTEX_TEXCOORD01] = rl.GetShaderLocationAttrib(
		shader,
		"vertexTexCoord",
	)

	// Raylib prefers mvp matrix, however, to follow the tutorial we're
	// manually creating the projection and model view matrix ourselves
	projection_loc := rl.GetShaderLocation(shader, "projectionMatrix")
	model_view_loc := rl.GetShaderLocation(shader, "modelViewMatrix")

	diffuse_loc := rl.GetShaderLocation(shader, "diffuse")
	overlay_loc := rl.GetShaderLocation(shader, "overlay")
	tint_loc := rl.GetShaderLocation(shader, "tint")

	// Raylib's draw rect uses a single solid color so we create
	// an image texture instead so we can render the gradient
	image := rl.GenImageColor(screen_width, screen_height, rl.WHITE)
	base_texture := rl.LoadTextureFromImage(image)
	defer rl.UnloadTexture(base_texture)

	dog_texture := rl.LoadTexture("dog.jpg")
	rl.SetTextureWrap(dog_texture, rl.TextureWrap.MIRROR_REPEAT)
	defer rl.UnloadTexture(dog_texture)

	overlay_texture := rl.LoadTexture("overlay.png")
	defer rl.UnloadTexture(overlay_texture)

	tint_color := [4]f32{1.0,0.0,0.0,1.0}

	for !rl.WindowShouldClose() {
		width := f32(rl.GetScreenWidth())
		height := f32(rl.GetScreenHeight())
		projection := rl.MatrixOrtho(0, width, height, 0, -1, 1)
		model_view := rl.Matrix(1)
		color1 := [4]f32{1.0, 1.0, 0.0, 1.0}
		color2 := [4]f32{0.0, 1.0, 1.0, 1.0}

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.BeginShaderMode(shader)

		rl.SetShaderValueMatrix(shader, projection_loc, projection)
		rl.SetShaderValueMatrix(shader, model_view_loc, model_view)

		rl.SetShaderValue(
			shader,
			tint_loc,
			&tint_color,
			rl.ShaderUniformDataType.VEC4,
		)

		rl.SetShaderValueTexture(
			shader,
			diffuse_loc,
			dog_texture,
		)

		rl.SetShaderValueTexture(
			shader,
			overlay_loc,
			overlay_texture,
		)

		// this is just a blank texture used to provide vertex data
		// so we don't have to create the mesh ourselves
		rl.DrawTexturePro(
			base_texture,
			rl.Rectangle{0, 0, f32(base_texture.width), f32(base_texture.height)},
			rl.Rectangle{0, 0, width, height},
			rl.Vector2{0, 0},
			0,
			rl.WHITE,
		)

		rl.EndShaderMode()

		rl.DrawFPS(10, 10)
		rl.EndDrawing()
	}
}
