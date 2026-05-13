# 💡 نصائح وحيل Flutter و Dart

مجموعة نصائح وحيل مفيدة عند العمل على TechPost أو أي مشروع Flutter آخر.

---

## 🚀 نصائح الأداء

### 1. استخدم const بقدر الإمكان

```dart
// ✅ صحيح - الأداء أفضل
const SizedBox(height: 16)
const EdgeInsets.all(8)
const Duration(seconds: 2)
const Color(0xFF00FF41)

// ❌ بطيء - إنشاء instance جديد في كل build
SizedBox(height: 16)
EdgeInsets.all(8)
Duration(seconds: 2)
Color(0xFF00FF41)
```

### 2. استخدم ListView.builder بدلاً من ListView

```dart
// ✅ صحيح - يحمل العناصر حسب الحاجة
ListView.builder(
  itemCount: newsList.length,
  itemBuilder: (context, index) {
    return NewsCard(news: newsList[index]);
  },
)

// ❌ بطيء - ينشئ جميع العناصر من البداية
ListView(
  children: newsList.map((news) => NewsCard(news: news)).toList(),
)
```

### 3. تجنب rebuild غير الضروري

```dart
// ✅ صحيح - Consumer فقط للأجزاء التي تتغير
Consumer<NewsViewModel>(
  builder: (context, viewModel, child) {
    return NewsCard(news: viewModel.newsList[0]);
  },
  child: const SizedBox(height: 16), // لا يعاد بناؤها
)

// ❌ خطأ - إعادة بناء الشاشة بأكملها
Consumer<NewsViewModel>(
  builder: (context, viewModel, child) {
    return Scaffold(
      appBar: AppBar(),
      body: NewsCard(news: viewModel.newsList[0]),
    );
  },
)
```

---

## 🎨 نصائح التصميم

### 1. استخدم Theme بدلاً من الألوان المباشرة

```dart
// ✅ صحيح
Text(
  'Hello',
  style: Theme.of(context).textTheme.bodyLarge,
)

// ❌ خطأ
Text(
  'Hello',
  style: TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 16,
  ),
)
```

### 2. استخدم Responsive Design

```dart
// ✅ صحيح - يتكيف مع الحجم
Container(
  width: MediaQuery.of(context).size.width * 0.9,
  padding: EdgeInsets.symmetric(
    horizontal: MediaQuery.of(context).size.width > 600 ? 32 : 16,
  ),
  child: Text('Hello'),
)

// أو استخدام LayoutBuilder
LayoutBuilder(
  builder: (context, constraints) {
    return Container(
      width: constraints.maxWidth,
      child: Text('Hello'),
    );
  },
)
```

### 3. استخدم الـ Spacing Constants

```dart
// ✅ صحيح - متسق في كل التطبيق
class AppSpacing {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
  static const double xlarge = 32;
}

// الاستخدام
SizedBox(height: AppSpacing.medium)
Padding(padding: EdgeInsets.all(AppSpacing.large))

// ❌ خطأ - أرقام عشوائية
SizedBox(height: 16)
SizedBox(height: 24)
SizedBox(height: 12)
```

---

## 🧪 نصائح الاختبار

### 1. اختبر Models بسهولة

```dart
test('NewsModel should have title', () {
  final news = NewsModel(
    id: '1',
    title: 'Test Title',
    description: 'Test',
    imageUrl: 'https://example.com',
    publishDate: DateTime.now(),
    category: 'Flutter',
  );

  expect(news.title, equals('Test Title'));
});
```

### 2. اختبر ViewModels

```dart
test('NewsViewModel should load news', () async {
  final viewModel = NewsViewModel();
  
  expect(viewModel.appState, equals(AppState.loading));
  
  await Future.delayed(Duration(seconds: 2));
  
  expect(viewModel.appState, equals(AppState.loaded));
  expect(viewModel.newsList.length, greaterThan(0));
});
```

### 3. اختبر Widgets

```dart
testWidgets('NewsCard should display news', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: NewsCard(
        news: mockNews,
        onTap: () {},
      ),
    ),
  ));

  expect(find.text('Test Title'), findsOneWidget);
  expect(find.byType(Image), findsOneWidget);
});
```

