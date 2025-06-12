import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const Color buttonShadow = Color(0xFFD9D9D9);
  static const Color textColor = Color(0xFF444444);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.HomePageColor,
      appBar: AppBar(
        backgroundColor: AppColors.drawerColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.purple),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: SettingsPage.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Settings Buttons
            _SettingsButton(
              icon: Icons.edit,
              label: "Personalisation",
              onTap: () {},
            ),
            _SettingsButton(
              icon: Icons.notifications_none,
              label: "Notifications",
              onTap: () {},
            ),
            _SettingsButton(
              icon: Icons.lock_outline,
              label: "Privacy & Security",
              onTap: () {},
            ),
            _SettingsButton(
              icon: Icons.person_outline,
              label: "Account",
              onTap: () {},
            ),
            _SettingsButton(
              icon: Icons.help_outline,
              label: "Help & support",
              onTap: () {},
            ),
            const Spacer(),
            // Bottom Illustration using OTPbottom.png
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Image.asset(
                'lib/imagesOrlogo/OTPbottom.png', 
                //height: 120,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingsButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  static const Color buttonShadow = Color(0xFFD9D9D9);
  static const Color textColor = Color(0xFF444444);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.drawerColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: buttonShadow,
                blurRadius: 4,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.purple, size: 22),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}