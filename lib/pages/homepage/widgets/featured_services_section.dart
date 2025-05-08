// import 'package:flutter/material.dart';
// import 'package:scheduly/models/service_model.dart';

// class FeaturedServicesSection extends StatelessWidget {
//   final List<ServiceModel> services;
//   final void Function(ServiceModel) onServiceTap;

//   const FeaturedServicesSection({
//     super.key,
//     required this.services,
//     required this.onServiceTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     if (services.isEmpty) {
//       return const SliverToBoxAdapter(child: SizedBox.shrink());
//     }

//     return SliverList(
//       delegate: SliverChildListDelegate([
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
//           child: Text(
//             'Featured Services',
//             style: theme.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 190, 
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             itemCount: services.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 8),
//             itemBuilder: (context, index) {
//               final service = services[index];
//               return SizedBox(
//                 width: 150,
//                 child: _ServiceCard(service: service, onTap: onServiceTap),
//               );
//             },
//           ),
//         ),
//       ]),
//     );
//   }
// }

// class _ServiceCard extends StatelessWidget {
//   final ServiceModel service;
//   final void Function(ServiceModel) onTap;

//   const _ServiceCard({required this.service, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(
//           color: theme.colorScheme.outline.withValues(alpha: 0.2),
//         ),
//       ),
//       child: InkWell(
//         onTap: () => onTap(service),
//         borderRadius: BorderRadius.circular(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(12),
//               ),
//               child: Image.network(
//                 "data:image/jpeg;base64,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",
//                 height: 90,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder:
//                     (_, __, ___) => Container(
//                       height: 90,
//                       color: theme.colorScheme.primary.withValues(alpha: 0.1),
//                       child: const Icon(Icons.image_not_supported, size: 28),
//                     ),
//               ),
//             ),
//             // Info
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     service.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: theme.textTheme.titleSmall?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Ksh ${service.price.toStringAsFixed(0)} • ${service.durationMinutes} min',
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       const Icon(Icons.star, size: 14, color: Colors.amber),
//                       const SizedBox(width: 4),
//                       Text(
//                         '${service.rating}',
//                         style: theme.textTheme.bodySmall?.copyWith(
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         ' (${service.reviewCount})',
//                         style: theme.textTheme.bodySmall?.copyWith(
//                           color: theme.colorScheme.onSurface.withValues(
//                             alpha: 0.6,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
