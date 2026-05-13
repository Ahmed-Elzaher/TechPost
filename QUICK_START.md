# 🚀 TechPost - تطبيق أخبار تقنية

> تطبيق إخباري تقني عصري مطور بـ Flutter مع معمارية MVVM نظيفة.

---

## ⚡ البدء السريع

### المتطلبات
```bash
Flutter SDK: ^3.11.3
Dart: ^3.11.3
```

### التثبيت والتشغيل
```bash
# 1. تثبيت المكتبات
flutter pub get

# 2. تشغيل التطبيق
flutter run

# 3. Hot Reload (اضغط 'r' في الـ Terminal)
```

---

## 📁 البنية الأساسية

```
lib/
├── main.dart                 ← نقطة الدخول
├── models/
│   └── news_model.dart      ← نموذج البيانات
├── viewmodels/
│   └── news_viewmodel.dart  ← منطق التطبيق (MVVM)
├── views/
│   ├── home_screen.dart     ← الشاشة الرئيسية
│   └── widgets/
│       └── news_card.dart   ← كارت الخبر
└── utils/
    ├── app_state.dart       ← الحالات
    ├── app_theme.dart       ← الألوان والتصميم
    └── app_constants.dart   ← الثوابت
```

---

## 🎯 المميزات

✅ **Dark Mode** - تصميم أسود مع أخضر فسفوري (#00FF41)
✅ **MVVM Architecture** - معمارية نظيفة
✅ **Pull-to-Refresh** - تحديث سحب لأسفل
✅ **State Handling** - Loading, Loaded, Error
✅ **Clean Code** - معايير هندسية عالية
✅ **Responsive** - يعمل على جميع الأجهزة

---

## 📚 الملفات المهمة

### التوثيق الشاملة
- **[TECHPOST_README.md](TECHPOST_README.md)** - دليل شامل
- **[MVVM_ARCHITECTURE.md](MVVM_ARCHITECTURE.md)** - شرح معمارية MVVM
- **[USAGE_GUIDE.md](USAGE_GUIDE.md)** - دليل الاستخدام
- **[CLEAN_CODE_STANDARDS.md](CLEAN_CODE_STANDARDS.md)** - معايير الكود النظيف

---

## 🎨 نظام الألوان

| الاسم | الكود | الاستخدام |
|------|------|---------|
| Background | `#121212` | خلفية الشاشة |
| Card BG | `#1E1E1E` | خلفية الكروت |
| Neon Green | `#00FF41` | الأزرار والأيقونات |
| Text | `#FFFFFF` | النصوص الرئيسية |
| Gray | `#B3B3B3` | النصوص الثانوية |

---

## 🔄 دورة الحالات

```
Loading (جاري التحميل)
   ↓
Loaded (تم التحميل) ← Refresh (تحديث)
   ↓
Error (خطأ) → Retry (إعادة محاولة)
```

---

## 🏗️ معمارية MVVM

```
View (HomeScreen)
    ↓ listens
Consumer (Provider)
    ↓
ViewModel (NewsViewModel)
    ↓ manages
Model (NewsModel)
```

**الفائدة**: فصل تام بين المنطق والتصميم

---

## 📦 المكتبات المستخدمة

```yaml
dependencies:
  flutter: sdk
  provider: ^6.0.0  # State Management
  cupertino_icons: ^1.0.8
```

---

## 💡 المميزات الرئيسية

### 1. الشاشة الرئيسية
- AppBar مع عنوان وأيقونة بحث
- ListView بأخبار افتراضية
- Pull-to-Refresh للتحديث

### 2. كارت الخبر
- صورة توضيحية
- عنوان وتصنيف
- نبذة مختصرة
- تاريخ النشر
- زر اقرأ المزيد

### 3. معالجة الأخطاء
- رسالة خطأ واضحة
- زر إعادة محاولة
- معالجة جميع الحالات

---

## 🚀 التشغيل

### على Android
```bash
flutter run -d <device-id>
```

### على iOS
```bash
flutter run -d <device-id>
```

### على الويب
```bash
flutter run -d chrome
```

### على Windows
```bash
flutter run -d windows
```

---

## 🧪 الاختبارات

```bash
# تشغيل جميع الاختبارات
flutter test

# اختبار ملف محدد
flutter test test/news_model_test.dart

# اختبار مع التغطية
flutter test --coverage
```

---

## 📊 ملخص المشروع

| العنصر | التفاصيل |
|--------|---------|
| **الاسم** | TechPost |
| **النوع** | تطبيق أخبار تقني |
| **الإصدار** | 1.0.0 |
| **الحالة** | منتج |
| **المعمارية** | MVVM |
| **الحالات** | 3 (Loading, Loaded, Error) |
| **عدد الملفات الأساسية** | 8 |
| **المكتبات** | Provider |
| **معايير الكود** | SOLID + Clean Code |

---

## 🎯 الخطوات التالية

1. ✅ فهم بنية المشروع
2. ✅ قراءة الملفات التوثيقية
3. ✅ تشغيل التطبيق
4. ✅ استكشاف المميزات
5. ⏳ التوسع بميزات جديدة

---

## 📝 الملاحظات

- البيانات حالياً افتراضية
- يمكن ربطها بـ API حقيقي
- الكود منظم وسهل الصيانة
- يتبع معايير هندسية عالية

---

## 🤝 المساهمة

إذا أردت تحسين المشروع:

1. Fork المشروع
2. أنشئ فرع جديد (`git checkout -b feature/amazing-feature`)
3. Commit التغييرات (`git commit -m 'Add amazing feature'`)
4. Push الفرع (`git push origin feature/amazing-feature`)
5. Open Pull Request

---

## 📄 الترخيص

هذا المشروع مفتوح المصدر ومتاح للاستخدام الحر.

---

## 🎓 تعلم المزيد

### معمارية MVVM
- اقرأ [MVVM_ARCHITECTURE.md](MVVM_ARCHITECTURE.md)

### معايير الكود
- اقرأ [CLEAN_CODE_STANDARDS.md](CLEAN_CODE_STANDARDS.md)

### دليل الاستخدام
- اقرأ [USAGE_GUIDE.md](USAGE_GUIDE.md)

### الدليل الشامل
- اقرأ [TECHPOST_README.md](TECHPOST_README.md)

---

## 🆘 المساعدة

عند مواجهة مشاكل:

1. تحقق من صحة التثبيت: `flutter doctor`
2. أعد تثبيت المكتبات: `flutter pub get`
3. امسح البناء: `flutter clean`
4. أعد التشغيل: `flutter run`

---

## 👨‍💻 معلومات المطور

**TechPost** - تطبيق أخبار تقني مع معمارية MVVM

تم تطويره باتباع أفضل الممارسات والمعايير الهندسية العالية.

---

## 🌟 شكر خاص

شكراً لاستخدام TechPost!

**Happy Coding! 🚀**

---

## 📞 التواصل

للأسئلة والاقتراحات، لا تتردد في التواصل.

---

**آخر تحديث: 12 مايو 2026**
