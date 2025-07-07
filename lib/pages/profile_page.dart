import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTitle(),
              const SizedBox(height: 10),
              _buildProfileCard(width),
              const SizedBox(height: 10),
              _buildEmergencyContacts(),
              const SizedBox(height: 10),
              _buildHealthSummary(),
              const SizedBox(height: 10),
              _buildAppPreferences(),
              const SizedBox(height: 10),
              _buildCaretakerAccess(),
              const SizedBox(height: 20),
              _buildEditLogoutButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF5A4087)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Profile",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5A4087),
        ),
      ),
    );
  }

  Widget _buildProfileCard(double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFD5DD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.black,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("S.K Dogra", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Male - 80yrs"),
                Text("9999988888"),
                Text("O positive"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContacts() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFD485A0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Emergency Contacts",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("1)Name (daughter)", style: TextStyle(color: Colors.white)),
            Text("9494949494", style: TextStyle(color: Colors.white)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("2)Name (daughter)", style: TextStyle(color: Colors.white)),
            Text("9494949494", style: TextStyle(color: Colors.white)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("3)Name (daughter)", style: TextStyle(color: Colors.white)),
            Text("9494949494", style: TextStyle(color: Colors.white)),
          ]),
        ],
      ),
    );
  }

  Widget _buildHealthSummary() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFE2E0F0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF5A4087), width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Text(
              "Health Summary\n\nLast Update: 22/07/2024",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("**Conditions**", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Arthritis, High BP, Diabetes"),
                SizedBox(height: 6),
                Text("**Allergies**", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Peanuts"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppPreferences() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFC6AEE0),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("App Preferences", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Language", style: TextStyle(fontWeight: FontWeight.w500)),
              Text("English"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Notification", style: TextStyle(fontWeight: FontWeight.w500)),
              Switch(value: true, onChanged: (_) {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaretakerAccess() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFE2E0F0),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Amit Dogra", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("0000000000"),
                Text("Last Login"),
                Text("22/03/2025 13:36:45"),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/caretaker.png'), // Replace with your image path
          ),
        ],
      ),
    );
  }

  Widget _buildEditLogoutButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF5A4087),
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: const Text("Edit Profile"),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF5A4087),
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {},
          icon: const Icon(Icons.logout),
          label: const Text("Logout"),
        ),
      ],
    );
  }
}
