import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:view_channel/native/native_view.dart';
import 'package:view_channel/native/native_view_controller.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const _kHello = 'Hello, i am flutter.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native View with channel'),
      ),
      body: Column(
        children: [
          const Flexible(
            child: NativeViewWidget(),
          ),
          Flexible(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      'Receive from native: ${ref.watch(nativeMessageProvider)}'),
                  const Text('Send to native: $_kHello'),
                  ElevatedButton(
                    onPressed: () {
                      // TODO 使用 [NativeViewController] 发送数据
                    },
                    child: const Text('Send'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
