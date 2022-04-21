package com.example.view_channel

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * 原生View组件工厂
 *
 * Author: walker
 * Email: zhaocework@gmail.com
 * Date: 2022/4/21
 */
class NativeViewFactory(
    private val messenger: BinaryMessenger
): PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    @Suppress("UNCHECKED_CAST")
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return NativeView(context, viewId, messenger, args as? Map<String, Any?>?)
    }
}