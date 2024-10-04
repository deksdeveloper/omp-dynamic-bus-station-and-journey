#include <open.mp>
#include <a_mysql>
#include <sscanf2>
#include <streamer>
#include <zcmd>
#include <easyDialog>

#pragma warning disable 239
#pragma warning disable 214
#pragma warning disable 213
#pragma warning disable 240
#pragma warning disable 204

// MySQL
#define		MYSQL_HOST 			"127.0.0.1"
#define		MYSQL_USER 			"root"
#define 	MYSQL_PASSWORD 		""
#define		MYSQL_DATABASE 		"station"
new MySQL: g_SQL;

// Variables
#define MAX_STATION 20
new SelectedStation[MAX_PLAYERS] = -1;
new BusCard[MAX_PLAYERS] = 0;
new BusCardBalance[MAX_PLAYERS] = 0;
#define BUSCARD_PRICE 200

enum Station
{
	ID,
	bool:Exists,
	stationName[30],
	Float:stationPos[3],
	stationPrice,
	stationTime,
	Text3D: stationLabel,
	stationPickup
}
new StationData[MAX_STATION][Station];

main()
{
	printf(" ");
	printf("  -------------------------------");
	printf("  |  Bus Station System - DEKS |");
	printf("  -------------------------------");
	printf(" ");
}

public OnGameModeInit()
{
	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("Bus System: MySQL connection failed. Server is shutting down.");
		SendRconCommand("exit");
		return 1;
	}

	print("Bus System: MySQL connection is successful.");
	
	Station_Load();
	Bus_Object();
	return 1;
}