---

## 🔍 نصائح التصحيح

### 1. استخدم print() للتصحيح

```dart
// ✅ صحيح
print('AppState: ${viewModel.appState}');
print('News count: ${viewModel.newsList.length}');
print('Error: ${viewModel.errorMessage}');

// أفضل: استخدم debugPrint
import 'package:flutter/foundation.dart';
debugPrint('AppState: ${viewModel.appState}');
```

### 2. استخدم Dev Tools

```bash
# بدء التطبيق مع Dev Tools
flutter run

# في Terminal اضغط:
# 's' - Screenshot
# 'd' - Detach
# 'q' - Quit
# 'r' - Hot Reload
# 'R' - Hot Restart
```

### 3. استخدم Dart DevTools

```bash
# فتح Dart DevTools
flutter pub global activate devtools
dart devtools

# أو من VS Code
# F1 > Dart DevTools
```

---

## 📱 نصائح المحاكاة

### 1. محاكاة بيانات مختلفة

```dart
// ✅ صحيح - اختبر مع بيانات مختلفة
List<NewsModel> _generateMockNews() {
  return [
    NewsModel(/* data 1 */),
    NewsModel(/* data 2 */),
    NewsModel(/* data 3 */),
  ];
}

// بدون بيانات
List<NewsModel> _generateEmptyNews() {
  return [];
}

// بيانات كثيرة (performance test)
List<NewsModel> _generateLargeNews() {
  return List.generate(1000, (i) => NewsModel(/* data */));
}
```

### 2. محاكاة الأخطاء

```dart
// ✅ اختبر معالجة الأخطاء
Future<void> _loadNews() async {
  try {
    _appState = AppState.loading;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    
    // محاكاة خطأ
    if (simulateError) {
      throw Exception('Network error');
    }

    _newsList = _generateMockNews();
    _appState = AppState.loaded;
  } catch (e) {
    _appState = AppState.error;
    _errorMessage = e.toString();
  }
  notifyListeners();
}
```

---

## 🌐 نصائح متعددة المنصات

### 1. دعم جميع الأجهزة

```dart
// ✅ صحيح - يتكيف مع المنصة
if (defaultTargetPlatform == TargetPlatform.iOS) {
  // كود خاص بـ iOS
} else if (defaultTargetPlatform == TargetPlatform.android) {
  // كود خاص بـ Android
}

// أو
kIsWeb ? webWidget : mobileWidget
```

### 2. استخدام Platform Channels

```dart
// للوصول إلى الكود الأصلي إذا لزم
import 'package:flutter/services.dart';

const platform = MethodChannel('com.techpost.app/channel');

Future<void> platformCall() async {
  try {
    final int result = await platform.invokeMethod('method');
  } catch (e) {
    print('Error: $e');
  }
}
```

---

## 📦 نصائح إدارة المكتبات

### 1. استخدم pub.dev للبحث

```bash
# البحث عن مكتبة
# https://pub.dev

# إضافة مكتبة
flutter pub add package_name

# تحديث المكتبات
flutter pub upgrade

# قائمة المكتبات القديمة
flutter pub outdated
```

### 2. تثبيت مكتبات محددة

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  
  # أحدث إصدار
  provider:
  
  # إصدار محدد
  http: ^0.13.5
  
  # نطاق محدد
  dio: ^5.0.0
  
  # من GitHub
  custom_package:
    git:
      url: https://github.com/user/repo.git
```

---

## 🔐 نصائح الأمان

### 1. تجنب الكلمات المحظورة

```dart
// ❌ لا تخزن بيانات حساسة
class User {
  String password; // خطير!
  String apiKey;   // خطير!
}

// ✅ استخدم حفظ آمن
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
await storage.write(key: 'apiKey', value: apiKey);
```

### 2. تحقق من المدخلات

```dart
// ✅ صحيح - تحقق من المدخلات
String validateEmail(String email) {
  if (email.isEmpty) return 'Email is required';
  if (!email.contains('@')) return 'Invalid email';
  return '';
}

