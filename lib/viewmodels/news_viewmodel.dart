import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../utils/app_state.dart';

/// ViewModel للتعامل مع منطق الأخبار
/// مسؤول عن توفير البيانات والتعامل مع حالات التطبيق
class NewsViewModel extends ChangeNotifier {
  // حالة التطبيق الحالية
  AppState _appState = AppState.loading;
  
  // قائمة الأخبار
  List<NewsModel> _newsList = [];
  
  // رسالة الخطأ
  String _errorMessage = '';

  // Getters
  AppState get appState => _appState;
  List<NewsModel> get newsList => _newsList;
  String get errorMessage => _errorMessage;

  /// Constructor - يقوم بتحميل البيانات افتراضياً
  NewsViewModel() {
    _loadNews();
  }

  /// تحميل قائمة الأخبار (محاكاة جلب من الخادم)
  Future<void> _loadNews() async {
    try {
      _appState = AppState.loading;
      notifyListeners();

      // محاكاة تأخير الاتصال بالخادم
      await Future.delayed(const Duration(seconds: 2));

      // بيانات افتراضية
      _newsList = _generateMockNews();
      
      _appState = AppState.loaded;
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _appState = AppState.error;
      _errorMessage = 'حدث خطأ أثناء تحميل الأخبار: $e';
      notifyListeners();
    }
  }

  /// تحديث قائمة الأخبار (Pull to Refresh)
  Future<void> refreshNews() async {
    try {
      _appState = AppState.loading;
      notifyListeners();

      // محاكاة تأخير الاتصال بالخادم
      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

      _newsList = _generateMockNews();
      
      _appState = AppState.loaded;
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _appState = AppState.error;
      _errorMessage = 'فشل تحديث الأخبار: $e';
      notifyListeners();
    }
  }

  /// توليد بيانات الأخبار الافتراضية - مع صور من URLs موثوقة
  List<NewsModel> _generateMockNews() {
    return [
      NewsModel(
        id: '1',
        title: 'Flutter 3.22 تُحدث ثورة في تطوير التطبيقات',
        description: 'أطلقت Google نسخة جديدة من Flutter بميزات متقدمة وتحسينات في الأداء تصل إلى 40% أسرع.',
        imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400&h=200&fit=crop',
        publishDate: DateTime.now().subtract(const Duration(hours: 2)),
        category: 'Flutter',
      ),
      NewsModel(
        id: '2',
        title: 'Dart 3.4: لغة برمجة أكثر قوة وسلاسة',
        description: 'تحديث جديد للغة Dart يجلب دعماً أفضل للبرمجة غير المتزامنة والقيود الكتابية.',
        imageUrl: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=400&h=200&fit=crop',
        publishDate: DateTime.now().subtract(const Duration(hours: 5)),
        category: 'Dart',
      ),
      NewsModel(
        id: '3',
        title: 'تطبيقات Flutter تصل إلى 500 مليون مستخدم',
        description: 'شركات عملاقة مثل Google و BMW و Alibaba تستخدم Flutter في تطبيقاتها الموثوقة.',
        imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=400&h=200&fit=crop',
        publishDate: DateTime.now().subtract(const Duration(days: 1)),
        category: 'إحصائيات',
      ),
      NewsModel(
        id: '4',
        title: 'ميزات جديدة في Material Design 3',
        description: 'Material Design 3 يوفر تخصيصاً أكثر وتحكماً أفضل في الألوان والأشكال.',
        imageUrl: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=400&h=200&fit=crop',
        publishDate: DateTime.now().subtract(const Duration(days: 2)),
        category: 'تصميم',
      ),
      NewsModel(
        id: '5',
        title: 'الحوسبة السحابية مع Firebase من Google',
        description: 'Firebase يقدم خدمات متكاملة لتطبيقات Flutter بدون الحاجة للعناء بالخادم.',
        imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&h=200&fit=crop',
        publishDate: DateTime.now().subtract(const Duration(days: 3)),
        category: 'Firebase',
      ),
      NewsModel(
        id: '6',
        title: 'أمان تطبيقات Flutter: أفضل الممارسات',
        description: 'نصائح وحيل لجعل تطبيقات Flutter آمنة من الهجمات والتهديدات الأمنية.',
        imageUrl: 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=400&h=200&fit=crop',
        publishDate: DateTime.now().subtract(const Duration(days: 4)),
        category: 'أمان',
      ),
    ];
  }

  /// إعادة محاولة تحميل الأخبار عند حدوث خطأ
  Future<void> retryLoadNews() async {
    await _loadNews();
  }
}
