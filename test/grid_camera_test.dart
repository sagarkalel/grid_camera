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
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? imageInBytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Grid Camera Demo",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(24),
            Container(
              height: MediaQuery.of(context).size.width * .8,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                image: imageInBytes == null
                    ? null
                    : DecorationImage(image: MemoryImage(imageInBytes!)),
              ),
              alignment: Alignment.center,
              child: imageInBytes != null
                  ? IconButton.outlined(
                      onPressed: () {
                        imageInBytes = null;
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete_forever, size: 48),
                    )
                  : IconButton.outlined(
                      onPressed: () async {
                        final img = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraPage()),
                        );
                        if (img == null) return;
                        imageInBytes = img;
                        setState(() {});
                      },
                      icon: const Icon(Icons.upload, size: 48),
                    ),
            ),
            const Gap(kToolbarHeight),
          ],
        ).padXXDefault,
      ),
    );
  }
}

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridCameraWidget(
      onDonePressed: (Uint8List img) => Navigator.pop(context, img),
      rowCount: 10,
      columnCount: 10,
      gridWidth: 0.5,
      aspectRatio: 1 / 1,
    );
  }
}
