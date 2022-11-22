package com.verz.eqinsurance

import android.util.Base64
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        //demoMethodChannel1(flutterEngine)
        //MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "demo").setMethodCallHandler {
               // call, result ->
//            when (call.method) {
//                "getFlavor" -> {
//                    val apiUsername = call.argument<String>("apiUsername")
//                    val token = call.argument<String>("token")
//                    val apiKey = call.argument<String>("apiKey")
//                    val resultData : String = encryptData(apiUsername, token, apiKey)
//                    result.success(resultData)
//                }
//                else -> result.notImplemented()
//            }

            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "demo").setMethodCallHandler {
                // 3
                    call, result ->
                when (call.method) {
                    "getFlavor" -> {
                        val apiUsername = call.argument<String>("apiUsername")
                        val token = call.argument<String>("token")
                        val apiKey = call.argument<String>("apiKey")
                        val resultData : String = encryptData(apiUsername, token, apiKey)
                        result.success(resultData)
                    }
                    else -> result.notImplemented()
                }
            }
      // }
    }

    private fun encryptData(apiUsername: String?, token: String?, apiKey: String?): String {
        val iv = byteArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

        return Base64.encodeToString(
            Encryption.encrypt(("$apiUsername|$token").toByteArray(), apiKey.toString(), iv), Base64.DEFAULT
        );
    }

}
