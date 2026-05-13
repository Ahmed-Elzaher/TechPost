import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/news_model.dart';
import '../../utils/app_state.dart';
import '../../utils/app_theme.dart';
import '../../viewmodels/news_viewmodel.dart';
import 'widgets/news_card.dart';
import 'widgets/news_skeleton.dart';

/// الشاشة الرئيسية لعرض الأخبار
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        bottom: true,
        child: Consumer<NewsViewModel>(
          builder: (context, viewModel, child) {
            // عرض حالات مختلفة بناءً على state
            switch (viewModel.appState) {
              case AppState.loading:
                return _buildLoadingState();

              case AppState.loaded:
                return _buildLoadedState(context, viewModel);

              case AppState.error:
                return _buildErrorState(context, viewModel);
            }
          },
        ),
      ),
    );
  }

  /// بناء AppBar احترافي مع اللوجو
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          // اللوجو - مربع بتدرج
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.accentColor,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'TP',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.darkBackground,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // النص
          const Text(
            'TechPost',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppTheme.textWhite,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppTheme.darkBackground,
      surfaceTintColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                onPressed: () {
                  // عند الضغط على البحث
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('وظيفة البحث قيد التطوير'),
                      backgroundColor: AppTheme.cardBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
                      ),
                      margin: const EdgeInsets.all(16),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// حالة التحميل - Skeleton Loader
  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      itemCount: 4, // عرض 4 هياكل أثناء التحميل
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const NewsSkeleton();
      },
    );
  }

  /// حالة النجاح (البيانات محملة) - مع الـ Empty State
  Widget _buildLoadedState(BuildContext context, NewsViewModel viewModel) {
    // التحقق من حالة القائمة الفارغة
    if (viewModel.newsList.isEmpty) {
      return _buildEmptyState(viewModel);
    }

    return RefreshIndicator(
      color: AppTheme.primaryColor,
      backgroundColor: AppTheme.cardBackground,
      strokeWidth: 2.5,
      onRefresh: () => viewModel.refreshNews(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        itemCount: viewModel.newsList.length,
        // تحسين الأداء
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        cacheExtent: 500,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          final news = viewModel.newsList[index];
          return NewsCard(
            key: ValueKey(news.id),
            news: news,
            onTap: () {
              _onNewsTapped(context, news);
            },
          );
        },
      ),
    );
  }

  /// حالة القائمة الفارغة (Empty State)
  Widget _buildEmptyState(NewsViewModel viewModel) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.textDarkGray.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.article_outlined,
                    color: AppTheme.textDarkGray,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'لا توجد أخبار حالياً',
                  style: TextStyle(
                    color: AppTheme.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'يبدو أنه لا يوجد محتوى لعرضه في الوقت الحالي.',
                  style: TextStyle(
                    color: AppTheme.textGray,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => viewModel.refreshNews(),
                  icon: const Icon(Icons.refresh, size: 20),
                  label: const Text('تحديث الصفحة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: AppTheme.darkBackground,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// حالة الخطأ - تصميم احترافي
  Widget _buildErrorState(BuildContext context, NewsViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline,
              color: Color(0xFFEF4444),
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'حدث خطأ أثناء تحميل الأخبار',
            style: TextStyle(
              color: AppTheme.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              viewModel.errorMessage,
              style: const TextStyle(
                color: AppTheme.textGray,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => viewModel.retryLoadNews(),
            icon: const Icon(Icons.refresh, size: 20),
            label: const Text('إعادة محاولة'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: AppTheme.darkBackground,
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// عند الضغط على خبر
  void _onNewsTapped(BuildContext context, NewsModel news) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          news.title,
          style: const TextStyle(
            color: AppTheme.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.cardBackground,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
        ),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
