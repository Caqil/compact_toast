#include "include/compact_toast/compact_toast_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "compact_toast_plugin.h"

void CompactToastPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  compact_toast::CompactToastPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
