import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController npmController = TextEditingController();
  final TextEditingController jurusanController = TextEditingController();

  File? profileImage;

  String savedNama = '';
  String savedNpm = '';
  String savedJurusan = '';

  bool isSaved = false;

  Future<void> pilihFoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  void simpanData() {
    if (namaController.text.trim().isEmpty ||
        npmController.text.trim().isEmpty ||
        jurusanController.text.trim().isEmpty ||
        profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Lengkapi nama, NPM, jurusan, dan foto terlebih dahulu!',
          ),
        ),
      );
      return;
    }

    setState(() {
      savedNama = namaController.text;
      savedNpm = npmController.text;
      savedJurusan = jurusanController.text;
      isSaved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil disimpan!'),
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    npmController.dispose();
    jurusanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            GestureDetector(
              onTap: pilihFoto,
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.blue.shade100,
                backgroundImage:
                    profileImage != null ? FileImage(profileImage!) : null,
                child: profileImage == null
                    ? const Icon(
                        Icons.camera_alt,
                        size: 45,
                        color: Colors.blue,
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Tap foto untuk memilih foto profil',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                hintText: 'Masukkan nama',
                prefixIcon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: npmController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'NPM',
                hintText: 'Masukkan NPM',
                prefixIcon: const Icon(Icons.badge),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: jurusanController,
              decoration: InputDecoration(
                labelText: 'Jurusan',
                hintText: 'Masukkan jurusan',
                prefixIcon: const Icon(Icons.school),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: simpanData,
                icon: const Icon(Icons.save),
                label: const Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (isSaved)
              Card(
                color: Colors.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'DATA TERSIMPAN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 15),

                      CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(profileImage!),
                      ),

                      const SizedBox(height: 15),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nama: $savedNama',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'NPM: $savedNpm',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Jurusan: $savedJurusan',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}