abstract class StringUtils {
  static String  capitalizeAllWord(String value) {
    if(value.isEmpty){
      return '';
    }
    value = value.toLowerCase();
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }
}
