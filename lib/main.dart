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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const _kHello = 'Hello, i am flutter.';

  @override
  ConsumerState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  int? viewId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native View with channel'),
      ),
      body: Column(
        children: [
          Flexible(
            child: NativeViewWidget(
              onNativeViewCreated: (id) {
                viewId = id;
                // 原生View创建完毕后，立刻构造Controller，实现数据通信
                ref.read(nativeViewControllerFamily(id));
              },
            ),
          ),
          Flexible(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      'Receive from native: ${ref.watch(nativeMessageProvider)}'),
                  const Text('Send to native: ${MyHomePage._kHello}'),
                  ElevatedButton(
                    onPressed: () {
                      final id = viewId;
                      if (id == null) return;
                      ref
                          .read(nativeViewControllerFamily(id))
                          .sendToNative(MyHomePage._kHello);
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
