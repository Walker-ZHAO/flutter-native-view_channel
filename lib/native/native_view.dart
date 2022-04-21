import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

///
/// 原生视图包装组件
///
/// Author: walker
/// Email: zhaocework@gmail.com
/// Date: 2022/4/20

typedef NativeViewCreatedCallback = void Function(int id);

class NativeViewWidget extends StatelessWidget {
  static const _kTypeNativeView = 'walker.demo/native_view';

  final NativeViewCreatedCallback? onNativeViewCreated;

  const NativeViewWidget({Key? key, this.onNativeViewCreated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _buildAndroidPlatformView();
      case TargetPlatform.iOS:
        return _buildIOSPlatformView();
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  Widget _buildAndroidPlatformView({Map<String, dynamic>? creationParams}) {
    return PlatformViewLink(
      viewType: _kTypeNativeView,
      surfaceFactory:
          (BuildContext context, PlatformViewController controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: _kTypeNativeView,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
          ..addOnPlatformViewCreatedListener((id) {
            _onPlatformViewCreated(id);
            params.onPlatformViewCreated(id);
          })
          ..create();
      },
    );
  }

  Widget _buildIOSPlatformView({Map<String, dynamic>? creationParams}) {
    return UiKitView(
      viewType: _kTypeNativeView,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (id) {
        _onPlatformViewCreated(id);
      },
    );
  }

  void _onPlatformViewCreated(int id) {
    if (onNativeViewCreated == null) return;
    onNativeViewCreated!(id);
  }
}
