import 'package:fast8_test/modules/profile/page/profile_detail.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.keyboard_arrow_left_rounded),
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text("U"),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Masuk reguler dengan email",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildMenuItem(
            context,
            icon: Icons.person,
            label: "Informasi Pribadi",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformasiPribadiPage()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.lock,
            label: "Ubah Password",
          ),
          _buildMenuItem(context,
              icon: Icons.description, label: "Syarat & Ketentuan"),
          _buildMenuItem(context, icon: Icons.help, label: "Bantuan"),
          _buildMenuItem(context,
              icon: Icons.privacy_tip, label: "Kebijakan Privasi"),
          _buildMenuItem(context, icon: Icons.logout, label: "Log Out"),
          _buildMenuItem(context, icon: Icons.delete, label: "Hapus Akun"),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon, required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.grey[700]),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
