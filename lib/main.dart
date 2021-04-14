import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teknik Kompresi',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _inputController = TextEditingController();
  String _result = '';

  String get _input => _inputController.text;

  @override
  void dispose() {
    super.dispose();
    _inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.teal,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Scaffold(
            body: ListView(
              children: [
                Container(
                  height: (MediaQuery.of(context).orientation ==
                          Orientation.landscape)
                      ? sy(100)
                      : sy(120),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: sy(10)),
                      Text(
                        'Teknik Kompresi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        'Fikky Ardianto',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '201851136',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Kelas G',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: sy(10)),
                    ],
                  ),
                ),
                SizedBox(height: sy(20)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      labelText: 'Masukan Text',
                      hintText: 'Masukan Text ...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(height: sy(10)),
                Container(
                  height: sy(35),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    child: Text('Kompress Text'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    onPressed: () {
                      setState(() => _result = encode(_input));
                      Get.defaultDialog(
                        title: 'Hasil Kompresi',
                        content: Text(_result, style: TextStyle(fontSize: 22)),
                        confirm: MaterialButton(
                          onPressed: () => Get.back(),
                          child: Text('Ok'),
                        ),
                        cancel: MaterialButton(
                          child: Text('Reset'),
                          onPressed: () {
                            _inputController.clear();
                            Get.back();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String encode(String message) {
    final Map frequencies = count(message);
    final sorted = frequencies.values.toList()..sort();
    return sorted.toString();
  }

  Map<String, dynamic> count(String message) {
    Map<String, dynamic> freq = {};

    final characters = message.split('');

    for (String character in characters) {
      freq[character] = freq[character] != null ? freq[character] + 1 : 1;
    }

    return freq;
  }
}
