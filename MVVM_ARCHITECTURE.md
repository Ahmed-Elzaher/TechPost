# 🏛️ معمارية MVVM في TechPost

هذا الملف يشرح كيف تم تطبيق معمارية **MVVM** (Model-View-ViewModel) في تطبيق TechPost.

---

## 📚 ما هي معمارية MVVM؟

**MVVM** هي اختصار لـ **Model-View-ViewModel**، وهي معمارية تفصل التطبيق إلى ثلاث طبقات:

```
┌─────────────────────────────────────┐
│         View Layer (الواجهة)         │
│  ▼ Updates (مستمع للتغييرات)         │
└─────────────────────────────────────┘
              △
              │
         ChangeNotifier
              │
              ▼
┌─────────────────────────────────────┐
│    ViewModel Layer (المنطق)         │
│  ▼ Requests (طلبات من View)        │
└─────────────────────────────────────┘
              △
              │
              │
              ▼
┌─────────────────────────────────────┐
│     Model Layer (البيانات)         │
└─────────────────────────────────────┘
```

---

## 🔷 طبقة Model

### الملف: `lib/models/news_model.dart`

**المسؤولية**: تمثيل بنية البيانات والعمليات المرتبطة بها.

```dart
class NewsModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime publishDate;
  final String category;

  // Methods لمعالجة البيانات
  String getTimeAgo() { ... }
  Map<String, dynamic> toJson() { ... }
  factory NewsModel.fromJson(Map<String, dynamic> json) { ... }
}
```

**المميزات:**
- ✅ نموذج بيانات نقي (Pure Data Model)
- ✅ methods لمعالجة البيانات
- ✅ تحويل من/إلى JSON

---

## 🔶 طبقة ViewModel

### الملف: `lib/viewmodels/news_viewmodel.dart`

**المسؤولية**: 
- إدارة حالة التطبيق
- توفير البيانات للـ View
- التعامل مع عمليات التحميل والتحديث

```dart
class NewsViewModel extends ChangeNotifier {
  // الحالة
  AppState _appState = AppState.loading;
  List<NewsModel> _newsList = [];
  String _errorMessage = '';

  // العمليات
  Future<void> _loadNews() async { ... }
  Future<void> refreshNews() async { ... }
}
```

**المميزات:**
- ✅ يرث من `ChangeNotifier` لإخطار الـ View بالتغييرات
- ✅ فصل تام عن الواجهة
- ✅ يمكن اختباره بسهولة (Testable)

**الحالات المدارة:**
```
Loading → Loaded → (error or success)
```

---

## 🔵 طبقة View

### الملفات: `lib/views/home_screen.dart` و `lib/views/widgets/news_card.dart`

**المسؤولية**: 
- عرض البيانات للمستخدم
- التفاعل مع المستخدم
- استدعاء دوال ViewModel عند الحاجة

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsViewModel>(
      builder: (context, viewModel, child) {
        // استخدام بيانات ViewModel
      },
    );
  }
}
```

**المميزات:**
- ✅ تحديث تلقائي عند تغيير البيانات
- ✅ فصل واضح بين المنطق والتصميم
- ✅ سهلة الفهم والصيانة

---

## 🔄 تدفق البيانات في TechPost

### سيناريو: فتح التطبيق وتحميل الأخبار

```
1. main.dart
   ↓ ينشئ
2. NewsViewModel (عبر Provider)
   ↓ ينادي في Constructor
3. _loadNews()
   ↓ تحديث الحالة
4. _appState = AppState.loading
   ↓ إخطار الـ View
5. notifyListeners()
   ↓ الـ Consumer في HomeScreen يستمع
6. _buildLoadingState() (عرض Loading)
   ↓ بعد التأخير
7. تحميل البيانات _generateMockNews()
   ↓ تحديث الحالة
8. _appState = AppState.loaded
   ↓ إخطار الـ View
