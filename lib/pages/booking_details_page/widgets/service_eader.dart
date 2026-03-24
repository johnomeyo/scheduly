import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServiceHeader extends StatelessWidget {
  final String serviceName;
  final String title;

  final IconData icon;
  final ThemeData theme;

  const ServiceHeader({
    super.key,
    required this.serviceName,
    required this.icon,
    required this.theme,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              "https://plus.unsplash.com/premium_photo-1661542350224-8e3f095ce053?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8YmFyYmVyc2hvcHxlbnwwfHwwfHx8MA%3D%3D",
            ),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Content
            Padding(
              padding: EdgeInsets.only(
                top: topPadding + 12,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  // Service chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 5),
                        Text(
                          serviceName.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Main title
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

