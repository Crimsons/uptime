package com.jakobhoyer.uptime

import UptimeProvider
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class UptimePlugin : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "uptime")
            channel.setMethodCallHandler(UptimePlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getUptime") {
            getUptime(result)
        } else {
            result.notImplemented()
        }
    }

    private fun getUptime(result: Result) {
        result.success(UptimeProvider.uptime)
    }
}
