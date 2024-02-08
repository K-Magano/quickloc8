class Messages {
  final String message;
  final String subject;
  final String display;

  const Messages({
    required this.message,
    required this.subject,
    required this.display,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        message: json['message'],
        subject: json['subject'],
        display: json['display'],
      );
}
