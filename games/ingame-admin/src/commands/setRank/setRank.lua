return {
	Name = "setrank";
	Aliases = {"rank", "rankto"};
    Description = "Sets the group rank(s) of some Player(s).";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "target";
			Description = "The player(s) who's rank you want to set";
        },
        {
            Type = "number";
            Name = "Rank";
            Description = "The rank you want to rank the player(s) to."

        }
	};
}