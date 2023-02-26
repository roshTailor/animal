import 'dart:io';
import 'package:animals/details.dart';
import 'package:animals/global.dart';
import 'package:animals/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'homepage.dart';
import 'list.dart';

Future<void> copyDatabase() async {
  // Get the directory for storing the database file
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'database.db');

  // Check if the database file already exists
  bool fileExists = await databaseExists(path);

  if (!fileExists) {
    // If the file doesn't exist, copy it from the assets folder
    ByteData data = await rootBundle.load(join('assets/database/Animals.db'));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await copyDatabase();
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'database.db');
  Database database = await openDatabase(path);

  list = await database.rawQuery('SELECT * FROM Animals');
  list.toList().toSet();
  for (var row in list) {
    // print(row);
  }
  runApp(
     MaterialApp(
       debugShowCheckedModeBanner: false,
       initialRoute: '/',
      routes: {
         '/':(context) => const SplashScreen(),
        'HomePage': (context) => const HomePage(),
        'List': (context) => const ListPage(),
        'Details': (context) => const Details(),
      },
    ),
  );
}
