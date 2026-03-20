   import 'dart:ui';

import 'package:flutter/material.dart';

Color applyOpacity(Color color, double opacity) {
      return color.withValues(alpha: opacity);
  }

    IconData getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'massage':
        return Icons.spa;
      case 'haircut':
        return Icons.content_cut;
      case 'gym':
        return Icons.fitness_center;
      default:
        return Icons.calendar_today;
    }
  }