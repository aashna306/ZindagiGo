import 'package:flutter/material.dart';
import 'package:gsc_project/colors/app_colors.dart';
import 'package:gsc_project/pages/Zoom_page.dart';
import '../services/auth_service.dart';
import 'package:gsc_project/pages/chat_page.dart';
import 'welcome_page.dart';
import 'package:torch_light/torch_light.dart';
import 'package:gsc_project/pages/Entertainment.dart';
import 'package:gsc_project/pages/Fitness.dart';
import 'package:gsc_project/pages/MedicalRecords.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout(BuildContext context) async {
    await AuthService().signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => WelcomePage()));
  }

  bool isTorchOn = false;

  Future<void> toggleTorch() async {
    try {
      if (isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        isTorchOn = !isTorchOn;
      });
    } catch (e) {
      print("Torch Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.HomePageColor,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
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
                  IconButton(
                    icon: Image.asset(
                      'lib/imagesOrlogo/Home.png',
                      width: 54,
                      height: 53,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      'lib/imagesOrlogo/Notification.png',
                      width: 49,
                      height: 55,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
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
                logout(context);
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Container(
                    width: 350,
                    height: 130,
                    decoration: BoxDecoration(
                      color: AppColors.ReminderBox,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Main Column for Text and Icons
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF5F5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Holla Amigo:)",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF5F5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "paracetamol",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Left Icon (Pill)
                        Positioned(
                          left: 20,
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E0F0),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFFFF5F5),
                                width: 6,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'lib/imagesOrlogo/pill.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ),

                        // Right Icon (Checkmark)
                        Positioned(
                          right: 20,
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E0F0),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFFFF5F5),
                                width: 6,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'lib/imagesOrlogo/Done.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MedicalRecords()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.zero,
                          elevation: 4,
                        ),
                        child: Container(
                          width: 100,
                          height: 114,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF5F5), 
                            borderRadius: BorderRadius.circular(20),
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFD4859E), 
                                width: 4, 
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/imagesOrlogo/MedicalRecords.png',
                                height: 40,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Medical Records",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FitnessPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.zero,
                          elevation: 4,
                        ),
                        child: Container(
                          width: 100,
                          height: 114,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF5F5),
                            borderRadius: BorderRadius.circular(20),
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFD4859E), 
                                width: 4, 
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/imagesOrlogo/Yoga.png',
                                height: 40,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Fitness",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EntertainmentPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.zero,
                          elevation: 4,
                        ),
                        child: Container(
                          width: 100,
                          height: 114,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF5F5), 
                            borderRadius: BorderRadius.circular(20),
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFD4859E), 
                                width: 4, 
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/imagesOrlogo/YT.png',
                                height: 40,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Entertainment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF5F5), 
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFD4C3D4), 
                              width: 4, 
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            toggleTorch();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.zero,
                            elevation: 4,
                          ),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'lib/imagesOrlogo/Torch.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Torch",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF5F5), 
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFD4C3D4), 
                              width: 4, 
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ZoomPage()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.pressed)) {
                                return Color(0xFFD4C3D4); // Change color when pressed
                              } else if (states.contains(WidgetState.hovered)) {
                                return Color(0xFFD4C3D4); // Change color when hovered
                              }
                              return Color(0xFFFFF5F5); // Default color
                            }),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            elevation: WidgetStateProperty.resolveWith<double>((states) {
                              if (states.contains(WidgetState.pressed)) {
                                return 2; // Reduce elevation on press
                              }
                              return 4; // Default elevation
                            }),
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                          ),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'lib/imagesOrlogo/Zoom.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Zoom",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF5F5), 
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFD4C3D4), 
                              width: 4, 
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.zero,
                            elevation: 4,
                          ),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'lib/imagesOrlogo/Community.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Community",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF5F5), 
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFD4C3D4), 
                              width: 4, 
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.zero,
                            elevation: 4,
                          ),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'lib/imagesOrlogo/Bank.png', 
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Banking",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 70),
                  child: IconButton(
                    onPressed: () {
  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage()));
                    },
                    icon: Image.asset(
                      'lib/imagesOrlogo/Chatbot.png',
                      width: 76,
                      height: 66.503,
                    ),
                    iconSize: 76,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: 76,
                      minHeight: 66.503,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E0F0),
                  borderRadius: BorderRadius.circular(40),
                  border: const Border(
                    bottom: BorderSide(color: Color(0xFF2D2D2D), width: 1),
                  ),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                      icon: _buildNavBarIcon('lib/imagesOrlogo/profile.png'),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildNavBarIcon('lib/imagesOrlogo/phone.png'),
                      label: 'Phone',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildNavBarIcon('lib/imagesOrlogo/settings.png'),
                      label: 'Settings',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildNavBarIcon('lib/imagesOrlogo/Location.png'),
                      label: 'Location',
                    ),
                  ],
                ),
              ),
            ),

            // Floating Action Button (Reminder)
            Positioned(
              bottom: 75,
              left: MediaQuery.of(context).size.width / 2 - 34,
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: Color(0xFFD4859E),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                  border: Border.all(
                    color: Color(0xFFD4859E),
                    width: 1,
                  ),
                ),
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Image.asset(
                    'lib/imagesOrlogo/Reminder.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarIcon(String imagePath) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Color(0xFFFDF5F5),
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFD4859E), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
