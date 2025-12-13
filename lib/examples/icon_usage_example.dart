// "// Example of how to use Font Awesome and Lucide Icons
//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:lucide_icons/lucide_icons.dart';
//
// class IconUsageExample extends StatelessWidget {
//   const IconUsageExample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Icon Usage Examples'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Font Awesome Icons:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 FaIcon(FontAwesomeIcons.house, size: 30),
//                 const SizedBox(width: 16),
//                 FaIcon(FontAwesomeIcons.user, size: 30),
//                 const SizedBox(width: 16),
//                 FaIcon(FontAwesomeIcons.heart, size: 30),
//                 const SizedBox(width: 16),
//                 FaIcon(FontAwesomeIcons.gear, size: 30),
//                 const SizedBox(width: 16),
//                 FaIcon(FontAwesomeIcons.bell, size: 30),
//               ],
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'Lucide Icons:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Icon(LucideIcons.home, size: 30),
//                 const SizedBox(width: 16),
//                 Icon(LucideIcons.user, size: 30),
//                 const SizedBox(width: 16),
//                 Icon(LucideIcons.heart, size: 30),
//                 const SizedBox(width: 16),
//                 Icon(LucideIcons.settings, size: 30),
//                 const SizedBox(width: 16),
//                 Icon(LucideIcons.bell, size: 30),
//               ],
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'Usage in your code:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               '// Font Awesome:\n'
//               'FaIcon(FontAwesomeIcons.iconName)\n\n'
//               '// Lucide:\n'
//               'Icon(LucideIcons.iconName)',
//               style: TextStyle(fontFamily: 'monospace'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// "