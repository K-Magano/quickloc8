class JsonMessages {
  String? message;
  String? subject;
  String? display;

  JsonMessages({
    required this.message,
    required this.subject,
    required this.display,
  });

  JsonMessages.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    subject = json['subject'];
    display = json['display'];
  }

  get profilePicture => null;
}
