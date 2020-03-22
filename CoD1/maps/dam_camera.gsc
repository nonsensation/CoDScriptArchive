main()
{
	camera = maps\_load::add_camera (camera, (-22089.57, 1544.46, -1284.32), (-1.65, 124.66, 0.00));
	camera = maps\_load::add_camera (camera, (-19209.80, 1645.70, 892.45), (10.89, 139.28, 0.00));
	camera = maps\_load::add_camera (camera, (-25779.74, 6377.94, -729.12), (19.80, -24.80, 0.00));
	camera = maps\_load::add_camera (camera, (-24330.91, 6001.79, -1692.34), (-3.52, 26.46, 0.00));
	camera = maps\_load::add_camera (camera, (-22831.43, 5658.33, -1692.34), (7.15, 0.05, 0.00));
	camera = maps\_load::add_camera (camera, (-21732.07, 3277.00, -1535.41), (-20.24, 127.22, 0.00));
	camera = maps\_load::add_camera (camera, (-26960.86, 2227.83, 757.83), (23.32, 45.68, 0.00));
	level.camera = camera;
}
