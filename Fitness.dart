import 'package:flutter/material.dart';
import 'package:gsc_project/colors/app_colors.dart';
import 'package:gsc_project/main.dart';

void main() {
  runApp(const MyApp());
}

class FitnessPage extends StatelessWidget {
  const FitnessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text(
                    "Fitness",
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Stats Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFE2E0F0),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 4)
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.directions_walk, color: Color(0xFF37775D)),
                        SizedBox(width: 8),
                        Text("6,589 steps", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Color(0xFF594087)),
                        SizedBox(width: 8),
                        Text("60 mins", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.local_fire_department, color: Color(0xFFD4859E)),
                        SizedBox(width: 8),
                        Text("145 kcal", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 16),
                    CircularProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.grey.shade300,
                      color: Color(0xFF37775D),
                      strokeWidth: 6,
                    ),
                    SizedBox(height: 8),
                    Text("75% Daily goal"),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Sleep Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFE2E0F0),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 4)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sleep", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("8h 00m", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF594087),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "22:00 - 6:00",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFA176C8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Record this time",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Buttons
              buildActivityButton(Icons.fitness_center, "Exercise", Color(0xFFD4859E)),
              SizedBox(height: 12),
              buildActivityButton(Icons.self_improvement, "Yoga", Color(0xFFD485A0)),
              SizedBox(height: 12),
              buildActivityButton(Icons.spa, "Meditation", Color(0xFFFFBDC8)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActivityButton(IconData icon, String label, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4)
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