// استخدام
String? error = validateEmail(userInput);
if (error.isNotEmpty) {
  // عرض الخطأ
}
```

---

## ⚡ نصائح الأداء المتقدمة

### 1. استخدم SingleChildRenderObjectWidget

```dart
// ✅ لـ تخطيطات معقدة
class CustomLayout extends SingleChildRenderObjectWidget {
  const CustomLayout({required Widget child}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomLayout();
  }
}
```

### 2. استخدم مسار التصيير (Rendering Pipeline)

```dart
// فهم الخطوات:
// 1. Build phase - عرض widgets
// 2. Layout phase - حساب الحجم والموضع
// 3. Paint phase - رسم الـ pixels
// 4. Composite phase - الدمج النهائي
```

---

## 🎯 نصائح الإنتاجية

### 1. استخدم Snippets

في VS Code:
```json
{
  "Flutter Widget": {
    "prefix": "flutterwidget",
    "body": [
      "class ${1:MyWidget} extends StatelessWidget {",
      "  const ${1:MyWidget}({Key? key}) : super(key: key);",
      "",
      "  @override",
      "  Widget build(BuildContext context) {",
      "    return ${2:Container}(",
      "      child: Text('Hello'),",
      "    );",
      "  }",
      "}"
    ]
  }
}
```

### 2. استخدم Keyboard Shortcuts

| الاختصار | الوظيفة |
|---------|--------|
| `Ctrl+Shift+R` | Hot Restart |
| `Ctrl+R` | Hot Reload |
| `F9` | Toggle Breakpoint |
| `F10` | Step Over |
| `F11` | Step Into |

### 3. استخدم IDE Shortcuts

```
Ctrl+Space     - Autocomplete
Ctrl+.         - Quick Fix
Ctrl+/         - Comment
F12            - Go to Definition
Ctrl+G         - Go to Line
Ctrl+H         - Find and Replace
```

---

## 📝 نصائح التوثيق

### 1. اكتب تعليقات واضحة

```dart
/// توثيق الدالة
/// 
/// تحمل قائمة الأخبار من الخادم
/// 
/// [timeout] المدة الزمنية للانتظار
/// 
/// Returns: قائمة الأخبار أو null في حالة الفشل
/// 
/// Throws: [Exception] إذا فشل الاتصال
Future<List<NewsModel>?> loadNews({Duration? timeout}) async {
  // التطبيق
}
```

### 2. استخدم Documentation Comments

```dart
/// نموذج الخبر
/// 
/// يحتوي على معلومات الخبر الكاملة
class NewsModel {
  /// معرّف فريد للخبر
  final String id;
  
  /// عنوان الخبر
  final String title;
}
```

---

## 🆘 حل المشاكل الشائعة

### مشكلة: "Unresolved reference"

**الحل**:
```bash
flutter pub get
flutter clean
flutter pub get
```

### مشكلة: "Yellow Box"

**الحل**:
```dart
// استخدم ConstrainedBox
ConstrainedBox(
  constraints: BoxConstraints(maxWidth: 200),
  child: Text('Long text here'),
)
```

### مشكلة: "Build Method Too Large"

**الحل**:
```dart
// قسّم الـ build الكبير
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _buildAppBar(),
    body: _buildBody(),
  );
}

PreferredSizeWidget _buildAppBar() { ... }
Widget _buildBody() { ... }
```

---

## 📚 الموارد المفيدة

### الوثائق
- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [Provider Package](https://pub.dev/packages/provider)

### القنوات
- [The Net Ninja - Flutter](https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Mw0gfAiydHstJ1BN)
- [Flutter Official](https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9Q5A)

### المنتديات
- Stack Overflow
- Reddit r/Flutter
- Flutter Discord

---

## ✅ قائمة التحقق قبل الإطلاق

- [ ] اختبار جميع الشاشات
- [ ] اختبار جميع الأجهزة
- [ ] فحص الأداء
- [ ] فحص الأمان
- [ ] كتابة التوثيق
- [ ] اختبار على الإنترنت البطيء
- [ ] اختبار على البطارية الضعيفة
- [ ] فحص النسخة الإنجليزية والعربية

---

**استمتع بـ Flutter! 🚀**
