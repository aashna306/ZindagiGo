import 'package:flutter/material.dart';
import 'package:gsc_project/colors/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MedicalRecords(),
    );
  }
}

class MedicalRecords extends StatelessWidget {
  const MedicalRecords({super.key});

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
                  child: const Text(
                    "Medical Records",
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
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.drawerColor,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: AppColors.pink,
                    size: 50,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "HELLO USER!!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.searchBar,
                  borderRadius: BorderRadius.circular(20),
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
            ListTile(
              leading: Image.asset(
                'lib/imagesOrlogo/home2.png',
                width: 30,
                height: 27,
              ),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/homepage');
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
                Navigator.pushNamed(context, '/logoutpage');
              },
            ),
            const Spacer(),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: AppColors.navBarColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('lib/imagesOrlogo/user.png'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "S. K. Dogra",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Gender: Male    Age: 80"),
                        Text("Weight: 72 Kg    Blood Type: AB+"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 70, // Increased height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: const Border(
                    bottom: BorderSide(color: Color(0xFF2D2D2D), width: 1),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Upload action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Upload,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Upload",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'lib/imagesOrlogo/Upload.png',
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildGridButton("Allergies", Icons.medical_services),
                  _buildGridButton("Prescriptions", Icons.receipt),
                  _buildGridButton("Medical History", Icons.history),
                  _buildGridButton("Hospitalizations", Icons.local_hospital),
                  _buildGridButton("Vaccinations", Icons.vaccines),
                  _buildGridButton("Procedures", Icons.medical_services),
                  _buildGridButton("Test Reports", Icons.report),
                  _buildGridButton("Dr.'s Contacts", Icons.contact_phone),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildGridButton(String title, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        // Button action
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        elevation: 5,
        shadowColor: Colors.black12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.black),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}