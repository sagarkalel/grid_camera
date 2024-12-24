import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grid_camera/grid_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Camera Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grid Camera Demo")),
      body: GridCameraWidget(
        onDonePressed: (Uint8List gridImage) {
          // TODO: do something with captured gridImage, e.g Save/Download/Share
          log(gridImage.toString());
        },
        rowCount: 10,
        columnCount: 10,
        gridWidth: 0.5,
        aspectRatio: 1 / 1,
      ),
    );
  }
}
