import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  PickedFile? pickedFile;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Fie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              child: pickedFile != null
                  ? Container(
                      width: 250,
                      height: 250,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      child: kIsWeb
                          ? Image.network(pickedFile!.path)
                          : Image.file(File(pickedFile!.path)))
                  : Container(
                      width: 250,
                      height: 250,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      child: const Center(
                        child: Text('Click here to pick image from Gallery'),
                      ),
                    ),
              onTap: () async {
                PickedFile? image =
                    await ImagePicker().getImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    pickedFile = image;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: isLoading || pickedFile == null
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        ParseFileBase? parseFile;

                        if (kIsWeb) {
                          //Flutter Web
                          parseFile = ParseWebFile(
                              await pickedFile!.readAsBytes(),
                              name: 'image.jpg'); //Name for file is required
                        } else {
                          //Flutter Mobile/Desktop
                          parseFile = ParseFile(File(pickedFile!.path));
                        }
                        await parseFile.save();
                        // Here Database
                        final gallery = ParseObject('MyGallery')
                          ..set('Banners', parseFile);
                        await gallery.save();

                        setState(
                          () {
                            isLoading = false;
                            pickedFile = null;
                          },
                        );

                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Save file with success on Back4app',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.blue,
                            ),
                          );
                      },
                child: const Text('Upload file'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
