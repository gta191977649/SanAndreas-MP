/*----------------------------------------------------------------------------*-
					=====================================
					Y Sever Includes - Language Text Core
					=====================================
Description:
	Provides interfaces for displaying text from anywhere by way of native like
	functions using text indexes rather than text.  Due to a compile problem a
	number of the stock functions should be static but can't be.
Legal:
	Version: MPL 1.1
	
	The contents of this file are subject to the Mozilla Public License Version 
	1.1 (the "License"); you may not use this file except in compliance with 
	the License. You may obtain a copy of the License at 
	http://www.mozilla.org/MPL/
	
	Software distributed under the License is distributed on an "AS IS" basis,
	WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
	for the specific language governing rights and limitations under the
	License.
	
	The Original Code is the SA:MP script information include.
	
	The Initial Developer of the Original Code is Alex "Y_Less" Cole.
	Portions created by the Initial Developer are Copyright (C) 2008
	the Initial Developer. All Rights Reserved.
	
	Contributors:
		ZeeX, koolk
	
	Thanks:
		Peter, Cam - Support.
		ZeeX - Very productive conversations.
		koolk - IsPlayerinAreaEx code.
		TheAlpha - Danish translation.
		breadfish - German translation.
		Fireburn - Dutch translation.
		yom - French translation.
		50p - Polish translation.
		Zamaroht - Spanish translation.
		Dracoblue, sintax, mabako, Xtreme, other coders - Producing other modes
			for me to strive to better.
		Pixels^ - Running XScripters where the idea was born.
		Matite - Pestering me to release it and using it.
	
	Very special thanks to:
		Thiadmer - PAWN.
		Kye/Kalcor - SA:MP.
		SA:MP Team past, present and future - SA:MP.
Version:
	0.1.1
Changelog:
	17/02/07:
		Added saving of style parameter for text draws.
	27/12/07:
		Added text_draw support.
	24/06/07:
		Modified a few functions to use Bit_GetBit for speed.
	19/06/07:
		Added default language for alt language with no text.
		Added console errors.
		Added support for blank INI strings to ignore the text.
		Increased speed of non format sends by saving each language
	14/06/07:
		Added type and data loading for strings.
		Altered display functions to use files defined styles.
	13/06/07:
		Removed unfound text ignorance in group send functions.
		Added improved error handling to support custom messges.
	02/05/07:
		Added YSI_ prefix to all globals.
	23/03/07:
		First version.
Functions:
	Public:
		-
	Core:
		-
	Stock:
		-
	Static:
		-
	Inline:
		-
	API:
		-
Callbacks:
	-
Definitions:
	-
Enums:
	-
Macros:
	-
Tags:
	-
Variables:
	Global:
		-
	Static:
		-
Commands:
	-
Compile options:
	-
Operators:
	-
-*----------------------------------------------------------------------------*/

static stock
	YSI_g_sTextTable[MAX_LANGUAGES * MAX_TEXT][MAX_TEXT_ENTRY char],
	YSI_g_sNameTable[MAX_TEXT][E_TEXT_POINTERS],
	Bintree:YSI_g_sSearchTree[MAX_TEXT][E_BINTREE_TREE],
	YSI_g_sTextInited,
	YSI_g_sBufferIndex,
	YSI_g_sLangBuffer[MAX_LANGUAGES],
	YSI_g_sTextCount,
	Language:YSI_g_sBufferLang,
	YSI_g_sColours[MAX_TEXT_COLOURS][2];

OnScriptInit()
{
	// Blank all arrays.
	// Do other inits.
	// NOW sort out the text.
}

/*----------------------------------------------------------------------------*-
Function:
	FindTextPointers
Params:
	data[] - The textual identifier of the string we want to find.
Return:
	A pointer to the array of pointers to get the language specific text.
	TEXT_NO_POINTERS on fail.
Notes:
	Finds a matching hash, then checks the text too for collisions.
-*----------------------------------------------------------------------------*/

