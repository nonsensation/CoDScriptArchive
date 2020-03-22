
main (vec1, vec2)
{
	v0 = vec1[0] - vec2[0];
	v1 = vec1[1] - vec2[1];
	v2 = vec1[2] - vec2[2];
	
	v0 = v0 * v0;
	v1 = v1 * v1;
	v2 = v2 * v2;
	
	veclength = v0 + v1 + v2;
	
	return veclength;
}