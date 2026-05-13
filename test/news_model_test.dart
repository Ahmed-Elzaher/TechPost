import 'package:flutter_test/flutter_test.dart';
import 'package:tech_post/models/news_model.dart';

void main() {
  group('NewsModel Tests', () {
    test('NewsModel should be created correctly', () {
      final DateTime testDate = DateTime(2024, 5, 10);
      final news = NewsModel(
        id: '1',
        title: 'Test Title',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        publishDate: testDate,
        category: 'Flutter',
      );

      expect(news.id, equals('1'));
      expect(news.title, equals('Test Title'));
      expect(news.description, equals('Test Description'));
      expect(news.category, equals('Flutter'));
    });

    test('NewsModel.getTimeAgo() should return correct time ago', () {
      final now = DateTime.now();
      final oneHourAgo = now.subtract(const Duration(hours: 1));

      final news = NewsModel(
        id: '1',
        title: 'Test',
        description: 'Test',
        imageUrl: 'https://example.com/image.jpg',
        publishDate: oneHourAgo,
        category: 'Flutter',
      );

      expect(news.getTimeAgo(), contains('ساعة'));
    });

    test('NewsModel.toJson() should convert to JSON correctly', () {
      final DateTime testDate = DateTime(2024, 5, 10, 10, 30, 0);
      final news = NewsModel(
        id: '1',
        title: 'Test Title',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        publishDate: testDate,
        category: 'Flutter',
      );

      final json = news.toJson();

      expect(json['id'], equals('1'));
      expect(json['title'], equals('Test Title'));
      expect(json['category'], equals('Flutter'));
    });

    test('NewsModel.fromJson() should create from JSON correctly', () {
      final json = {
        'id': '1',
        'title': 'Test Title',
        'description': 'Test Description',
        'imageUrl': 'https://example.com/image.jpg',
        'publishDate': '2024-05-10T10:30:00.000',
        'category': 'Flutter',
      };

      final news = NewsModel.fromJson(json);

      expect(news.id, equals('1'));
      expect(news.title, equals('Test Title'));
      expect(news.category, equals('Flutter'));
    });
  });
}
