import 'package:chatbotgpt/presentation/uploadfile/provider/csv_provider.dart';
import 'package:chatbotgpt/presentation/uploadfile/ui/fileuploadscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DataShow',
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FileUploadProvider()),
      ],
      child: const MyApp(),
    ),
  ));

  // const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Fileuploadscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
