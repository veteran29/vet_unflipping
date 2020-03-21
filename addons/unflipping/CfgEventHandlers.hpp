
class Extended_PostInit_EventHandlers
{
    class vet_unflipping
    {
        serverInit = "call compile preprocessFileLineNumbers 'vet\unflipping\XEH_postInitServer.sqf'";
        clientInit = "call compile preprocessFileLineNumbers 'vet\unflipping\XEH_postInitClient.sqf'";
    };
};
class Extended_PreInit_EventHandlers
{
    class vet_unflipping
    {
        init = "call compile preprocessFileLineNumbers 'vet\unflipping\XEH_preInit.sqf'";
    };
};
