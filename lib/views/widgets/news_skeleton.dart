import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

/// تأثير تحميل هيكلي (Skeleton/Shimmer Loading) احترافي للبطاقات
class NewsSkeleton extends StatefulWidget {
  const NewsSkeleton({super.key});

  @override
  State<NewsSkeleton> createState() => _NewsSkeletonState();
}

class _NewsSkeletonState extends State<NewsSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.2, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.textDarkGray.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الهيكل
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppTheme.textDarkGray.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),

              // محتوى الهيكل
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الفئة والوقت
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 24,
                          width: 70,
                          decoration: BoxDecoration(
                            color: AppTheme.textDarkGray.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          height: 14,
                          width: 50,
                          color: AppTheme.textDarkGray.withOpacity(0.5),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // العنوان
                    Container(
                      height: 18,
                      width: double.infinity,
                      color: AppTheme.textDarkGray.withOpacity(0.5),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 18,
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: AppTheme.textDarkGray.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    // التاريخ والسهم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 14,
                          width: 100,
                          color: AppTheme.textDarkGray.withOpacity(0.5),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppTheme.textDarkGray.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
