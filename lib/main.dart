import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morse/morse.dart';
import 'Encryptor.dart';


void main() {
  runApp(MaterialApp(
      home: MyApp()),
  );
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}


GlobalKey<FormState> _key = GlobalKey<FormState>();


class _MyAppState extends State<MyApp> {
  String invalidInput = '';
  String invalidInput1 = '';
  String original_msg = '';
  String original_msg1 = '';
  String encrypted_msg = '';
  String decrypted_msg = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('MorseMoji',
            style: TextStyle(
                color: Colors.amber
            )
        ),
        elevation: 50,
        shadowColor: Colors.amber,
        centerTitle: true,
        backgroundColor: Colors.black,

      ),
      body: Form(
          key: _key,

          child: Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Encryptor',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 5,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      //key: _key1,

                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          hintText: 'Hello there',
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
                          labelText: 'Enter Message to Encrypt',
                          labelStyle: TextStyle(
                            color: Colors.amber,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      onSaved: (String input){
                          original_msg = input;
                      },
                    ),
                    Text(invalidInput,
                      style: TextStyle(
                        color: Colors.red,
                      )
                    ),
                    RaisedButton(
                      child: Text('Encrypt'),
                      onPressed: (){
                        setState(() {
                          _key.currentState.save();

                          bool invalid = false;
                          if(original_msg.isEmpty){
                            invalidInput = 'Input is empty';
                            invalid = true;
                          }
                          for(int i=0; i<original_msg.length && invalid == false; ++i){
                            if('*#~`|•π√÷×¶∆}{°^¥€¢£%©®™✓[]'.contains(original_msg[i])){
                              invalidInput = 'Invalid character in input';
                              invalid = true;
                            }
                          }
                          if(invalid == false) {
                            invalidInput = '';
                            Encryptor e = new Encryptor(input: original_msg);
                            encrypted_msg = e.encryptMorse();
                            Clipboard.setData(ClipboardData(text: encrypted_msg));
                            _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(
                                    content: new Text('Copied to clipboard')
                                )
                            );
                          }
                        });

                      },
                    ),
                    SizedBox(height: 20,),
                    Text('Encrypted Text:',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SelectableText(encrypted_msg,
                        style: TextStyle(
                          fontSize: 30,
                        )
                    ),
                    SizedBox(height: 30,),
                    Text('Decryptor',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 5,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextFormField(
                      //key: _key2,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          hintText: 'zxrtykjhsz',
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
                          labelText: 'Enter Encrypted Message',
                          labelStyle: TextStyle(
                            color: Colors.amber,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      onSaved: (String input){
                        setState(() {
                          original_msg1 = input;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Text(invalidInput1,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    RaisedButton(
                      child: Text('Decrypt'),
                      onPressed: (){
                        setState(() {
                          _key.currentState.save();
                          bool invalid = false;
                          if(original_msg1.isEmpty){
                            invalidInput1 = 'Input is empty';
                            invalid = true;
                          }
                          for(int i =0; i<original_msg1.runes.length && invalid == false; ++i){
                            if("😀😁😂🤣😃😄😅😆😉😊😋😎😍😘🥰😗😙😚☺🙂🤗🤩🤔🤨😐😑".contains(String.fromCharCodes(original_msg1.runes, i, i + 1))){
                              continue;
                            } else{
                              invalidInput1 = 'Input contains invalid characters/emojies';
                              invalid = true;
                            }
                          }
                          if(invalid == false){
                            invalidInput1 = '';
                            Encryptor e = new Encryptor(input: original_msg1);
                            decrypted_msg = e.decrypt_custom();
                            Clipboard.setData(ClipboardData(text: decrypted_msg));
                            _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(
                                    content: new Text('Copied to clipboard')
                                )
                            );
                          }
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Text('Decrypted Text:',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SelectableText(decrypted_msg,
                        style: TextStyle(
                          fontSize: 30,
                        )
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}
