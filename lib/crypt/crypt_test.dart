import 'package:passline_mobile/crypt/crypt.dart';
import 'package:test/test.dart';

const key = "01234567890123456789012345678912";

void main() {
  test('test encryption', () async {
    var encryptedText = await Crypt.aesGCMEncrypt(key.codeUnits, "123456789");
  });
}