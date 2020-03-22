main()
{
	camera = maps\_load::add_camera (camera, (981.96, -5590.88, -63.85), (-20.49, 114.97, 0.00));
	camera = maps\_load::add_camera (camera, (-744.03, -1053.36, 5.58), (-15.44, 81.41, 0.00));
	camera = maps\_load::add_camera (camera, (-176.90, -745.47, 17.61), (-14.16, 120.71, 0.00));
	camera = maps\_load::add_camera (camera, (-1029.12, 594.65, 315.93), (-4.55, -160.49, 0.00));
	camera = maps\_load::add_camera (camera, (-1094.05, -1918.63, -158.09), (-24.15, 64.91, 0.00));
	camera = maps\_load::add_camera (camera, (-174.52, -2253.76, -6.10), (-12.07, 94.41, 0.00));
	camera = maps\_load::add_camera (camera, (689.24, 319.49, 303.12), (-24.85, 114.81, 0.00));
	camera = maps\_load::add_camera (camera, (132.74, -2795.27, 303.12), (3.57, 115.99, 0.00));
	level.camera = camera;
}
