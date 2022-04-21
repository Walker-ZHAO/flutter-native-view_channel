package com.example.view_channel

import android.content.Context
import android.util.Log
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

/**
 * 原生View组件包装
 *
 * Author: walker
 * Email: zhaocework@gmail.com
 * Date: 2022/4/21
 */
class NativeView(
    context: Context,
    id: Int,
    messenger: BinaryMessenger,
    creationParams: Map<String, Any?>?
): PlatformView, MethodChannel.MethodCallHandler {

    companion object {
        const val TAG = "NativeView"
        const val CHANNEL_NAME_PREFIX = "walker.flutter.view_channel"
        const val METHOD_NAME_SendToNative = "sendToNative"
        const val METHOD_NAME_ReceiveFromNative = "receiveFromNative"
        const val METHOD_PARAM_MESSAGE = "message"
    }

    private val magicView = MagicView(context)
    private val methodChannel = MethodChannel(messenger, "$CHANNEL_NAME_PREFIX/$id")

    init {
        methodChannel.setMethodCallHandler(this)
        magicView.onSendButtonClick = ::sendMessage
    }

    override fun getView(): View {
        return magicView
    }

    override fun dispose() { }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            METHOD_NAME_SendToNative -> {
                val message = call.argument<String>(METHOD_PARAM_MESSAGE) ?: ""
                magicView.receiveMessage(message)
                result.success(0)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun sendMessage(message: String) {
        methodChannel.invokeMethod(
            METHOD_NAME_ReceiveFromNative,
            mapOf(METHOD_PARAM_MESSAGE to message),
            object :MethodChannel.Result {
                override fun success(result: Any?) {
                    Log.i(TAG, "send to flutter success: $result")
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                    Log.e(TAG, "send to flutter failed: $errorCode, $errorMessage")
                }

                override fun notImplemented() {
                    Log.e(TAG, "send to flutter failed: no valid method")
                }
            }
        )
    }
}