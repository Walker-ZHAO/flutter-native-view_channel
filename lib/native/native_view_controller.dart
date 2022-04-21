import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// 负责与原生View通信的控制器
///
/// Author: walker
/// Email: zhaocework@gmail.com
/// Date: 2022/4/20
class NativeViewController {
  static const _kChannelNamePrefix = "walker.flutter.view_channel";
  static const _kMethodSendToNative = "sendToNative";
  static const _kMethodReceiveFromNative = "receiveFromNative";
  static const _kParamMessage = "message";

  // 负责通信的通道
  late final MethodChannel _methodChannel;
  // 接收消息后更新Provider
  final Reader _reader;

  NativeViewController(int viewId, this._reader) {
    _methodChannel = MethodChannel('$_kChannelNamePrefix/$viewId');
    _methodChannel.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case _kMethodReceiveFromNative:
        // 读取参数后，更新Provider
        final message =
            (call.arguments as Map<dynamic, dynamic>)[_kParamMessage];
        _reader(nativeMessageProvider.notifier).state = message;
        return Future.value(0);
    }
  }

  Future<void> sendToNative(String text) async {
    try {
      final result = await _methodChannel
          .invokeMethod(_kMethodSendToNative, {_kParamMessage: text});
      if (kDebugMode) {
        print('Result for sendToNative: $result');
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } on MissingPluginException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

// 从平台端发送来的消息
final nativeMessageProvider = StateProvider<String>((ref) {
  return "";
});

// 根据原生View的构建ID，创建控制类示例，确保与指定的原生View通讯
final nativeViewControllerFamily =
    StateProvider.autoDispose.family<NativeViewController, int>((ref, id) {
  return NativeViewController(id, ref.read);
});
