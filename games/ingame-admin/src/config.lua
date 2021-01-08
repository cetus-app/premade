--[[
    Cetus.app
    In-game admin: Interact with your Roblox group.
    Configuration file
]]

return {
    -- Token: string
    -- Your Cetus.app Group authentication token. You can get this from https://cetus.app/dashboard by clicking
    -- on your group and adding an API key.
    token =  "",

    --[[
        admins: Array
        An array (table) of strings or numbers. Can be:
        - "Group:GROUPID:RANKID" where GROUPID is the id of the Roblox group and RANKID is the rank required. RANKID is optional.
        - "Rank:RANKID" where RANKID is a rank in the linked group (as decided by your API key)
        - UserId (number) the user id of the specific users you'd like to admin

        This intentionally does *not* support supplying usernames to admin by because this is insecure.

        Note: These permissions only apply to actions which modify your group. Read-only commands such as getRank and
        getGroup do not need any permissions.

        If this is left empty, In Studio everyone will have access.
        If left empty in a game, it will warn and deny access to all.

        Example:
        admins = {
            12312313, -- Neztore
            "Rank:255",
            "Group:123123:255"
        }
    ]]
    admins = {}
    -- Commands configuration. The help command is globally enabled.
    -- You can find information about usage and default commands here: https://eryn.io/Cmdr/guide/Commands.html#default-commands

    -- useDefaultAdmin: boolean
    -- If true, defaultCommands will be registered (built in to Cmdr)
    -- Command list: announce (m), bring, kick, teleport (tp), kill, respawn, to
    useDefaultAdmin = true,


    -- useDefaultDebug: boolean
    -- if true, defaultDebug commands will be registered.
    -- Command list: blink (b), thru (t), position, version, fetch, get-player-place-instance, uptime
    useDefaultDebug = false
}