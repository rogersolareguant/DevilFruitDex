extension StringX on String {
  String capitalize() {
    return isEmpty ? "" : "${this[0].toUpperCase()}${substring(1)}";
  }

  String shortName() {
    if (isEmpty) return "";

    // Regular expression to match text ending with "no Mi"
    final match = RegExp(r'^(.*?no Mi)').firstMatch(this);

    // If "no Mi" is found, return the match; otherwise, return the original string
    return match != null ? match.group(1) ?? this : this;
  }

    String userName() {
    if (isEmpty) return "";

    return contains('@') ? split('@').first : this;
  }
}
