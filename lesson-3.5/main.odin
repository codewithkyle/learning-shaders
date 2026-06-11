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

	resolution_loc := rl.GetShaderLocation(shader, "resolution")

	// Raylib's draw rect uses a single solid color so we create
	// an image texture instead so we can render the gradient
	image := rl.GenImageColor(screen_width, screen_height, rl.WHITE)
	texture := rl.LoadTextureFromImage(image)
	rl.UnloadImage(image)
	defer rl.UnloadTexture(texture)

	for !rl.WindowShouldClose() {
		width := f32(rl.GetScreenWidth())
		height := f32(rl.GetScreenHeight())
		projection := rl.MatrixOrtho(0, width, height, 0, -1, 1)
		model_view := rl.Matrix(1)

		resolution := [2]f32{width, height}

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.BeginShaderMode(shader)

		rl.SetShaderValueMatrix(shader, projection_loc, projection)
		rl.SetShaderValueMatrix(shader, model_view_loc, model_view)

		rl.SetShaderValue(
			shader,
			resolution_loc,
			raw_data(&resolution),
			rl.ShaderUniformDataType.VEC2,
		)

		rl.DrawTexturePro(
			texture,
			rl.Rectangle{0, 0, f32(texture.width), f32(texture.height)},
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
