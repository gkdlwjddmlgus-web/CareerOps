abstract interface class BackupRepository {
  Future<String> export();
  void validate(String text);

  /// Restores atomically and returns the safety backup path.
  Future<String> restore(String text);
  Future<String?> previousRestoreBackup();
}
