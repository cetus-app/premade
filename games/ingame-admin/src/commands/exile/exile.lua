return {
	Name = "exile";
	Aliases = {"groupkick"};
    Description = "Kicks the specified player(s) from the GROUP.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "target";
			Description = "The player(s) you want to exile from the GROUP";
        }
	};
}