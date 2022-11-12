import 'dart:typed_data';
import "package:pointycastle/export.dart";

class EnData{
  static Uint8List decrypt(Uint8List ciphertext, Uint8List key, Uint8List iv) {
    CBCBlockCipher cipher = new CBCBlockCipher(new AESFastEngine());
    ParametersWithIV<KeyParameter> params = new ParametersWithIV<KeyParameter>(new KeyParameter(key), iv);
    PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null> paddingParams = new PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(params, null);
    PaddedBlockCipherImpl paddingCipher = new PaddedBlockCipherImpl(new PKCS7Padding(), cipher);
    paddingCipher.init(false, paddingParams);
    return paddingCipher.process(ciphertext);
  }

  static Uint8List generateKey(Uint8List salt, Uint8List passphrase){
    KeyDerivator derivator = new PBKDF2KeyDerivator(new HMac(new SHA1Digest(), 64));
    Pbkdf2Parameters params = new Pbkdf2Parameters(salt, 5, 16);
    derivator.init(params);
    return derivator.process(passphrase);
  }
}