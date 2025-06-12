import 'package:flutter/material.dart';
import 'package:gsc_project/pages/addGroups.dart';

class ChatGroupsPage extends StatelessWidget {
  const ChatGroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example group data structure (replace with your backend data)
    final group = {
      "title": "Morning walk",
      "subtitle": "Meet at gate",
      "time": "5.30 a.m",
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=facearea&w=256&h=256&facepad=2"
    };

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hi, S. K Dogra",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF444444),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF5A4087)),
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.search, size: 22, color: Color(0xFF5A4087)),
                      ),
                    ), 
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF5A4087)),
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.more_vert, size: 22, color: Color(0xFF5A4087)),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            // Tabs Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5A4087),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "All Groups",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Color(0xFF5A4087)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Communities",
                    style: TextStyle(
                        color: Color(0xFF5A4087),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Single group chat tile as shown in image
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFF5A4087), width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: ListTile(
                onTap: () {
                  // Navigate to group chat page
                },
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(group["image"]!),
                  radius: 24,
                ),
                title: Text(
                  group["title"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF444444),
                  ),
                ),
                subtitle: Text(
                  group["subtitle"]!,
                  style: const TextStyle(color: Color(0xFF444444)),
                ),
                trailing: Text(
                  group["time"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF444444),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5A4087),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
        onPressed: () {
          // Navigate to another page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGroupsPage()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}