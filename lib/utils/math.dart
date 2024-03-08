import 'dart:convert';

class Math {
  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Map<String, dynamic> parseJwtPayLoad(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  List<List<int?>> convertedRecycle(String str) {
    String cleanedString = str.replaceAll(' ', '');
    List<String> subLists =
        cleanedString.substring(1, cleanedString.length - 1).split("],[");
    List<List<int?>> result = subLists.map((subList) {
      List<int?> sublistValues = subList
          .split(",")
          .map((item) {
            String trimmedItem = item.replaceAll('[', '').replaceAll(']', '');
            if (trimmedItem.isNotEmpty) {
              return int.parse(trimmedItem);
            }
          })
          .where((item) => item != null)
          .toList(); // null이 아닌 요소만 필터링하여 리스트 생성
      return sublistValues;
    }).toList();

    return result;
  }
}
