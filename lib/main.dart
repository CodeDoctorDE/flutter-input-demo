import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Input Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PointerEvent? _lastEvent;

  void _setOutput(PointerEvent event) => setState(() {
        _lastEvent = event;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          _lastEvent == null
              ? const Center(
                  child: Text("Not recognized",
                      style: TextStyle(fontSize: 20, color: Colors.grey)))
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Event: ${_lastEvent!.runtimeType}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(height: 32),
                            _buildInfoRow("Kind", _lastEvent!.kind.name),
                            _buildInfoRow(
                                "Pointer ID", _lastEvent!.pointer.toString()),
                            _buildInfoRow("Position",
                                "(${_lastEvent!.position.dx.toStringAsFixed(1)}, ${_lastEvent!.position.dy.toStringAsFixed(1)})"),
                            _buildInfoRow("Pressure",
                                "${_lastEvent!.pressure.toStringAsFixed(2)} (Min: ${_lastEvent!.pressureMin.toStringAsFixed(2)} / Max: ${_lastEvent!.pressureMax.toStringAsFixed(2)})"),
                            _buildInfoRow("Orientation",
                                _lastEvent!.orientation.toStringAsFixed(2)),
                            _buildInfoRow("Buttons value",
                                _lastEvent!.buttons.toString()),
                            _buildInfoRow("Button bitmap",
                                "0b${_lastEvent!.buttons.toRadixString(2).padLeft(8, '0')}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          Listener(
            onPointerDown: _setOutput,
            onPointerMove: _setOutput,
            onPointerUp: _setOutput,
            onPointerCancel: _setOutput,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}
