import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_picker/display_page.dart';
import 'package:parse_picker/save_page.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = '9YahmBGpxwJDeFwzw0ka3gwfQuObr8jG05U6VUVD';
  const keyClientKey = 'YaoYnpwms7ExuFW8AgIvNBsMVb9hQkmw1V34Deyk';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PickedFile? pickedFile;

  List<ParseObject> results = <ParseObject>[];
  double selectedDistance = 3000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parse Image Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: Image.network(
                  'https://blog.back4app.com/wp-content/uploads/2017/11/logo-b4a-1-768x175-1.png'),
            ),
            const SizedBox(
              height: 16,
            ),
            const Center(
              child: Text('Flutter on Back4app Save File',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SavePage()),
                  );
                },
                child: const Text('Upload File'),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DisplayPage()),
                  );
                },
                child: const Text('Display File'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
