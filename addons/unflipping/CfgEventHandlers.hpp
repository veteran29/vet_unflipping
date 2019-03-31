
class Extended_PreInit_EventHandlers
{
    class vet_unflipping
    {
        serverInit = "call compile preprocessFileLineNumbers 'vet\unflipping\XEH_preInitServer.sqf'";
        clientInit = "call compile preprocessFileLineNumbers 'vet\unflipping\XEH_preInitClient.sqf'";
    };
};
