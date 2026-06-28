class KanamiChatException implements Exception {
  final String message;
  final String function;

  KanamiChatException(this.function, this.message);

  @override
  String toString() => "$function: $message";
}