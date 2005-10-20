reset(started)
{
    if (!started)
	set_light(1);
}

init()
{
    add_action("north", "north");
    add_action("south", "south");
    add_action("east", "east");
    add_action("west", "west");
}

short()
{
    return "Halfway up the hill on the Isle of the Magi";
}

long()
{
    write("You are halfway up the hill.\n" +
	  "On top of the hill, to the southwest, stands the ruins of the tower of\n" +
	  "Arcanarton, but there is no direct route to the top from here.\n" +
	  "To the south stands some sort of crumbling monument.\n" +
	  "A path winds around the hill to the west, and heads down to the shore\n" +
	  "of the island to the north and east\n");
}

north()
{
    this_player()->move_player("north#room/south/sislnd2");
    return 1;
}

south()
{
    this_player()->move_player("south#room/south/sislnd14");
    return 1;
}

east()
{
    this_player()->move_player("east#room/south/sislnd4");
    return 1;
}

west()
{
    this_player()->move_player("west#room/south/sislnd13");
    return 1;
}
