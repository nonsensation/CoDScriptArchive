main(allowed)
{
	entitytypes = getentarray();
	for(i = 0; i < entitytypes.size; i++)
	{
		if(isdefined(entitytypes[i].script_gameobjectname))
		{
			dodelete = true;
			
			// parse the script_gameobjectname for multiple game types
			game_names = [];
			game_names[0] = "";
			index = 0;
			
			// turn the string into an array
			for ( j = 0;j < entitytypes[i].script_gameobjectname.size ; j++)
			{
				if ( entitytypes[i].script_gameobjectname[j] == " ")
				{
					index++;
					game_names[index] = "";
					continue;
				}
				
				game_names[index] += entitytypes[i].script_gameobjectname[j];
			}
			
			for(j = 0; j < allowed.size; j++)
			{
				for ( k = 0; k < game_names.size; k++ )
				{
					if(game_names[k] == allowed[j])
					{	
						dodelete = false;
						break;
					}
				}
			}
			
			if(dodelete)
			{
				entitytypes[i] delete();
			}
		}
	}
}

add_to_array(array, item)
{
	if(!isdefined(item))
		return array;
		
	if(!isdefined(array))
		array[0] = item;
	else
		array[array.size] = item;
	
	return array;	
}
