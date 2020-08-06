
--[[
   _____       _
  / ____|     | |
 | |      ___ | |_  _   _  ___     __ _  _ __   _ __
 | |     / _ \| __|| | | |/ __|   / _` || '_ \ | '_ \
 | |____|  __/| |_ | |_| |\__ \ _| (_| || |_) || |_) |
  \_____|\___| \__| \__,_||___/(_)\__,_|| .__/ | .__/
                                        | |    | |
										|_|    |_|
------------------------------------------------------
Cetus: Promotion centre
Github: https://github.com/cetus-app/cetus-rbx/
Our site: https://cetus.app

You can do whatever you like with this place, but we recomend inserting some terrain or enviroment related to your group
	below the stage, to make it more interesting!

This centre allows you to have users join and have a list of availible ranks presented to them.
Configuring this can be quite complicated. If you know how to code in Lua, you shouldn't have too many problems!

Need a hand? We'd be happy to help you configure this centre! Just join our Discord, you can find the link on our website.
--]]

--[[

	How to configure:
		You can use the following options:
		minAgeDays: number (The minimum age, in days, to use this centre.) Default: 7
		token: string (Your API key) Required.
		baseRank: number (Optional; This rank is always availible for promotion. Useful for "immigration" etc.)

		// Note: You *must* provide either ranks or func. If both are provided, the two tables will be combined.
		ranks: Table (Describes the conditions that give different ranks in your main group)
		ranks = {
			[Main group rank] = RankFilter
		}
			RankFilter can be either:
				- A function (Passed the Player, RankId): Should return a boolean (i.e. promote, or don't)
				- A table (to map it to subGroups):
				{
					-- Key is sub group id. Value is array of ranks in that subgroup which give this rank.
					-- Pass true for all ranks in group
					[Sub group id] = {Subgroup_RANK, subgroupRANK},
					[Sub group id] = True
				}
			Example:
			ranks = {
				[3] = {
					[123123] = True,
					[456789] = {3,4,5,6}
				}

			}
		func: Function that determines the rank(s) a user gets.
			It is passed the Player instance. It should return an array of availible rank numbers (1-255)
			If it returns false (or an empty table), we will say there are none availible
			Can be used for custom configurations, and for binding gamepasses.


	------------------------------------------------------
]]

require(script.module)({
	minAgeDays = 7,
	token = "My_sekret_API_Key",
	ranks = {
		[1] = {
			[2512312] = {}
			}
	},
	baseRank = 3 -- if they arent ranked above this, we'll try to rank them to it.
});
