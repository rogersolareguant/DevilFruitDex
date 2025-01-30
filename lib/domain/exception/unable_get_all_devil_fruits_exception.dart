class UnableGetAllDevilFruitsException implements Exception {
  final String message;

  UnableGetAllDevilFruitsException({required this.message});

  @override
  String toString() {
    return message;
  }
}
