import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../models/user.dart';
import '../constants/app_constants.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  final User user;
  final Function(User) onUserUpdated;
  final StorageService storageService;

  const SettingsScreen({
    super.key,
    required this.user,
    required this.onUserUpdated,
    required this.storageService,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController nameController;
  late String? selectedAvatarPath;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    selectedAvatarPath = widget.user.avatarUrl;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedFile != null) {
        setState(() {
          selectedAvatarPath = pickedFile.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при загрузке фото: $e')),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedFile != null) {
        setState(() {
          selectedAvatarPath = pickedFile.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при съемке фото: $e')),
      );
    }
  }

  Future<void> _saveSettings() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите имя')),
      );
      return;
    }

    final updatedUser = widget.user.copyWith(
      name: nameController.text,
      avatarUrl: selectedAvatarPath,
    );

    await widget.storageService.saveUser(updatedUser);
    widget.onUserUpdated(updatedUser);

    if (!mounted) return;
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Настройки сохранены'),
        duration: Duration(milliseconds: 1500),
      ),
    );

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppConstants.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Настройки профиля',
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppConstants.accentColor,
                        width: 2,
                      ),
                    ),
                    child: selectedAvatarPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              File(selectedAvatarPath!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              color: AppConstants.cardBackgroundColor,
                              child: const Icon(
                                Icons.person,
                                size: 60,
                                color: AppConstants.textSecondary,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Загрузить'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.accentColor,
                          foregroundColor: AppConstants.backgroundColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: _takePhoto,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Камера'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.accentColor,
                          foregroundColor: AppConstants.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Name section
            const Text(
              'Имя пользователя',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              style: const TextStyle(
                color: AppConstants.textColor,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Введите ваше имя',
                hintStyle: const TextStyle(
                  color: AppConstants.textSecondary,
                ),
                filled: true,
                fillColor: AppConstants.cardBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppConstants.accentColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppConstants.textSecondary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppConstants.accentColor,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 32),
            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.accentColor,
                  foregroundColor: AppConstants.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Сохранить',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
