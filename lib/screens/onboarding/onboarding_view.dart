import 'package:flutter/material.dart';
import '../../core/styles/app_colors.dart';
import 'onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingModel> _pages = const [
    OnboardingModel(
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Discover Movies',
      description:
          'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease',
    ),
    OnboardingModel(
      imagePath: 'assets/images/onboarding_2.png',
      title: 'Explore All Genres',
      description:
          'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/onboarding_3.png',
      title: 'Create Watchlists',
      description:
          'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/onboarding_4.png',
      title: 'Rate, Review, and Learn',
      description:
          'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/onboarding_5.png',
      title: 'Start Watching Now',
      description: '',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemCount: _pages.length,
            itemBuilder: (context, index) =>
                OnboardingPage(data: _pages[index]),
          ),

          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == i ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == i
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex < _pages.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, 'login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _currentIndex == _pages.length - 1 ? "Finish" : "Next",
                      style: const TextStyle(
                        color: AppColors.buttonText,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                if (_currentIndex > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () => _controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
