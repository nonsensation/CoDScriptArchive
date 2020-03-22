main()
{
	camera = maps\_load::add_camera (camera, (1416.21, 2455.85, -42.10), (-2.75, -127.23, 0.00));
	camera = maps\_load::add_camera (camera, (790.24, 1803.42, 0.13), (-2.20, -111.84, 0.00));
	camera = maps\_load::add_camera (camera, (813.67, 1344.40, 2.88), (-0.66, -109.97, 0.00));
	camera = maps\_load::add_camera (camera, (77.13, 446.74, 200.13), (11.55, 57.65, 0.00));
	camera = maps\_load::add_camera (camera, (534.87, 276.04, 8.13), (-14.52, -102.71, 0.00));
	camera = maps\_load::add_camera (camera, (-48.79, -730.48, 76.92), (1.87, -58.60, 0.00));
	camera = maps\_load::add_camera (camera, (-71.84, -2635.13, 40.29), (0.33, 53.25, 0.00));
	camera = maps\_load::add_camera (camera, (-1173.89, -1616.02, 13.21), (-1.43, 14.88, 0.00));
	camera = maps\_load::add_camera (camera, (19.12, 1363.46, 48.13), (-1.43, 21.37, 0.00));
	camera = maps\_load::add_camera (camera, (180.07, 397.59, 0.13), (-10.45, -63.77, 0.00));
	camera = maps\_load::add_camera (camera, (1377.92, -1860.14, 3.45), (-1.21, 114.19, 0.00));
	level.camera = camera;
}
