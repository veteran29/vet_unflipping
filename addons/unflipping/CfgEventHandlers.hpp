
class Extended_PostInit_EventHandlers
{
    class vet_unflipping
    {
        serverInit = "call compile preprocessFileLineNumbers 'vet\unflipping\XEH_postInitServer.sqf'";
        clientInit = "call compile preprocessFileLineNumbers 'vet\unflipping\XEH_postInitClient.sqf'";
    };
};
