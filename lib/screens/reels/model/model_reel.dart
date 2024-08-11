class Reel {
  final String id;
  final String videoUrl;
  final String description;
  final String userId;
  final String username;

  Reel({
    required this.id,
    required this.videoUrl,
    required this.description,
    required this.userId,
    required this.username,
  });

  factory Reel.fromMap(Map<String, dynamic> data, String documentId) {
    return Reel(
      id: documentId,
      videoUrl: data['videoUrl'] ?? '',
      description: data['description'] ?? '',
      userId: data['userId'] ?? '',
      username: data['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoUrl': videoUrl,
      'description': description,
      'userId': userId,
      'username': username,
    };
  }
}
