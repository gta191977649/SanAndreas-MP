//
//

#include <a_npc>

//------------------------------------------

main(){}

//------------------------------------------

NextPlayback()
{
    StartRecordingPlayback(PLAYER_RECORDING_TYPE_ONFOOT,"a2");
}

//------------------------------------------

public OnRecordingPlaybackEnd()
{
    NextPlayback();
}

//------------------------------------------

public OnNPCSpawn()
{
    NextPlayback();
}

//------------------------------------------

public OnNPCExitVehicle()
{
    StopRecordingPlayback();
}

//------------------------------------------
