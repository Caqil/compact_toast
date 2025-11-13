#ifndef FLUTTER_PLUGIN_COMPACT_TOAST_PLUGIN_H_
#define FLUTTER_PLUGIN_COMPACT_TOAST_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace compact_toast {

class CompactToastPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CompactToastPlugin();

  virtual ~CompactToastPlugin();

  // Disallow copy and assign.
  CompactToastPlugin(const CompactToastPlugin&) = delete;
  CompactToastPlugin& operator=(const CompactToastPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace compact_toast

#endif  // FLUTTER_PLUGIN_COMPACT_TOAST_PLUGIN_H_