stock Text_FindFast(data[])
{
	new
		leaf,
		pointer,
		value = bernstein(data);
	while ((pointer = Bintree_FindValue(YSI_g_sSearchTree, value, leaf)) != BINTREE_NOT_FOUND)
	{
		if (!Text_HasCollisions()) return pointer;
		if (!strcmp(Text_Name(pointer), data)) return pointer;
	}
	return TEXT_NO_POINTERS;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_ResetLangPointers
Params:
	Language:languageID - Language to reset.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Text_ResetLangPointers(%1) \
	for (new Language:_languagesToReset_; _languagesToReset_ < MAX_LANGUAGES; _languagesToReset_++) Text_SetLangPointer((%1), _languagesToReset_, TEXT_NO_TEXT)

/*----------------------------------------------------------------------------*-
Function:
	Text_AddToBuffer
Params:
	identifier[] - The textual identifier of the string we're saving.
	text[] - The text we're saving.
Return:
	-
Notes:
	This function saves the passed data into the arrays.  The text is just
	dumped in anywhere for speed, the identifier MAY be dumped if the tree
	doesn't exist yet, otherwise the pointers are just updated for the new
	text.
-*----------------------------------------------------------------------------*/

stock Text_AddToBuffer(identifier[], text[])
{
	if (text[0] == 1) text[0] = '\0';
	if (YSI_g_sTextCount >= MAX_TEXT)
	{
		P:1("*** Internal Error: Text buffer full at %s (%s)", identifier, text);
		return;
	}
	new
		pos;
	if (YSI_g_sTextInited)
	{
		if ((pos = Text_FindTextPointers(identifier)) != TEXT_NO_POINTERS)
		{
			if (YSI_g_sNameTable[pos][E_TEXT_POINTERS_POINTER][YSI_g_sBufferLang] != TEXT_NO_TEXT) return;
			Text_SetLangPointer(pos, YSI_g_sBufferLang, YSI_g_sBufferIndex);
		}
		else
		{
			Text_AddText(identifier, YSI_g_sTextCount);
			Text_ResetLangPointers(YSI_g_sTextCount);
			Text_SetLangPointer(YSI_g_sTextCount, YSI_g_sBufferLang, YSI_g_sBufferIndex);
			YSI_g_sTextCount++;
		}
	}
	else
	{
		Text_ResetLangPointers(YSI_g_sBufferIndex);
		Text_SetLangPointer(YSI_g_sBufferIndex, YSI_g_sBufferLang, YSI_g_sBufferIndex);
		strcpy(YSI_g_sNameTable[YSI_g_sBufferIndex][E_TEXT_POINTERS_NAME], identifier, MAX_TEXT_ENTRY);
		YSI_g_sTextCount++;
	}
	strcpy(YSI_g_sTextTable[YSI_g_sBufferLang][YSI_g_sBufferIndex], text, MAX_TEXT_ENTRY);
	YSI_g_sBufferIndex++;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_DataSave_Colors
Params:
	identifier[] - Name of the ini data been passed.
	text[] - The corresponding data from the ini.
Return:
	-
Notes:
	Wrapper for the correctly spelt version as Americans can't spell.
-*----------------------------------------------------------------------------*/

public Text_DataSave_colors(identifier[], text[])
{
	Text_DataSave_colours(identifier, text);
}

/*----------------------------------------------------------------------------*-
Function:
	Text_DataSave_Colours
Params:
	identifier[] - Name of the ini data been passed.
	text[] - The corresponding data from the ini.
Return:
	-
Notes:
	Saves colour defines so people can just use things like RED in the main
	data part of the text file section and define them in the colour section.
	
	The only function I remember actually checking for the NULL string - I'll
	have to do womthing about that :/.
-*----------------------------------------------------------------------------*/

public Text_DataSave_colours(identifier[], text[])
{
	if (text[0] == 1) return;
	new
		err = Text_SetColour(bernstein(identifier), hexstr(text));
	if (err == 1)
	{
		printf("YSI warning - colour hash array full, please increase MAX_TEXT_COLOURS from" #MAX_TEXT_COLOURS);
	}
	else if (!err)
	{
		printf("YSI warning - colour hash collision detected on \"%d\", please tell Y_Less", identifier);
	}
}

stock Text_SetColour(hash, value)
{
	for (new i = 0; i < MAX_TEXT_COLOURS; i++)
	{
		if (YSI_g_sColours[i][0] == hash) return 0;
		else if (!YSI_g_sColours[i][1])
		{
			YSI_g_sColours[i][0] = hash;
			YSI_g_sColours[i][1] = value;
			return -1;
		}
	}
	return 1;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_DataSave_Data
Params:
	identifier[] - Name of the ini data been passed.
	text[] - The corresponding data from the ini.
Return:
	-
Notes:
	Takes a range of inputs and spellings for different parameters.  In the ini
	you should put the name of the text entry you wish to set data for first
	and then have subsequent entries set the parameters.  Supports named and
	hex colours (not integer though).
	
	Now saves style for text draws.
-*----------------------------------------------------------------------------*/

public Text_DataSave_data(identifier[], text[])
{
	static
		current = -1;
	if (text[0] == 1) current = Text_FindTextPointers(identifier);
	else if (!strcmp(identifier, "name", true)) current = Text_FindTextPointers(text);
	else if (current != -1)
	{
		if (!strcmp(identifier, "type", true)) YSI_g_sNameTable[current][E_TEXT_POINTERS_STYLE] = strval(text);
		else if (!strcmp(identifier, "colour", true) || !strcmp(identifier, "color", true))
		{
			if (ishex(text)) YSI_g_sNameTable[current][E_TEXT_POINTERS_APPEAR] = hexstr(text);
			else
			{
				YSI_g_sNameTable[current][E_TEXT_POINTERS_APPEAR] = Text_GetColour(bernstein(text));
			}
		}
		else if (!strcmp(identifier, "time", true)) YSI_g_sNameTable[current][E_TEXT_POINTERS_APPEAR] = strval(text);
		else if (!strcmp(identifier, "style", true)) YSI_g_sNameTable[current][E_TEXT_POINTERS_APPEAR] = bernstein(text);
	}
}

/*----------------------------------------------------------------------------*-
Function:
	Text_GetColour
Params:
	hash - Hash of the colour name to get the value of.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

stock Text_GetColour(hash)
{
	for (new i = 0; i < MAX_TEXT_COLOURS; i++) 
	{
		if (YSI_g_sColours[i][0] == hash)
		{
			return YSI_g_sColours[i][1];
		}
	}
	return 0xFF0000AA;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_SetStyle
Params:
	identifier[] - Text name to set style of.
	type - Type of style to use for the text.
	info - Extra information for the style (colour/time/TD id).
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

stock Text_SetStyle(identifier[], type, info)
{
	new
		current = Text_FindTextPointers(identifier);
	if (current != -1)
	{
		YSI_g_sNameTable[current][E_TEXT_POINTERS_STYLE] = type;
		YSI_g_sNameTable[current][E_TEXT_POINTERS_APPEAR] = info;
	}
}

/*----------------------------------------------------------------------------*-
Function:
	Text_AddText
Params:
	identifier[] - Text name to add.
	index - Position in the pointer array.
Return:
	-
Notes:
	Adds an item to the search tree after sorting.
-*----------------------------------------------------------------------------*/

static Text_AddText(identifier[], index)
{
	new
		input[E_BINTREE_INPUT];
	input[E_BINTREE_INPUT_VALUE] = bernstein(identifier);
	input[E_BINTREE_INPUT_POINTER] = index;
	Bintree_Add(YSI_g_sSearchTree, input, index, sizeof (YSI_g_sSearchTree));
}

/*----------------------------------------------------------------------------*-
Function:
	Text_ResetAll
Params:
	-
Return:
	-
Notes:
	Resets all the data, including trees.  Called from the language loader.
-*----------------------------------------------------------------------------*/

public Text_ResetAll()
{
	YSI_g_sTextInited = 0;
	YSI_g_sTextCount = 0;
	Bintree_Reset(YSI_g_sSearchTree);
	return 1;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_NewLanguage
Params:
	-
Return:
	-
Notes:
	Sets everything up to input a new language into the system (not hard tbh).
-*----------------------------------------------------------------------------*/

public Text_NewLanguage(Language:languageID)
{
	YSI_g_sBufferIndex = YSI_g_sLangBuffer[languageID];
	YSI_g_sBufferLang = languageID;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_Parse
Params:
	-
Return:
	-
Notes:
	This function sorts the data in the buffer (entered since Text_NewLanguage
	was last called), into the binary tree system.  The tree system is:
	
	Bintree:YSI_g_sSearchTree[MAX_TEXT][E_BINTREE_TREE]
	This contains the hashes of the text identifier for fast searching
	
	YSI_g_sNameTable[MAX_TEXT][E_TEXT_POINTERS]
	This is indexed by YSI_g_sSearchTree, it contains the textual identifier for
	collision checking and the pointers for all the languages
	
	YSI_g_sTextTable[MAX_LANGUAGES][MAX_TEXT][MAX_TEXT_ENTRY]
	This contains all the entries for each language in no particular order,
	they're saved as they're sent.  There are multiple indexes in YSI_g_sNameTable
	into this, depending on the language.
	
	All this is determined here.  If a language has been loaded already the
	existing binary tree is used and data inserted at read, otherwise it is
	generated here.
	
	This setup allows very fast and safe loading of text strings for display,
	flexibility in that adding new text and using it is very simple, text
	entries only exist once in the system, even identifiers, through careful
	data layout planning and means it is very simple to load languages after
	the first has been loaded and the tree generated.
-*----------------------------------------------------------------------------*/

public Text_Parse()
{
	if (!YSI_g_sTextInited)
	{
		new
			data[MAX_TEXT][E_BINTREE_INPUT];
		for (new i = 0; i < YSI_g_sBufferIndex; i++)
		{
			data[i][E_BINTREE_INPUT_VALUE] = bernstein(YSI_g_sNameTable[i][E_TEXT_POINTERS_NAME]);
			data[i][E_BINTREE_INPUT_POINTER] = i;
		}
		Bintree_Generate(YSI_g_sSearchTree, data, YSI_g_sBufferIndex);
		YSI_g_sTextInited = 1;
		YSI_g_sTextCount = YSI_g_sBufferIndex;
	}
	YSI_g_sLangBuffer[YSI_g_sBufferLang] = YSI_g_sBufferIndex;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_GetPlayerLanguage
Params:
	playerid
Return:
	Language:languageID
Notes:
	Wrapper for the possibly remote Langs_ function.
-*----------------------------------------------------------------------------*/

#if defined _YSI_CORE_PLAYER
	#define Text_GetPlayerLanguage(%1) \
		Player_GetPlayerLanguage((%1))
#else
	#define Text_GetPlayerLanguage(%1) \
		Language:Language_GetPlayerLanguage((%1))
#endif

/*----------------------------------------------------------------------------*-
Function:
	Text_GetText
Params:
	identifier[] - Teh string to find the text for.
	Language:languageID - The language to get the text for
Return:
	Text_GetTextFromIndex
Notes:
	This gives out stupid errors when implemented as a function despite the
	fact the compiler is obviously lying (there is only one return type, how
	can it possibly be inconsistent between array and non-array)!?
-*----------------------------------------------------------------------------*/

#define Text_GetText(%1,%2) \
	Text_GetTextFromIndex(Text_FindTextPointers((%1)), (%2), (%1))

/*----------------------------------------------------------------------------*-
Function:
	Text_GetPlayerText
Params:
	identifier[] - The string to find the text for.
	playerid - The player to get the language for.
Return:
	Text_GetText
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Text_GetPlayerText(%1,%2) \
	Text_GetText((%1), Text_GetPlayerLanguage((%2)))

/*----------------------------------------------------------------------------*-
Function:
	Text_GetTextFromIndex
Params:
	index - The pointer in the languages array of the text entry.
	Language:languageID - The language we want to get the text for.
	identifier[] - Requested string for error messages.
Return:
	text or error message.
Notes:
	This is where all the pointers are checked before being used, if any are
	wrong (i.e. invalid) an error message is returned, otherwise the required
	string is returned.
	
	Update:  If a person is not using the default language and a string does
	not exist in their language the default string will be shown and a server
	warning issued.
-*----------------------------------------------------------------------------*/

stock Text_GetTextFromIndex(index, Language:languageID, identifier[])
{
	new
		str[MAX_TEXT_ENTRY];
	if (index == TEXT_NO_POINTERS)
	{
		format(str, sizeof (str), Text_GetErrorMessage(languageID), identifier);
		DBGP1("*** Internal Error! Text %s not found", identifier);
		return str;
	}
	new
		pointer = YSI_g_sNameTable[index][E_TEXT_POINTERS_POINTER][languageID];
	if (pointer == TEXT_NO_TEXT)
	{
		if (languageID) pointer = YSI_g_sNameTable[index][E_TEXT_POINTERS_POINTER][Language:0];
		if (pointer == TEXT_NO_TEXT)
		{
			format(str, sizeof (str), Text_GetErrorMessage(languageID), identifier);
			DBGP1("*** Internal Error! Text %s not found", identifier);
			return str;
		}
		DBGP1("*** Internal Error! Text %s not found for language %d", identifier, _:languageID);
		languageID = Language:0;
	}
	return YSI_g_sTextTable[languageID][pointer];
}

/*----------------------------------------------------------------------------*-
Function:
	Text_GetErrorMessage
Params:
	Language:languageID - The language to get the error in.
	data[] - Requested string.
Return:
	-
Notes:
	If there's an error message defined by YSI_TEXT_NOT_FOUND that is returned,
	otherwise an internal error is thrown.
-*----------------------------------------------------------------------------*/

stock Text_GetErrorMessage(Language:languageID)
{
	static
		got,
		error,
		str[MAX_TEXT_ENTRY] = "*** Internal Error! No text or errors found for %s";
	if (!got)
	{
		error = Text_FindTextPointers("YSI_TEXT_NOT_FOUND");
		got = 1;
	}
	if (error != TEXT_NO_POINTERS)
	{
		new
			index;
		index = YSI_g_sNameTable[error][E_TEXT_POINTERS_POINTER][languageID];
		if (index != TEXT_NO_TEXT) return YSI_g_sTextTable[languageID][index];
		index = YSI_g_sNameTable[error][E_TEXT_POINTERS_POINTER][Language:0];
		if (index != TEXT_NO_TEXT) return YSI_g_sTextTable[Language:0][index];
	}
	return str;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_GetTextStyle
Params:
	index - Pointer to the text structure.
Return:
	File defined atyle.
Notes:
	-
-*----------------------------------------------------------------------------*/

stock Text_GetTextStyle(index)
{
	if (index == TEXT_NO_POINTERS) return 0;
	return YSI_g_sNameTable[index][E_TEXT_POINTERS_STYLE];
}

/*----------------------------------------------------------------------------*-
Function:
	Text_GetTextColour
Params:
	index - Pointer to the text structure.
Return:
	File defined colour.
Notes:
	Similar to Text_GetTextTime except in 0 return value.
-*----------------------------------------------------------------------------*/

stock Text_GetTextColour(index)
{
	if (index == TEXT_NO_POINTERS || !YSI_g_sNameTable[index][E_TEXT_POINTERS_APPEAR]) return 0xFF0000AA;
	return YSI_g_sNameTable[index][E_TEXT_POINTERS_APPEAR];
}

/*----------------------------------------------------------------------------*-
Function:
	Text_GetTextTime
Params:
	index - Pointer to the text structure.
Return:
	File defined colour.
Notes:
	Similar to Text_GetTextColour except in 0 return value.  There is no error
	checking here because if index is TEXT_NO_POINTERS Text_GetTextStlye will
	return 0 so this will never be called.
-*----------------------------------------------------------------------------*/

stock Text_GetTextTime(index)
{
	if (!YSI_g_sNameTable[index][E_TEXT_POINTERS_APPEAR]) return 10000;
	return YSI_g_sNameTable[index][E_TEXT_POINTERS_APPEAR];
}

/*----------------------------------------------------------------------------*-
Function:
	Text_Send
Params:
	playerid - Player to send message to.
	identifier[] - Identifier of text to send.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

stock Text_Send(playerid, identifier[])
{
	new
		pointer = Text_FindTextPointers(identifier),
		style = Text_GetTextStyle(pointer),
		str[MAX_TEXT_ENTRY];
	str = Text_GetTextFromIndex(pointer, Text_GetPlayerLanguage(playerid), identifier);
	if (!str[0]) return 0;
	if (style) return Text_Display(playerid, str, style, Text_GetTextTime(pointer));
	else return Text_Display(playerid, str, style, Text_GetTextColour(pointer));
}

/*----------------------------------------------------------------------------*-
Function:
	Text_SendToAll
Params:
	identifier[] - Identifier of text to send.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

stock Text_SendToAll(identifier[])
{
	new
		pointer = Text_FindTextPointers(identifier),
		style = Text_GetTextStyle(pointer),
		ret,
		str[MAX_LANGUAGES][MAX_TEXT_ENTRY];
	if (!style)
	{
		new
			colour = Text_GetTextColour(pointer);
		foreach (Player, playerid)
		{
			new
				Language:pl = Text_GetPlayerLanguage(playerid);
			if (!str[pl][0]) str[pl] = Text_GetTextFromIndex(pointer, pl, identifier);
			if (!str[pl][0]) continue;
			if (SendClientMessage(playerid, colour, str[pl]))
			{
				ret = 1;
			}
		}
	}
	else if (style < 0)
	{
		new
			Text:td[MAX_LANGUAGES],
			Style:tdStyle = TD_GetID(Text_GetTextColour(pointer));
		for (new i = 0; i < MAX_LANGUAGES; i++)
		{
			td[i] = Text:INVALID_TEXT_DRAW;
		}
		if (tdStyle != MAX_TEXT_DRAW_STYLES)
		{
			foreach (Player, playerid)
			{
				new
					Language:pl = Text_GetPlayerLanguage(playerid);
				if (td[pl] == Text:INVALID_TEXT_DRAW)
				{
					if (!str[pl][0]) str[pl] = Text_GetTextFromIndex(pointer, pl, identifier);
					if (!str[pl][0]) continue;
					td[pl] = TD_Display(str[pl], tdStyle);
					if (td[pl] != Text:INVALID_TEXT_DRAW)
					{
						ret = 1;
					}
				}
				TD_ShowForPlayer(playerid, td[pl]);
				TD_Garbage(td[pl]);
			}
		}
	}
	else
	{
		new
			time = Text_GetTextTime(pointer);
		foreach (Player, playerid)
		{
			new
				Language:pl = Text_GetPlayerLanguage(playerid);
			if (!str[pl][0]) str[pl] = Text_GetTextFromIndex(pointer, pl, identifier);
			if (!str[pl][0]) continue;
			if (GameTextForPlayer(playerid, str[pl], time, style))
			{
				ret = 1;
			}
		}
	}
	return ret;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_SendToGroup
Params:
	group - Group to send to.
	identifier[] - Identifier of text to send.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

stock Text_SendToGroup(group, identifier[])
{
	new
		Bit:players[PLAYER_BIT_ARRAY] = Group_GetGroupMembers(group);
	return Text_SendToPlayers(players, identifier);
}

/*----------------------------------------------------------------------------*-
Function:
	Text_SendToPlayers
Params:
	Bit:players[] - Bit array of players to send to.
	identifier[] - Identifier of text to send.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

stock Text_SendToPlayers(Bit:players[], identifier[])
{
	new
		pointer = Text_FindTextPointers(identifier),
		style = Text_GetTextStyle(pointer),
		ret,
		str[MAX_LANGUAGES][MAX_TEXT_ENTRY];
	if (!style)
	{
		foreach (Player, playerid)
		{
			if (Bit_GetBit(players, playerid))
			{
				new
					Language:pl = Text_GetPlayerLanguage(playerid);
				if (!str[pl][0]) str[pl] = Text_GetTextFromIndex(pointer, pl, identifier);
				if (!str[pl][0]) continue;
				if (SendClientMessage(playerid, Text_GetTextColour(pointer), str[pl]))
				{
					ret = 1;
				}
			}
		}
	}
	else if (style < 0)
	{
		new
			Text:td[MAX_LANGUAGES] = {Text:INVALID_TEXT_DRAW, ...},
			Style:tdStyle = TD_GetID(Text_GetTextColour(pointer));
		if (tdStyle != MAX_TEXT_DRAW_STYLES)
		{
			foreach (Player, playerid)
			{
				if (Bit_GetBit(players, playerid))
				{
					new
						Language:pl = Text_GetPlayerLanguage(playerid);
					if (td[pl] == Text:INVALID_TEXT_DRAW)
					{
						if (!str[pl][0]) str[pl] = Text_GetTextFromIndex(pointer, pl, identifier);
						if (!str[pl][0]) continue;
						td[pl] = TD_Display(str[pl], tdStyle);
						if (td[pl] != Text:INVALID_TEXT_DRAW)
						{
							ret = 1;
						}
					}
					TD_ShowForPlayer(playerid, td[pl]);
					TD_Garbage(td[pl]);
				}
			}
		}
	}
	else
	{
		foreach (Player, playerid)
		{
			if (Bit_GetBit(players, playerid))
			{
				new
					Language:pl = Text_GetPlayerLanguage(playerid);
				if (!str[pl][0]) str[pl] = Text_GetTextFromIndex(pointer, pl, identifier);
				if (!str[pl][0]) continue;
				if (GameTextForPlayer(playerid, str[pl], Text_GetTextTime(pointer), style))
				{
					ret = 1;
				}
			}
		}
	}
	return ret;
}

/*----------------------------------------------------------------------------*-
Function:
	Text_SendFormat
Params:
	playerid - Player to send message to.
	identifier[] - Identifier of text to send.
	{Float,_}:...
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Text_SendFormat(%1,%2,%3) \
	do \
	{ \
		new \
			Bit:Text_SendFormatBitArray[PLAYER_BIT_ARRAY]; \
		Bit_Set(Text_SendFormatBitArray, (%1), 1, sizeof (Text_SendFormatBitArray)); \
		Format_SendFormattedText(Text_SendFormatBitArray, (%2), %3); \
	} \
	while (FALSE)

/*----------------------------------------------------------------------------*-
Function:
	Text_SendToAllFormat
Params:
	identifier[] - Identifier of text to send.
	{Float,_}:...
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Text_SendToAllFormat(%1,%2) \
	Format_SendFormattedText(Group_GetGroupMembers(-1), (%1), %2)

/*----------------------------------------------------------------------------*-
Function:
	Text_SendToGroupFormat
Params:
	group - Group to send to.
	identifier[] - Identifier of text to send.
	{Float,_}:...
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Text_SendToGroupFormat(%1,%2,%3) \
	Format_SendFormattedText(Group_GetGroupMembers((%1)), (%2), %3)

/*----------------------------------------------------------------------------*-
Function:
	Text_SendToPlayersFormat
Params:
	Bit:players[] - Bit array of players to send to.
	identifier[] - Identifier of text to send.
	{Float,_}:...
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Text_SendToPlayersFormat(%1,%2,%3) \
	Format_SendFormattedText((%1), (%2), %3)

/*----------------------------------------------------------------------------*-
Function:
	Text_Display
Params:
	playerid - Player to display text to.
	text[] - Text to display.
	style - How to display the text.
	format - Specific style information.
Return:
	-
Notes:
	Takes a real string, not an identifier.
-*----------------------------------------------------------------------------*/

stock Text_Display(playerid, text[], style, format)
{
	if (style < 0)
	{
		new
			Text:textDraw = TD_DisplayHashed(text, format);
		TD_ShowForPlayer(playerid, textDraw);
		TD_Garbage(textDraw);
		return _:textDraw;
	}
	else if (style)
	{
		return GameTextForPlayer(playerid, text, format, style);
	}
	else
	{
		return SendClientMessage(playerid, format, text);
	}
}
