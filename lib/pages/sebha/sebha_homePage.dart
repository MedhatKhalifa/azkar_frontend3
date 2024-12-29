import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sebha_controller.dart';

class SebhaHomePage extends StatelessWidget {
  final SebhaController controller = Get.put(SebhaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with transparency
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sky.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // Adjust transparency level
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Content over the background
          Column(
            children: [
              // Custom AppBar with back button
              Container(
                height: 100,
                padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.black26,
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        controller.fetchAzkar();
                        Navigator.pop(context);
                      },
                    ),
                    // Title
                    Expanded(
                      child: Center(
                        child: Text(
                          'tasbih'.tr, // Localized title
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black54,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Placeholder for alignment
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Obx(() {
                  return Stack(
                    children: [
                      // Main Content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Current Zekr Information
                            if (controller.selectedZekr.value != null) ...[
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  double fontSize = 40; // Default font size
                                  final text =
                                      controller.selectedZekr.value!['name'];
                                  // Adjust font size based on text length
                                  if (text.length > 20) {
                                    fontSize =
                                        30; // Reduce font size for longer text
                                  } else if (text.length > 40) {
                                    fontSize =
                                        24; // Further reduce font size for very long text
                                  }

                                  return SizedBox(
                                    width: constraints.maxWidth *
                                        0.9, // Allow some padding
                                    child: Text(
                                      text,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'myarabic',
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFDAA520),
                                      ),
                                      maxLines: 2, // Limit text to two lines
                                      overflow: TextOverflow
                                          .ellipsis, // Add ellipsis for overflow
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 20),

                              // Image Button with Animation
                              AnimatedImageButton(
                                onTap: controller.incrementCount,
                                imagePath:
                                    'assets/images/moon.png', // Path to your moon image
                              ),
                              const SizedBox(height: 20),

                              // Counts below the image
                              Text(
                                '${'current'.tr}: ${controller.currentCount.value}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${'cumulative'.tr}: ${controller.selectedZekr.value!['accumulativeCount']}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      // Reset Button Positioned Top Right
                      Positioned(
                        top: 30,
                        right: 20,
                        child: ElevatedButton(
                          onPressed: () => _showResetWarning(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12), // Smaller size
                          ),
                          child: Text(
                            'reset'.tr,
                            style: const TextStyle(
                              fontSize: 14, // Smaller font size
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showResetWarning(BuildContext context) {
    Get.defaultDialog(
      title: 'warning'.tr,
      middleText: 'confirm_reset'.tr,
      textCancel: 'cancel'.tr,
      textConfirm: 'yes'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // Close the dialog
        Get.find<SebhaController>().resetCurrentCount();
      },
    );
  }
}

class AnimatedImageButton extends StatefulWidget {
  final VoidCallback onTap;
  final String imagePath;

  const AnimatedImageButton({
    required this.onTap,
    required this.imagePath,
  });

  @override
  _AnimatedImageButtonState createState() => _AnimatedImageButtonState();
}

class _AnimatedImageButtonState extends State<AnimatedImageButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.15).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _controller.forward().then((_) => _controller.reverse());
      },
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 300, // Larger size for the moon
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(5, 5),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(-5, -5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
