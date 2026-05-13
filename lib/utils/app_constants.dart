/// ملف الثوابت والقيم المستخدمة في التطبيق
class AppConstants {
  /// أسماء التطبيق
  static const String appName = 'TechPost';
  static const String appNameArabic = 'تِك بوست';

  /// رسائل الخطأ
  static const String errorLoadingNews = 'فشل تحميل الأخبار';
  static const String errorRefreshNews = 'فشل تحديث الأخبار';
  static const String errorGeneral = 'حدث خطأ غير متوقع';

  /// الرسائل النجاحية
  static const String newsLoaded = 'تم تحميل الأخبار بنجاح';
  static const String newsRefreshed = 'تم تحديث الأخبار بنجاح';

  /// البحث
  static const String searchHint = 'ابحث عن أخبار...';
  static const String searchNotImplemented = 'وظيفة البحث قيد التطوير';

  /// الفئات
  static const String categoryFlutter = 'Flutter';
  static const String categoryDart = 'Dart';
  static const String categoryFirebase = 'Firebase';
  static const String categoryDesign = 'تصميم';
  static const String categorySecurity = 'أمان';
  static const String categoryStatistics = 'إحصائيات';

  /// المدة الزمنية
  static const String justNow = 'للتو';
  static const String minutesAgo = 'قبل دقائق';
  static const String hoursAgo = 'قبل ساعات';
  static const String daysAgo = 'قبل أيام';
  static const String weekAgo = 'قبل أسبوع';

  /// الأيقونات
  static const String noImage = 'لا توجد صورة';
  static const String readMore = 'اقرأ المزيد';
  static const String retry = 'إعادة محاولة';
  static const String loading = 'جاري التحميل...';
}
