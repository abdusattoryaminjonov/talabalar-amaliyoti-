import 'package:flutter/material.dart';

class SimpleCarousel extends StatefulWidget {
  const SimpleCarousel({super.key});

  @override
  State<SimpleCarousel> createState() => _SimpleCarouselState();
}

class _SimpleCarouselState extends State<SimpleCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final String defaultImage =
      "";

  final List<Map<String, String>> items = [
    {
      "title": "NPUU Internship",
      "image":
      "https://images.unsplash.com/photo-1605902711622-cfb43c4437d1",
    },
    {
      "title": "Final Exam",
      "image": "https://drive.google.com/uc?export=view&id=1z0cT9kWafjhXAerb4RV--8wzoVIeW2hI",
    },
    {
      "title": "Our university",
      "image":
      "https://amaliyot.uznpu.uz/assets/login-left-YoyZJjYr.jpg",
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), autoScroll);
  }

  void autoScroll() {
    if (!mounted) return;

    _currentIndex = (_currentIndex + 1) % items.length;
    _controller.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 3), autoScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: items.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              final imageUrl = items[index]["image"] ?? "";

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/images/carouselImg.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      /// title
                      Positioned(
                        left: 16,
                        bottom: 16,
                        child: Text(
                          items[index]["title"] ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(items.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 12 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }
}
