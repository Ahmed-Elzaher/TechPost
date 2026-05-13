# 📱 TechPost - تطبيق الأخبار التقنية

تطبيق إخباري تقني بسيط مطور باستخدام **Flutter** مع معمارية **MVVM** النظيفة.

---

## 🎯 المميزات الرئيسية

✅ **واجهة Dark Mode عصرية** - تصميم أسود مع لمسات أخضر فسفوري (#00FF41)

✅ **معمارية MVVM نظيفة** - فصل كامل بين المنطق والتصميم

✅ **Pull-to-Refresh** - تحديث القائمة بسحب الشاشة للأسفل

✅ **معالجة حالات التطبيق** - Loading, Loaded, Error

✅ **قائمة أخبار ديناميكية** - بيانات افتراضية قابلة للتوسع

✅ **كود منظم وقابل للصيانة** - تقسيم واضح للمسؤوليات

---

## 🏗️ بنية المشروع

```
lib/
├── main.dart                      # نقطة الدخول الرئيسية
├── models/
│   └── news_model.dart           # نموذج البيانات للخبر
├── viewmodels/
│   └── news_viewmodel.dart       # منطق التطبيق (ViewModel)
├── views/
│   ├── home_screen.dart          # الشاشة الرئيسية
│   └── widgets/
│       └── news_card.dart        # كارت الخبر الفردي
└── utils/
    ├── app_state.dart            # حالات التطبيق
    ├── app_theme.dart            # الثيمات والألوان
    └── app_constants.dart        # الثوابت والنصوص
```

---

## 🎨 نظام الألوان (Color System)

| الاسم | الكود | الاستخدام |
|------|------|---------|
| **Dark Background** | `#121212` | خلفية التطبيق الرئيسية |
| **Card Background** | `#1E1E1E` | خلفية الكروت |
| **Neon Green** | `#00FF41` | اللون الرئيسي التقني |
| **Text White** | `#FFFFFF` | النصوص الرئيسية |
| **Text Gray** | `#B3B3B3` | النصوص الثانوية |

---

## 🔄 معمارية MVVM

### **Model** (`news_model.dart`)
- يمثل بنية البيانات للخبر
- يحتوي على methods لمعالجة البيانات (مثل `getTimeAgo()`)

### **ViewModel** (`news_viewmodel.dart`)
- يدير حالة التطبيق (`AppState`)
- يوفر البيانات للـ View
- يتعامل مع العمليات مثل تحميل الأخبار والتحديث
- يستخدم `ChangeNotifier` لإخطار الـ View بالتغييرات

### **View** (`home_screen.dart` و `news_card.dart`)
- تعرض البيانات من ViewModel
- تتفاعل مع تفاعلات المستخدم
- تستخدم `Consumer` من Package Provider

---

## 📊 حالات التطبيق (App States)

```dart
enum AppState {
  loading,    // جاري التحميل
  loaded,     // تم التحميل بنجاح
  error,      // حدث خطأ
}
```

يتم التبديل بين هذه الحالات في الواجهة بناءً على عملية التحميل:

```
1. عند فتح التطبيق → AppState.loading
2. بعد تحميل الأخبار → AppState.loaded
3. في حالة الخطأ → AppState.error
```

---

## 🚀 كيفية التشغيل

### المتطلبات
- Flutter SDK 3.11.3 أو أحدث
- Dart 3.11.3 أو أحدث

### التثبيت والتشغيل

```bash
# 1. الذهاب إلى مجلد المشروع
cd tech_post

# 2. تثبيت المكتبات
flutter pub get

# 3. تشغيل التطبيق
flutter run

# 4. لـ Hot Reload (عند التعديل على الكود)
# اضغط 'r' في الـ Terminal
```

---

## 📦 المكتبات المستخدمة

| المكتبة | الإصدار | الغرض |
|--------|--------|-------|
| **flutter** | SDK | إطار العمل الأساسي |
| **provider** | ^6.0.0 | إدارة الحالة (State Management) |

---

## 🔍 شرح المكونات الرئيسية

### 1️⃣ **News Card Widget**
كارت يعرض الخبر بـ:
- صورة الخبر
- العنوان
- النبذة المختصرة
- الفئة والوقت
- زر "اقرأ المزيد"

### 2️⃣ **Home Screen**
تحتوي على:
- AppBar مع عنوان وأيقونة بحث
- ListView مع أخبار
- Pull-to-Refresh
- معالجة الحالات الثلاث

### 3️⃣ **SnackBar Notifications**
عند الضغط على خبر → رسالة SnackBar بعنوان الخبر

---

## 🎮 التفاعلات الرئيسية

| التفاعل | النتيجة |
|---------|--------|
| **فتح التطبيق** | عرض حالة Loading ثم الأخبار |
| **السحب للأسفل** | تحديث القائمة (Refresh) |
| **الضغط على خبر** | عرض SnackBar باسم الخبر |
| **الضغط على أيقونة البحث** | رسالة تطوير |
| **الضغط على "إعادة محاولة"** | إعادة تحميل الأخبار |

---

## 💡 نقاط تقنية مهمة

### استخدام Provider
```dart
Consumer<NewsViewModel>(
  builder: (context, viewModel, child) {
    // الوصول إلى البيانات من ViewModel
  },
)
```

### التعامل مع الحالات
```dart
switch (viewModel.appState) {
  case AppState.loading:
    return _buildLoadingState();
  case AppState.loaded:
    return _buildLoadedState(context, viewModel);
  case AppState.error:
    return _buildErrorState(context, viewModel);
}
```

### بيانات افتراضية (Mock Data)
يتم توليد 6 أخبار افتراضية في `_generateMockNews()`

---

## 🔄 تدفق البيانات

```
User Interface (View)
      ↓
  Consumer (Provider)
      ↓
  NewsViewModel (Business Logic)
      ↓
  NewsModel (Data)
      ↓
  Notifications to View ← ChangeNotifier
```

---

## 🎨 التصميم والأسلوب

- **Responsive Design** - يعمل على جميع أحجام الشاشات
- **Modern UI** - استخدام Rounded Corners و Borders
- **Smooth Animations** - تأثيرات انتقالية سلسة
- **Dark Mode** - تجربة مريحة للعين

---

## 📱 الأجهزة المدعومة

✅ Android 5.0+
✅ iOS 11.0+
✅ Web
✅ macOS
✅ Windows
✅ Linux

---

## 🔮 إمكانيات التوسع المستقبلية

1. **البحث عن أخبار** - تطبيق وظيفة البحث
2. **التصفية حسب الفئة** - عرض أخبار فئة معينة
3. **الإشعارات** - تنبيهات للأخبار الجديدة
4. **المفضلة** - حفظ الأخبار المفضلة
5. **مشاركة** - مشاركة الأخبار على وسائل التواصل
6. **قاعدة بيانات** - ربط مع API حقيقي
7. **Dark/Light Toggle** - تبديل بين الثيمات
8. **Localization** - دعم لغات متعددة

---

## 📝 الملاحظات

- البيانات حالياً افتراضية ويمكن ربطها بـ API حقيقي
- التأخير في التحميل (2 ثانية) لمحاكاة الاتصال بالخادم
- يمكن تخصيص الألوان والثيمات بسهولة من `app_theme.dart`

---

## 👨‍💻 تم تطويره بواسطة

**TechPost** - تطبيق أخبار تقني مع معمارية MVVM

---

## 📄 الترخيص

هذا المشروع مفتوح المصدر ومتاح للاستخدام الحر.

---

**Happy Coding! 🚀**
