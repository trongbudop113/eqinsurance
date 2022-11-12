import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart';
import 'package:eqinsurance/configs/test.dart';
import 'package:pointycastle/export.dart';
class EncryptionData{

  static dynamic encryptData(String value, String keyAPi){
    try
    {
      // //Get Cipher Instance
      // Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
      // //Create SecretKeySpec
      // SecretKeySpec keySpec = new SecretKeySpec(getSHA(key), "AES");
      // //Create IvParameterSpec
      // IvParameterSpec ivSpec = new IvParameterSpec(IV);
      // //Initialize Cipher for ENCRYPT_MODE
      // cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
      // //Perform Encryption
      // byte[] cipherText = cipher.doFinal(plaintext);
      // return cipherText;
      //final key = Key.fromLength(32);
      Uint8List passphrase = Uint8List.fromList(utf8.encode(keyAPi));
      final key = Key.fromLength(passphrase.length);
      //Uint8List ivUn = Uint8List.fromList();
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      final List<int> message = utf8.encode(value);;
      final encrypted = encrypter.encrypt(value, iv: iv);
      // var eee = "YnFya2xnSUw2QkZNWVYxRUcwY0xsWXRqcmtmd0VTa3c4bXFOZTB5VXJQNm93NzVUcWxRblVadUhvVWtFbGNWVlhWOEtSOGFUcVQ5N010d1F5WnZxMFZGY0d4bjhmUVpCWDJsOE1QYTAwMjVqZ0Z1WVdEb0RObFY2bTNqb3cxc0xLY0hZZVd5ZHpKblVWdDlCY1dwMlp1WHJHNUEwZCtZMCtEbHdxeXRYekZtYURrcmdRQnhQd3JvWFVuWjFadGxpMy9uUzQyNHFES09tdE1nVDNxVGtNK1NYa0d1TmFYRVhGYWxqMHpQMlhLTT0=";
      // var ddd = encrypter.decrypt64(eee, iv: iv);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      print('encrypted.....: ${encrypted.base64}');
      //print('decrypted.....: ${ddd}');
    } catch(e){
      return null;
    }
  }

  static void test(String data, String apiKey){
    String saltHex = '00000000000000000000000000000000';
    String ivHex = '00000000000000000000000000000000';
    String passphraseUtf8 = apiKey;
    String ciphertextBase64 = "mobileapi|cauugf6ORCafNuvfhBNxLg:APA91bGWk7S0Z1we_YrKm9Hc-FVG04230kodgyuQftmKL7mf4Stwt-hypkYzSzJH19emDxnKdEQN1IclTyCfGCWAN--5qasNLr3Dxski9IcEt3WXLmN2heDG1BWZboD_Vphq3Jx7f_TG";


    Uint8List salt = Uint8List.fromList(hex.decode(saltHex));
    Uint8List passphrase = Uint8List.fromList(utf8.encode(passphraseUtf8));
    Uint8List key = EnData.generateKey(salt, passphrase);

    Uint8List ciphertext = base64.decode(ciphertextBase64);
    Uint8List iv = Uint8List.fromList(hex.decode(ivHex));
    Uint8List decrypted = EnData.decrypt(ciphertext, key, iv);

    print(utf8.decode(decrypted)); // This is working
  }

  // final sha256 = Digest("SHA-256");
  // String shaKeyTest(String key){
  //   final signer = RSASigner(SHA256Digest(),key);
  //   signer.
  // }

}