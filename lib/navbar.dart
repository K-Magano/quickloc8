// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:quickloc8/map_screen.dart';
// import 'package:quickloc8/message_screen.dart'; // Import MessageScreen

// class NavBar extends StatelessWidget {
//   const NavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());

//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () => NavigationBar(
//           height: 80,
//           elevation: 2,
//           selectedIndex: controller.selectedIndex.value,
//           onDestinationSelected: (index) =>
//               controller.selectedIndex.value = index,
//           destinations: const [
//             NavigationDestination(icon: Icon(Iconsax.map), label: "Map"),
//             NavigationDestination(
//                 icon: Icon(Icons.message),
//                 label: "Message"), // Use Icons.message for consistency
//           ],
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }

// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;

//   final screens = [
//     const MapScreen(),
//     const MessageScreen(), // Add MessageScreen to the list
//   ];
// }
