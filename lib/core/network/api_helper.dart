class ApiHelper {
  ApiHelper._();

  /// Extracts payload from common envelope keys:
  /// - data
  /// - result
  /// Falls back to raw response.
  static dynamic data(dynamic res) {
    if (res == null) return null;
    if (res is Map<String, dynamic>) {
      if (res.containsKey('data')) return res['data'];
      if (res.containsKey('result')) return res['result'];
      return res;
    }
    if (res is Map) {
      final map = Map<String, dynamic>.from(res);
      if (map.containsKey('data')) return map['data'];
      if (map.containsKey('result')) return map['result'];
      return map;
    }
    return res;
  }

  /// Safe map conversion.
  static Map<String, dynamic> map(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return const {};
  }

  /// Safe list conversion.
  ///
  /// - list payload: keeps only map-like items
  /// - map payload: normalizes into single-item list
  /// - others/null: empty list
  static List<Map<String, dynamic>> list(dynamic value) {
    if (value is List) {
      return value.map(map).where((e) => e.isNotEmpty).toList();
    }
    final one = map(value);
    if (one.isNotEmpty) return [one];
    return const [];
  }

  static String str(dynamic v) {
    if (v == null) return '';
    if (v is String) return v;
    return v.toString();
  }

  static int num(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) {
      final asInt = int.tryParse(v);
      if (asInt != null) return asInt;
      final asDouble = double.tryParse(v);
      if (asDouble != null) return asDouble.toInt();
    }
    return 0;
  }

  static double dbl(dynamic v) {
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0.0;
    return 0.0;
  }

  static bool boolVal(dynamic v) {
    if (v == null) return false;
    if (v is bool) return v;
    if (v is int) return v != 0;
    if (v is double) return v != 0;
    if (v is String) {
      final lower = v.toLowerCase();
      return lower == 'true' || lower == '1' || lower == 'yes';
    }
    return false;
  }

  static List<String> strList(dynamic v) {
    if (v is! List) return const [];
    return v.map((e) => str(e).trim()).where((e) => e.isNotEmpty).toList();
  }

  static DateTime? date(dynamic v) {
    final raw = str(v);
    if (raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }
}