public OnGameModeExit()
{
	mysql_close(g_SQL);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnFilterScriptInit()
{
	printf(" ");
	printf("  -----------------------------------------");
	printf("  |  Bus Stop System is closed, data is saved. |");
	printf("  -----------------------------------------");
	printf(" ");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	return 1;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 0;
}

public OnPlayerSelectObject(playerid, SELECT_OBJECT:type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, EDIT_RESPONSE:response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	return 1;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerPickUpPlayerPickup(playerid, pickupid)
{
	return 1;
}

public OnPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

public OnTrailerUpdate(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return 1;
}


stock Station_Load()
{
    mysql_query(g_SQL, "SELECT * FROM `stations`");

	new rows = cache_num_rows();
    printf("Bus System: A total of %d stations were installed.", rows);

	if (rows)
	{
	    new lkID;
		for (new i = 0; i < rows; i ++) if (i < MAX_STATION)
	    {
	        cache_get_value_name_int(i, "ID", lkID);
	        
	        if (IsValidDynamic3DTextLabel(StationData[lkID][stationLabel])) DestroyDynamic3DTextLabel(StationData[lkID][stationLabel]);
			if (IsValidDynamicPickup(StationData[lkID][stationPickup])) DestroyDynamicPickup(StationData[lkID][stationPickup]);

	        StationData[lkID][Exists] = true;
	        StationData[lkID][ID] = lkID;

	        cache_get_value_name(i, "Ad", StationData[lkID][stationName], 30);
	        cache_get_value_name_float(i, "posX", StationData[lkID][stationPos][0]);
	        cache_get_value_name_float(i, "posY", StationData[lkID][stationPos][1]);
	        cache_get_value_name_float(i, "posZ", StationData[lkID][stationPos][2]);
	        cache_get_value_name_int(i, "stationPrice", StationData[lkID][stationPrice]);
	        cache_get_value_name_int(i, "stationTime", StationData[lkID][stationTime]);
	        new str[256];
	        format(str, sizeof(str), "{E74C3C}(( %s - Bus Station #%d ))\n{afafaf}« /station »", StationData[lkID][stationName], lkID);
			StationData[lkID][stationLabel] = CreateDynamic3DTextLabel(str, -1, StationData[lkID][stationPos][0], StationData[lkID][stationPos][1], StationData[lkID][stationPos][2], 10.0);
			StationData[lkID][stationPickup] = CreateDynamicPickup(19134, 23, StationData[lkID][stationPos][0], StationData[lkID][stationPos][1], StationData[lkID][stationPos][2], 0, 0);
	    }
	}
    return 1;
}

CMD:createstation(playerid, params[])
{
	new name[30];
	static fiyat, sure;
    if (sscanf(params, "dds[30]", fiyat, sure, name)) return SendClientMessage(playerid, -1, "/createstation [Price] [Time (second)] [Name]");
    if (strlen(name) > 30) return SendClientMessage(playerid, -1, "Station Name cannot exceed 30 characters.");
    new Float:pos[3];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    new id = Create_Station(name, pos[0], pos[1], pos[2], fiyat, sure);
    if (id == -1) return SendClientMessage(playerid, -1, "The server has reached its maximum station limit.");
    SendClientMessage(playerid, -1, "Added station, ID: %d", id);
	return 1;
}

CMD:removestation(playerid, params[])
{
	new id;
    if (sscanf(params, "i", id)) return SendClientMessage(playerid, -1, "/removestation [ID]");
    if ((id < 0 || id >= MAX_STATION) || !StationData[id][Exists]) return SendClientMessage(playerid, -1, "Incorrect ID.");
    Remove_Station(id);
    SendClientMessage(playerid, -1, "Removed station. ID: %d", id);
	return 1;
}

stock Remove_Station(id)
{
	new query[100];
	format(query, sizeof(query), "DELETE FROM `stations` WHERE `ID` = '%d'", StationData[id][ID]);
	mysql_query(g_SQL, query, false);
	StationData[id][Exists] = false;
	if (IsValidDynamic3DTextLabel(StationData[id][stationLabel])) DestroyDynamic3DTextLabel(StationData[id][stationLabel]);
	if (IsValidDynamicPickup(StationData[id][stationPickup])) DestroyDynamicPickup(StationData[id][stationPickup]);
	format(StationData[id][stationName], 30, "");
	StationData[id][stationPos][0] = 0.0;
	StationData[id][stationPos][1] = 0.0;
	StationData[id][stationPos][2] = 0.0;
	StationData[id][stationPrice] = 0;
	StationData[id][stationTime] = 0;
	return 1;
}

stock Create_Station(ad[], Float:posX, Float:posY, Float:posZ, fiyat, sure)
{
	for (new i; i<MAX_STATION; i++)
	{
	    if (StationData[i][Exists] == false)
	    {
	        StationData[i][Exists] = true;
			StationData[i][ID] = i;


	        format(StationData[i][stationName], 30, ad);
	        StationData[i][stationPos][0] = posX;
	        StationData[i][stationPos][1] = posY;
	        StationData[i][stationPos][2] = posZ;
	        StationData[i][stationPrice] = fiyat;
	        StationData[i][stationTime] = sure;
	        
	        new str[256];
	        format(str, sizeof(str), "{E74C3C}(( %s - Bus Station #%d ))\n{afafaf}« /station »", StationData[i][stationName], i);
			StationData[i][stationLabel] = CreateDynamic3DTextLabel(str, -1, StationData[i][stationPos][0], StationData[i][stationPos][1], StationData[i][stationPos][2], 10.0);
			StationData[i][stationPickup] = CreateDynamicPickup(19134, 23, StationData[i][stationPos][0], StationData[i][stationPos][1], StationData[i][stationPos][2], 0, 0);

	        new query[256];
			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `stations` (`ID`, `stationName`, `posX`, `posY`, `posZ`, `stationPrice`, `stationTime`) VALUES ('%d', '%s', '%f', '%f', '%f', '%d', '%d')", i, ad, posX, posY, posZ, fiyat, sure);
			mysql_query (g_SQL, query);
			return i;
	    }
	}
	return -1;
}

CMD:station(playerid)
{
   if(BusCard[playerid] == 0) return SendClientMessage(playerid, -1, "You do not have 'Bus Card' in your inventory.");
   if(SelectedStation[playerid] != -1) return SendClientMessage(playerid, -1, "You have already chosen a station or you are on a journey!");
   new station = -1;
   if ((station = Station_Near(playerid)) != -1)
   {
       Station_Menu(playerid);
   }
   else SendClientMessage(playerid, -1, "You are not close to any bus stop.");
   return 1;
}

stock Station_Menu(playerid)
{
	new str[1024], string[256], sayi;
	strcat(str, "ID\tName\tTime (Second)\tPrice\n");
	for (new i; i<MAX_STATION; i++)
	{
         if (StationData[i][Exists] == true)
	     {
			 sayi++;
		     format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%d/s\t{FF6347}%s\n", i, StationData[i][stationName], StationData[i][stationTime], FormatNumber(StationData[i][stationPrice]));
	         strcat(str, string);
		 }
	}
	if (sayi == 0) return SendClientMessage(playerid, -1, "Never found a stop.");
	format(string, sizeof(string), "Bus Stations (%d quantity)", sayi);
	Dialog_Show(playerid, StationDialog, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Select", "Exit");
	return 1;
}

Dialog:StationDialog(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = strval(inputtext);
	    if (StationData[id][Exists] == true)
	    {
	        SelectedStation[playerid] = id;
	        new str[256];
			format(str, sizeof(str), "Do you want to go to the %s stop with a fee of %d/s?", FormatNumber(StationData[id][stationPrice]), StationData[id][stationTime], StationData[id][stationName]);
			Dialog_Show(playerid, StationConf, DIALOG_STYLE_MSGBOX, "Station Confirmation", str, "Yes", "No");
	    }
	}
	return 1;
}

Dialog:StationConf(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		if(SelectedStation[playerid] != -1)
		{
			SendClientMessage(playerid, -1, "You refused to go to the %s station.", StationData[SelectedStation[playerid]][stationName]);
			SelectedStation[playerid] = -1;
		}
		else
		{
			SendClientMessage(playerid, -1, "There's been a problem with the station system!");
		}
	}
	if(response)
	{
		if(SelectedStation[playerid] != -1)
		{
			if(BusCardBalance[playerid] < StationData[SelectedStation[playerid]][stationPrice]) return SendClientMessage(playerid, -1, "You don't have enough money.");
			SendClientMessage(playerid, -1, "You have accepted to go to the %s stop with a fee of %d/s!", FormatNumber(StationData[SelectedStation[playerid]][stationPrice]), StationData[SelectedStation[playerid]][stationTime], StationData[SelectedStation[playerid]][stationName]);
			SendClientMessage(playerid, -1, "Your journey is starting, have a safe trip! %s has been deducted from your balance!", FormatNumber(StationData[SelectedStation[playerid]][stationPrice]));
			SetPlayerPos(playerid, 2022.0996,2235.5178,2103.9536);
			SetPlayerFacingAngle(playerid, 1.2925);
			new sure = StationData[SelectedStation[playerid]][stationTime]*1000;
			SetTimerEx("StationTimer", sure, false, "i", playerid);
			BusCardBalance[playerid] -= StationData[SelectedStation[playerid]][stationPrice];
		}
		else
		{
			SendClientMessage(playerid, -1, "There's been a problem with the station system!");
		}
	}
	return 1;
}

forward StationTimer(playerid);
public StationTimer(playerid)
{
	SendClientMessage(playerid, -1, "You have successfully arrived at station %s.", StationData[SelectedStation[playerid]][stationName]);
	SetPlayerPos(playerid, StationData[SelectedStation[playerid]][stationPos][0], StationData[SelectedStation[playerid]][stationPos][1], StationData[SelectedStation[playerid]][stationPos][2]);
    SelectedStation[playerid] = -1;
	return 1;
}

stock Station_Near(playerid)
{
    for (new i = 0; i != MAX_STATION; i ++) if (GetPlayerVirtualWorld(playerid) == 0 && IsPlayerInRangeOfPoint(playerid, 5.0, StationData[i][stationPos][0], StationData[i][stationPos][1], StationData[i][stationPos][2]))
	{
			return i;
	}
	return -1;
}

CMD:buscard(playerid)
{
	Dialog_Show(playerid, BusCardMenu, DIALOG_STYLE_LIST, "{FF9933}Bus Card", "{AFAFAF}» {FFFFFF}Buy Bus Card\n{AFAFAF}» {FFFFFF}Fill Balance", "{FFFFFF}Select", "{FFFFFF}Exit");
	return 1;
}

Dialog:BusCardMenu(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
			{
			    if (BusCard[playerid] == 1) return SendClientMessage(playerid, -1, "You already own a Bus Card.");
			    new str[256];
			    format(str, sizeof(str), "Do you want to purchase a Bus Card for %s?", FormatNumber(BUSCARD_PRICE));
			    Dialog_Show(playerid, BuyBusCard, DIALOG_STYLE_MSGBOX, "Purchase Bus Card", str, "Yes", "No");
			}
			case 1:
			{
			    if (BusCard[playerid] == 0) return SendClientMessage(playerid, -1, "You cannot load balance without a Bus Card.");
			    new str[512];
			    format(str, sizeof str, "How much balance would you like to load onto your Bus Card? (1 Bus Card Balance: $2)");
			    Dialog_Show(playerid, BusCardLoadBalance, DIALOG_STYLE_INPUT, "Load Bus Card Balance", str, "Load", "Exit");
			}
			

	    }
	}
	return true;
}