9. notifyListeners()
   ↓ الـ Consumer يستقبل التحديث
10. _buildLoadedState() (عرض الأخبار)
```

---

## 🎯 أمثلة عملية

### مثال 1: الاستماع للبيانات من ViewModel

```dart
Consumer<NewsViewModel>(
  builder: (context, viewModel, child) {
    // viewModel توفر البيانات والدوال
    List<NewsModel> newsList = viewModel.newsList;
    AppState state = viewModel.appState;
    
    // عرض الواجهة بناءً على الحالة
    return buildUI(state, newsList);
  },
)
```

### مثال 2: استدعاء دالة من ViewModel

```dart
// من View (HomeScreen)
onRefresh: () => viewModel.refreshNews(),

// عند الضغط على خبر
onTap: () {
  // استدعاء دالة من ViewModel إذا لزم الأمر
  viewModel.trackNewsClick(news.id);
}
```

### مثال 3: معالجة الأخطاء

```dart
case AppState.error:
  return Center(
    child: ElevatedButton(
      onPressed: () => viewModel.retryLoadNews(),
      child: const Text('إعادة محاولة'),
    ),
  );
```

---

## 🛡️ فوائد معمارية MVVM

| الفائدة | الشرح |
|--------|-------|
| **الاختبار السهل** | يمكن اختبار ViewModel بدون الواجهة |
| **القابلية للصيانة** | كود منظم وسهل الفهم |
| **إعادة الاستخدام** | نفس ViewModel مع واجهات مختلفة |
| **الفصل** | فصل تام بين المنطق والتصميم |
| **المرونة** | سهولة التعديل والإضافة |

---

## 🔗 الربط بين الطبقات

### 1. Provider (الوسيط)

```dart
// في main.dart
ChangeNotifierProvider(
  create: (_) => NewsViewModel(),
)
```

### 2. Consumer (المستمع)

```dart
// في HomeScreen
Consumer<NewsViewModel>(
  builder: (context, viewModel, child) { ... }
)
```

### 3. ChangeNotifier (المنبه)

```dart
// في NewsViewModel
notifyListeners(); // إخطار Consumer بالتغييرات
```

---

## 📊 حالات التطبيق (States)

```dart
enum AppState {
  loading,    // جاري التحميل
  loaded,     // تم التحميل بنجاح
  error,      // حدث خطأ
}
```

### دورة حياة الحالة

```
┌──────────────┐
│   loading    │ ← الحالة الأولية
└──────┬───────┘
       │
       ├─ (نجاح) ──→ ┌─────────┐
       │             │ loaded  │
       │             └─────────┘
       │
       └─ (خطأ) ──→ ┌────────┐
                    │ error  │ ← يمكن إعادة المحاولة
                    └────────┘
```

---

## 🚀 نصائح لاستخدام MVVM في Flutter

### ✅ افعل:
- ✓ ضع كل المنطق في ViewModel
- ✓ استخدم ChangeNotifier للإخطارات
- ✓ عزل Model عن View تماماً
- ✓ اختبر ViewModel بشكل منفصل
- ✓ استخدم Immutable Models

### ❌ لا تفعل:
- ✗ ضع منطق في الـ View
- ✗ اسم صريح للـ View من ViewModel
- ✗ تعديل البيانات بشكل مباشر
- ✗ استخدام StatefulWidget بدلاً من ChangeNotifier
- ✗ عمليات طويلة في البناء (build method)

---

## 📝 خلاصة

معمارية MVVM في TechPost توفر:

1. **نظافة الكود** - كود منظم وسهل الفهم
2. **القابلية للاختبار** - يمكن اختبار المنطق بسهولة
3. **المرونة** - سهولة الإضافة والتعديل
4. **الصيانة** - كود يسهل صيانته
5. **الأداء** - تحديثات فعالة للواجهة

---

**تم تطبيق معمارية MVVM بنجاح في TechPost! 🎉**
