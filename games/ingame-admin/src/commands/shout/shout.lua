return {
	Name = "shout";
	Aliases = {};
    Description = "Shouts your message to the group shout";
	Group = "Admin";
	Args = {
		{
			Type = "string";
			Name = "Message";
			Description = "The message to shout";
		}
	};
}