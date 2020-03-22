#include animscripts/anims;
#include animscripts/traverse/shared;
#include common_scripts/utility;

#using_animtree( "generic_human" );

main()
{
	switch( self.type )
	{
		case "human":
			human();
			break;
		default:
/#
			assertmsg( "Traversal: 'mantle_over_96' doesn't support entity type '" + self.type + "'." );
#/
	}
}

human()
{
	preparefortraverse();
	traversedata = [];
	traversedata[ "traverseAnim" ] = animarray( "mantle_over_96", "move" );
	traversedata[ "traverseHeight" ] = 96;
	traversedata[ "traverseStance" ] = "stand";
	dotraverse( traversedata );
}
