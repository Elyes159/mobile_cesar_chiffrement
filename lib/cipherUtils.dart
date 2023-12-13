// ignore: file_names
class CipherUtils {
  static String encrypt(String text, int shift) {
    String result = '';
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (char.toUpperCase() != char.toLowerCase()) {
        String encryptedChar = String.fromCharCode(
          char.codeUnitAt(0) + shift,
        );
        result += encryptedChar;
      } else {
        result += char;
      }
    }
    return result;
  }

  static String decrypt(String text, int shift) {
    // Pour déchiffrer, on utilise le décalage négatif
    return text;
  }
}
