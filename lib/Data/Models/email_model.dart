class EmailData {
  final String sender;
  final String subject;
  final String body;

  EmailData({required this.sender, required this.subject, required this.body});

  factory EmailData.fromJson(Map<String, dynamic> json) {
    return EmailData(
      sender: json['sender'],
      subject: json['subject'],
      body: json['body'],
    );
  }
}
