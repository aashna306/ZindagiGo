import 'package:flutter/material.dart';

class AddGroupsPage extends StatefulWidget {
  const AddGroupsPage({Key? key}) : super(key: key);

  @override
  State<AddGroupsPage> createState() => _AddGroupsPageState();
}

class _AddGroupsPageState extends State<AddGroupsPage> {
  bool isPrivate = true;
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController membersController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;

  final List<String> categories = [
    "Health",
    "Education",
    "Sports",
    "Music",
    "Travel",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6ECEC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text(
                "Create a new...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF444444),
                ),
              ),
              const SizedBox(height: 24),
              // Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => isPrivate = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                      decoration: BoxDecoration(
                        color: isPrivate ? const Color(0xFF5A4087) : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFF5A4087)),
                      ),
                      child: Text(
                        "Private Group",
                        style: TextStyle(
                          color: isPrivate ? Colors.white : const Color(0xFF5A4087),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => setState(() => isPrivate = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                      decoration: BoxDecoration(
                        color: !isPrivate ? const Color(0xFF5A4087) : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFF5A4087)),
                      ),
                      child: Text(
                        "Community",
                        style: TextStyle(
                          color: !isPrivate ? Colors.white : const Color(0xFF5A4087),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Group image and name
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF5A4087), width: 2),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.photo_camera_outlined, color: Color(0xFF5A4087), size: 32),
                      onPressed: () {
                        // Pick image logic
                      },
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: TextField(
                      controller: groupNameController,
                      decoration: const InputDecoration(
                        hintText: "Name the group",
                        hintStyle: TextStyle(
                          color: Color(0xFF5A4087),
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5A4087), width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5A4087), width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5A4087), width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF444444),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Add members
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add members",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFF444444),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: membersController,
                      decoration: InputDecoration(
                        hintText: "Required more than 2",
                        hintStyle: const TextStyle(
                          color: Color(0xFF444444),
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Color(0xFF5A4087)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Color(0xFF5A4087)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Color(0xFF5A4087), width: 2),
                        ),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF444444),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF5A4087),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        // Add member logic
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Description
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFF444444),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: "Add a short description about this group",
                  hintStyle: const TextStyle(
                    color: Color(0xFF444444),
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF5A4087)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF5A4087)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF5A4087), width: 2),
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF444444),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              // Category
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Category",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFF444444),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                hint: const Text(
                  "eg. Health",
                  style: TextStyle(
                    color: Color(0xFF444444),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                items: categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => selectedCategory = val),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF5A4087)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF5A4087)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF5A4087), width: 2),
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF444444),
                  fontWeight: FontWeight.w500,
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF5A4087)),
              ),
              const SizedBox(height: 32),
              // Create Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Create group logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A4087),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}