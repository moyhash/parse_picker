import 'package:flutter/material.dart';
import 'package:parse_picker/function.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display Gallery"),
      ),
      body: FutureBuilder<List<ParseObject>>(
        future: getGalleryList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator()),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error..."),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    //Web/Mobile/Desktop
                    ParseFileBase? varFile =
                        snapshot.data![index].get<ParseFileBase>('file');

                    //Only iOS/Android/Desktop
                    /*
                        ParseFile? varFile =
                            snapshot.data![index].get<ParseFile>('file');
                        */
                    return Image.network(
                      varFile!.url!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fitHeight,
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
