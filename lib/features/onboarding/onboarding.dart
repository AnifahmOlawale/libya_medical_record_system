import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:lottie/lottie.dart';
import '../../core/shared/theme/app_colors.dart'; // Adjust path as needed

class OnboardingItem {
  final String title;
  final String subtitle;

  /// Can be a Lottie JSON path ('assets/lottie/health.json')
  /// or an Image path ('assets/images/onb1.jpeg')
  final String assetPath;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.assetPath,
  });
}

class OnboardingPage extends StatefulWidget {
  final VoidCallback? onGetStarted;
  const OnboardingPage({super.key, this.onGetStarted});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  int _currentPage = 0;

  // Dedicated controller for text entrance dynamics
  late final AnimationController _textAnimationController;
  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _textScale;

  final List<OnboardingItem> _items = const [
    OnboardingItem(
      title: 'Centralized Medical Records',
      subtitle:
          'Access, organize, and share your complete health history securely in one place.',
      assetPath: 'assets/images/onb1.jpeg',
    ),
    OnboardingItem(
      title: 'Monitor Your Vitals',
      subtitle:
          'Keep track of your daily health trends, vitals, and wellness progress effortlessly.',
      assetPath: 'assets/images/onb2.jpg',
    ),
    OnboardingItem(
      title: 'Smart Health Alerts',
      subtitle:
          'Never miss a dose or doctor’s visit with timely, personalized notifications.',
      assetPath: 'assets/images/onb3.jpeg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Text Transition Setup (Scale + Fade + Upward Slide)
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    _textFade = CurvedAnimation(
      parent: _textAnimationController,
      curve: const Interval(0.0, 0.85, curve: Curves.easeOut),
    );

    _textSlide = CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeOutCubic,
    );

    _textScale = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    _textAnimationController.forward();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });

    // Reset and replay polished text animation on page change
    _textAnimationController.reset();
    _textAnimationController.forward();
  }

  void _nextPage() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _onGetStarted();
    }
  }

  void _skip() {
    _pageController.animateToPage(
      _items.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onGetStarted() {
    widget.onGetStarted?.call();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  /// Modern animated text wrapper combining scale, fade, and translation
  Widget _buildAnimatedText({required Widget child, double offsetAmount = 24}) {
    return AnimatedBuilder(
      animation: _textAnimationController,
      builder: (context, _) {
        return Opacity(
          opacity: _textFade.value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: _textScale.value,
            child: Transform.translate(
              offset: Offset(0, offsetAmount * (1 - _textSlide.value)),
              child: child,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMediaAsset(String assetPath) {
    final isJson = assetPath.toLowerCase().endsWith('.json');

    if (isJson) {
      return Lottie.asset(assetPath, fit: BoxFit.cover);
    }

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final containerHeight = screenHeight * 0.48;
    final isLastPage = _currentPage == _items.length - 1;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // ── Full-Bleed Image PageView ───────────────
          Positioned.fill(
            bottom: containerHeight - 28,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _buildMediaAsset(_items[index].assetPath);
              },
            ),
          ),

          // ── Static Bottom White Container ────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              height: containerHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // Indicators & Skip Button Row
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _items.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                height: 8,
                                width: _currentPage == index ? 28 : 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? AppColors.primary
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),

                          if (!isLastPage)
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: _skip,
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Enhanced Title Animation
                      _buildAnimatedText(
                        offsetAmount: 20,
                        child: Text(
                          _items[_currentPage].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                height: 1.2,
                              ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Enhanced Subtitle Animation
                      _buildAnimatedText(
                        offsetAmount: 14,
                        child: Text(
                          _items[_currentPage].subtitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 17,
                                color: AppColors.textSecondary,
                                height: 1.45,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ],
                  ),

                  // Completely Static Action Button (No entrance animation)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: AppPrimaryButton(
                      label: isLastPage ? 'Get Started' : 'Next',
                      onPressed: _nextPage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
