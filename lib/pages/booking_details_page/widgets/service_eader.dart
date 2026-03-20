import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scheduly/utils.dart/utils.dart';

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

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.28,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          CachedNetworkImage(
            imageUrl:
                "https://images.unsplash.com/photo-1620733723572-11c53f73a416?q=80&w=687&auto=format&fit=crop",
            fit: BoxFit.cover,
            placeholder:
                (context, url) =>
                    Container(color: theme.colorScheme.surfaceContainerHighest),
            errorWidget:
                (context, url, error) => Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    icon,
                    size: 48,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
          ),

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
                Row(
                  children: [
                    GlassButton(
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),

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
                      Icon(icon, size: 12, color: theme.colorScheme.onPrimary),
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
    );
  }
}

class GlassButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const GlassButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: applyOpacity(Colors.white, 0.18),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: applyOpacity(Colors.white, 0.25), width: 1),
        ),
        child: Center(child: child),
      ),
    );
  }
}
