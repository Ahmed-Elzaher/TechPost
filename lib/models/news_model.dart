/// نموذج بيانات الخبر
class NewsModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime publishDate;
  final String category;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishDate,
    required this.category,
  });

  /// تحويل من JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      publishDate: DateTime.parse(json['publishDate'] as String),
      category: json['category'] as String,
    );
  }

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'publishDate': publishDate.toIso8601String(),
      'category': category,
    };
  }

  /// حساب المدة الزمنية منذ النشر
  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(publishDate);

    if (difference.inSeconds < 60) {
      return 'للتو';
    } else if (difference.inMinutes < 60) {
      return 'قبل ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'قبل ${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return 'قبل ${difference.inDays} يوم';
    } else {
      return 'قبل أسبوع';
    }
  }
}
