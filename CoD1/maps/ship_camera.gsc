main()
{
	camera = maps\_load::add_camera (camera, (2350.56, 3082.96, -193.00), (-7.15, -53.66, 0.00));
	camera = maps\_load::add_camera (camera, (4380.60, 972.01, -6.05), (-7.81, -48.60, 0.00));
	camera = maps\_load::add_camera (camera, (7623.26, 687.80, 59.61), (-8.25, -149.90, 0.00));
	camera = maps\_load::add_camera (camera, (3477.35, -174.04, 1027.83), (23.76, 164.32, 0.00));
	camera = maps\_load::add_camera (camera, (5812.05, -1072.82, 583.52), (14.19, 141.77, 0.00));
	camera = maps\_load::add_camera (camera, (1895.22, -496.88, -52.62), (-15.39, 26.05, 0.00));
	camera = maps\_load::add_camera (camera, (394.21, -201.81, 9.38), (-9.02, 12.87, 0.00));
	camera = maps\_load::add_camera (camera, (3748.88, -102.87, 480.13), (0.88, 127.81, 0.00));
	camera = maps\_load::add_camera (camera, (3584.88, 296.88, 352.13), (-10.45, -145.94, 0.00));
	level.camera = camera;
}
