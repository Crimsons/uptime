#include "uptime_tizen_plugin.h"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <string>

#include <sys/sysinfo.h>

namespace {

class UptimeTizenPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrar *registrar) {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "uptime",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<UptimeTizenPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result) {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  UptimeTizenPlugin() {}

  virtual ~UptimeTizenPlugin() {}

 private:
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
      const auto& method_name = method_call.method_name();

      auto readUptime = []() -> int64_t{
        struct sysinfo s_info;
        int error = sysinfo(&s_info);
        if(!error) {
          return static_cast<int64_t>(s_info.uptime)*1000;
        }
        return -1;
      };

      if (method_name == "getUptime") {
        int64_t res=readUptime();
        if (res>=0) {
          result->Success(flutter::EncodableValue(res));
        } else {
          result->Error("Failed to get uptime.");
        }
      } else {
        result->NotImplemented();
      }
  }
};

}  // namespace

void UptimeTizenPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  UptimeTizenPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrar>(registrar));
}
