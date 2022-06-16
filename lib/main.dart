import 'package:flutter/material.dart' hide Key;
import 'package:encrypt/encrypt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EncryptionDecryption(),
    );
  }
}

class EncryptionDecryption extends StatefulWidget {
  //const EncryptionDecryption({Key? key}) : super(key: key);

  @override
  _EncryptionDecryptionState createState() => _EncryptionDecryptionState();
}

class _EncryptionDecryptionState extends State<EncryptionDecryption> {
  TextEditingController Encrptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: Encrptioncontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter message',
                  hintText: 'Enter message'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Encrypt();
                    },
                    child: Text('Encrypt')),
                ElevatedButton(
                    onPressed: () {
                      Decrypt();
                    },
                    child: Text('Decrypt')),
              ],
            ),
            SizedBox(height: 20),
            Text('Encrypt Text:'),
            SizedBox(height: 20),
            Text('Decrypted Text'),
          ],
        ),
      ),
    );
  }

  void Encrypt() async {
    final key = Key.fromSecureRandom(32);
    final iv = IV.fromSecureRandom(8);
    final encrypter = Encrypter(Salsa20(key));
    final encrypted = encrypter.encrypt(Encrptioncontroller.text, iv: iv);
    print(encrypted);
  }

  void Decrypt() async {
    final key = Key.fromSecureRandom(32);
    final iv = IV.fromSecureRandom(8);
    final encrypter = Encrypter(Salsa20(key));

    final encrypted = encrypter.encrypt(Encrptioncontroller.text, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    print(decrypted);
  }
}