package com.example.view_channel

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    companion object {
        private const val VIEW_TYPE_NATIVE = "walker.demo/native_view"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(VIEW_TYPE_NATIVE, NativeViewFactory(flutterEngine.dartExecutor.binaryMessenger))
    }
}
