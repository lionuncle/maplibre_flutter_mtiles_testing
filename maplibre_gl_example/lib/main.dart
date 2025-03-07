// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:maplibre_gl_example/services/navigation_service.dart';
import 'utils/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await copyAssetToLocalStorage();
  runApp(const MaterialApp(home: MapsDemo()));
}

class MapsDemo extends StatefulWidget {
  const MapsDemo({super.key});

  @override
  State<MapsDemo> createState() => _MapsDemoState();
}

class _MapsDemoState extends State<MapsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapLibre examples')),
      body: ListView.builder(
        itemCount: allPages.length + 1,
        itemBuilder: (_, int index) => index == allPages.length
            ? const AboutListTile(
                applicationName: "flutter-maplibre-gl example",
              )
            : ListTile(
                leading: allPages[index].leading,
                title: Text(allPages[index].title),
                onTap: () =>
                    NavigationService.pushPage(context, allPages[index]),
              ),
      ),
    );
  }
}