Dialog:BusCardLoadBalance(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new amount = strval(inputtext);
	    if (!IsNumeric(inputtext))
		{
		    new str[512];
		    format(str, sizeof str, "You must specify an amount!\nHow much balance would you like to load onto your TownCard? (1 TownCard Balance: $2)");
		    return Dialog_Show(playerid, BusCardLoadBalance, DIALOG_STYLE_INPUT, "Load TownCard Balance", str, "Load", "Exit");
		}
		if (GetPlayerMoney(playerid) < amount * 2)
		{
		    new str[512];
		    format(str, sizeof str, "You don't have enough money!\nHow much balance would you like to load onto your TownCard? (1 TownCard Balance: $2)");
		    return Dialog_Show(playerid, BusCardLoadBalance, DIALOG_STYLE_INPUT, "Load TownCard Balance", str, "Load", "Exit");
		}
		SendClientMessage(playerid, -1, "You have loaded %d TownCard balance by paying %s!", amount, FormatNumber(amount * 2));
		BusCardBalance[playerid] += amount;
		GivePlayerMoney(playerid, -2 * amount);
		
	}
	return true;
}

Dialog:BuyBusCard(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    SendClientMessage(playerid, -1, "You have canceled the Bus Card purchase.");
	}
	if (response)
	{
	    if (GetPlayerMoney(playerid) < BUSCARD_PRICE) return SendClientMessage(playerid, -1, "You don't have enough money.");
	    SendClientMessage(playerid, -1, "You have purchased a TownCard for %s!", FormatNumber(BUSCARD_PRICE));
	    BusCard[playerid] = 1;
	    GivePlayerMoney(playerid, -BUSCARD_PRICE);
	}
	return 1;
}

IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return 0;
	}
	return 1;
}

FormatNumber(value)
{
    // http://forum.sa-mp.com/showthread.ph...781#post843781
    new string[24];
    format(string, sizeof(string), "%d", value);
    for(new i = (strlen(string) - 3); i > (value < 0 ? 1 : 0) ; i -= 3)
    {
        strins(string[i], ",", 0);
    }
    return string;
}

stock Bus_Object()
{
	new tmpobjid;
	tmpobjid = CreateDynamicObjectEx(2631, 2022.000000, 2236.699951, 2102.899902, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2631, 2022.000000, 2240.600097, 2102.899902, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2631, 2022.000000, 2244.500000, 2102.899902, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2631, 2022.000000, 2248.399902, 2102.899902, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(16501, 2022.099975, 2238.300048, 2102.800048, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(16501, 2022.099975, 2245.300048, 2102.800048, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(16000, 2024.199951, 2240.100097, 2101.199951, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(16000, 2019.800048, 2240.600097, 2101.199951, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(16000, 2022.199951, 2248.699951, 2101.199951, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(16501, 2021.800048, 2246.500000, 2107.300048, 0.000000, 270.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(16501, 2022.000000, 2240.800048, 2107.300048, 0.000000, 270.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(16501, 2022.000000, 2233.699951, 2107.300048, 0.000000, 270.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(18098, 2024.300048, 2239.600097, 2104.800048, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(18098, 2024.300048, 2239.699951, 2104.699951, 0.000000, 0.000000, 450.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(18098, 2020.099975, 2239.600097, 2104.800048, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(18098, 2020.000000, 2239.600097, 2104.699951, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2023.599975, 2236.100097, 2106.699951, 0.000000, 180.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2023.599975, 2238.100097, 2106.699951, 0.000000, 180.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2023.599975, 2240.100097, 2106.699951, 0.000000, 180.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2023.599975, 2242.100097, 2106.699951, 0.000000, 180.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2023.599975, 2244.100097, 2106.699951, 0.000000, 180.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2023.599975, 2246.100097, 2106.699951, 0.000000, 180.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2023.599975, 2248.100097, 2106.699951, 0.000000, 180.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2020.300048, 2235.100097, 2106.699951, 0.000000, 180.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2020.300048, 2237.100097, 2106.699951, 0.000000, 180.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2020.300048, 2239.100097, 2106.699951, 0.000000, 180.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2020.300048, 2241.100097, 2106.699951, 0.000000, 180.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2020.300048, 2243.100097, 2106.699951, 0.000000, 180.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2180, 2020.300048, 2245.100097, 2106.699951, 0.000000, 180.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2674, 2023.400024, 2238.300048, 2102.899902, 0.000000, 0.000000, 600.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2674, 2020.400024, 2242.300048, 2102.899902, 0.000000, 0.000000, 600.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2674, 2023.400024, 2246.300048, 2102.899902, 0.000000, 0.000000, 600.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2022.000000, 2242.100097, 2103.500000, 0.000000, 0.000000, 540.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2022.000000, 2243.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2022.000000, 2245.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2022.000000, 2246.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2022.000000, 2248.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2022.000000, 2249.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2022.000000, 2251.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2024.599975, 2242.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2024.599975, 2243.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2024.599975, 2245.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2024.599975, 2246.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2024.599975, 2248.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2024.599975, 2249.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2024.599975, 2251.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2019.400024, 2242.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2019.400024, 2243.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2019.400024, 2245.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2019.400024, 2246.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2019.400024, 2248.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2019.400024, 2249.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2019.400024, 2251.100097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2022.000000, 2253.600097, 2104.000000, -6.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2021.099975, 2253.600097, 2104.000000, -6.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(14405, 2024.599975, 2253.600097, 2103.500000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2674, 2020.400024, 2235.699951, 2102.899902, 0.000000, 0.000000, 52.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2673, 2020.400024, 2246.699951, 2102.899902, 0.000000, 0.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2700, 2023.500000, 2235.100097, 2105.500000, 180.000000, -4.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2700, 2020.400024, 2235.100097, 2105.500000, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2700, 2023.500000, 2242.100097, 2105.500000, 180.000000, -4.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2700, 2020.400024, 2242.100097, 2105.500000, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1799, 2023.099975, 2234.199951, 2105.699951, 270.000000, 0.000000, 360.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1799, 2019.800048, 2234.199951, 2105.699951, 270.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1538, 2022.699951, 2234.699951, 2102.800048, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1799, 2022.099975, 2234.199951, 2106.100097, 720.000000, 90.000000, 450.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1799, 2021.800048, 2234.199951, 2105.100097, 0.000000, 270.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1799, 2022.099975, 2234.199951, 2107.300048, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1799, 2021.599975, 2234.199951, 2106.300048, 0.000000, 270.000000, 270.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1799, 2022.300048, 2234.199951, 2104.300048, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
  return 1;
}

CMD:money(playerid)
{
	GivePlayerMoney(playerid, 1000);
	SendClientMessage(playerid, -1, "Added 1000$");
	return 1;
}