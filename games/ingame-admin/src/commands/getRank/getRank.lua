return {
	Name = "getrank";
	Aliases = {"getRank"};
    Description = "Gets the group rank(s) of some Player(s).";
	Group = "Info";
	Args = {
		{
			Type = "players";
			Name = "target";
			Description = "The player(s) who's rank you want to get";
		}
	};
}