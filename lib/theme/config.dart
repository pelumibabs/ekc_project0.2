
import 'package:flutter/foundation.dart';

/// Api config
bool myUseSample = false;
bool myCleanConfig = false;
const kStreamApiKey = 'ah48ckptkjvm';

// Demo
// const kStreamApiKey = 'wr4g7gb2388g';
// const kStreamUserId = 'tom';
// const kStreamToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoidG9tIn0._HkDWmGM3ItRXTLn9-s7N_8XBew_DxHBBH9eDHjRtP4';

/// App config (cp)
int cpAgeFilter = 3; // +-3, so 17 will meet 14 - 20.
bool cpIsLoading = false; // setState to hide

/// Design (c)onfig
bool cShowTabBarTitles = false; // in Use - AppBar
bool cMinimizeIndicator = true; // in Use - AppBar
bool cShowChatsSearch = true; // Not embedded yet
bool cShowGroups = true; // Not embedded yet
bool cShowAgeAndPostLen = false;

/// Dev (debug)
bool devLogin = true; // auto set gender & bDay when סיום button clicked
bool showDebugPrints = true;
bool genderDebug = true; // false: fake New user mode.
bool cleanOnExitDebug = true; // true: exit button will erase user extraData
bool alwaysNewUserDebug = false && kDebugMode;

// ? CTRL + F: Outside Lib folder:
// ? var homeCooldown = 2 * 60;
// ? bool quickerSlowModeDebug = true; // true: x15 faster

