import 'dart:math';
import 'package:morse/morse.dart';

String getMorse(String input){
  final Morse morse = new Morse(input);
  return morse.encode();
}

String getOriginal(String morseStr){
  final Morse morse = new Morse(morseStr);

  return morse.decode();
}

class Encryptor{
  String input;
  Random random = new Random();

  Encryptor({this.input});

  // Encryptor(String inputString){
  //   this.input = inputString;
  // }

  // The assignment below to be replaced with an API Call.


  String encryptMorse(){
    String newString = '';

    String morseString = getMorse(input);

    //String alphabet_list = "abcdefghijklmnopqrstuvwxyz";
    String alphabet_list = "😀😁😂🤣😃😄😅😆😉😊😋😎😍😘🥰😗😙😚☺🙂🤗🤩🤔🤨😐😑";
    String dotChars = String.fromCharCodes(alphabet_list.runes, 0, 6);
    String hyphenChars = String.fromCharCodes(alphabet_list.runes, 6, 12);
    String spaceChars = String.fromCharCodes(alphabet_list.runes, 12, 19);
    String slashChars = String.fromCharCodes(alphabet_list.runes, 19, 26);

    for (int x = 0; x < morseString.length; x++){
      if (morseString[x] == '.'){
        //newString = newString + dotChars[random.nextInt(6)];
        int temp = random.nextInt(6);
        newString = newString + String.fromCharCodes(dotChars.runes, temp, temp + 1);
      }

      else if (morseString[x] == '-'){
        int temp = random.nextInt(6);
        newString = newString + String.fromCharCodes(hyphenChars.runes, temp, temp + 1);
      }

      else if (morseString[x] == ' '){
        int temp = random.nextInt(7);
        newString = newString + String.fromCharCodes(spaceChars.runes, temp, temp + 1);
      }

      else if (morseString[x] == '/'){
        int temp = random.nextInt(7);
        newString = newString + String.fromCharCodes(slashChars.runes, temp, temp + 1);
      }
    }
    return newString;
  }

  String decrypt_custom(){
    String new_string = "";
    //String alphabet_list = "abcdefghijklmnopqrstuvwxyz";
    String alphabet_list = "😀😁😂🤣😃😄😅😆😉😊😋😎😍😘🥰😗😙😚☺🙂🤗🤩🤔🤨😐😑";
    String DOT_CHARS = String.fromCharCodes(alphabet_list.runes, 0, 6);
    String HYPHEN_CHARS = String.fromCharCodes(alphabet_list.runes, 6, 12);
    String SPACE_CHARS = String.fromCharCodes(alphabet_list.runes, 12, 19);
    String SLASH_CHARS = String.fromCharCodes(alphabet_list.runes, 19, 26);

    var r = new Random();

    for(int i = 0; i<input.runes.length; i++){
      if ((DOT_CHARS).contains(String.fromCharCodes(input.runes, i, i + 1))){
        new_string += '.';
      }
      else if ((HYPHEN_CHARS).contains(String.fromCharCodes(input.runes, i, i + 1))){
        new_string += '-';
      }
      else if ((SPACE_CHARS).contains(String.fromCharCodes(input.runes, i, i + 1))){
        new_string += ' ';
      }
      else if ((SLASH_CHARS).contains(String.fromCharCodes(input.runes, i, i + 1))){
        new_string += '/';
      }
    }

    //return decoded morse
    new_string = getOriginal(new_string);
    return new_string;
  }
}
