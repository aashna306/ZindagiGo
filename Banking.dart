import 'package:flutter/material.dart';
import 'package:gsc_project/colors/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking Info App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const BankingInfoPage(),
    );
  }
}

class BankingInfoPage extends StatelessWidget {
  const BankingInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color palette from your screenshot
    const purple = Color(0xFF594087);
    const lightPurple = Color(0xFFC6AEE0);
    const lighterPurple = Color(0xFFE2E0F0);
    const green = Color(0xFF4CAF50);
    const black = Color(0xFF2D2D2D);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Center(
          child: Container(
            width: 370,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.navBarColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Builder(
                    builder: (context) {
                      return IconButton(
                        icon: Image.asset(
                          'lib/imagesOrlogo/Drawer.png',
                          width: 50,
                          height: 23,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: const Text(
                    "Banking Info",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.drawerColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            DrawerHeader(
              //decoration: BoxDecoration(color: AppColors.drawerColor),
              decoration: BoxDecoration(
                color: AppColors.drawerColor, // Make sure it blends with the drawer background
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.pink,
                      size: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "HELLO USER!!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // IconButton(
                  //   icon: const Icon(Icons.close),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.searchBar, // Background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "search...",
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Menu Items
            ListTile(
              leading: Image.asset(
                'lib/imagesOrlogo/home2.png',
                width: 30,
                height: 27,
              ),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Image.asset(
                'lib/imagesOrlogo/settings.png',
                width: 27,
                height: 27,
              ),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pushNamed(context, '/settingspage');
              },
            ),
            ListTile(
              leading: Image.asset(
                'lib/imagesOrlogo/Notification.png',
                width: 31,
                height: 32,
              ),
              title: const Text("Notifications"),
              onTap: () {
                Navigator.pushNamed(context, '/notificationpage');
              },
            ),
            ListTile(
              leading: Image.asset(
                'lib/imagesOrlogo/phone.png',
                width: 31,
                height: 32,
              ),
              title: const Text("Help Numbers"),
              onTap: () {
                Navigator.pushNamed(context, '/helpNumbers');
              },
            ),            
            ListTile(
              leading: Image.asset(
                'lib/imagesOrlogo/profile.png',
                width: 25,
                height: 26,
              ),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, '/profilepage');
              },
            ),
            ListTile(
              leading: Image.asset(
                'lib/imagesOrlogo/Logout.png',
                width: 35,
                height: 36,
              ),
              title: const Text("Logout"),
              onTap: () {
                //logout(context);
              },
            ),
            const Spacer(),
            // Light & Dark Mode Toggle
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Light mode action
                    },
                    icon: const Icon(Icons.light_mode, color: Colors.black),
                    label: const Text("Light"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.searchBar,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Dark mode action
                    },
                    icon: const Icon(Icons.dark_mode, color: Colors.white),
                    label: const Text("Dark"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Pension Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 22),
                      SizedBox(width: 8),
                      Text(
                        "₹6,500 received",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Received on: 28 March 2025",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(Icons.local_shipping, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Next Expected: 28 April 2025",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Pension History
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pension History (Last 6 months)",
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        child: Text("Mar 2025",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: Text("₹6,500",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: Text("Received",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Icon(Icons.check_circle, color: green, size: 18),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Expanded(
                        child: Text("Feb 2025",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: Text("₹6,500",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: Text("Received",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Icon(Icons.check_circle, color: green, size: 18),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Expanded(
                        child: Text("Jan 2025",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: Text("₹6,500",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: Text("Received",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Icon(Icons.check_circle, color: green, size: 18),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Text(
                        "see more ",
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: black, size: 18),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Scheme/Bank details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: lighterPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Scheme/Bank details",
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Scheme: IGNOAPS",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Ref ID: 1234-XXXX-6789",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Bank: SBI, Jalandhar Branch",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Info text
            const Text(
              "This info is locked from caregiver account.\nOnly you can see this.",
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            // Set/Change PIN button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  elevation: 2,
                ),
                child: const Text(
                  "Set/Change PIN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}