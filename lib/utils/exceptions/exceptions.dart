class RepoException implements Exception {
  final String message;

  RepoException(this.message);

  @override
  String toString() => message;  // Menyediakan pesan error yang dapat dibaca
}
