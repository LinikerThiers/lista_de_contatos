import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';

class ListaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? userName;
  final String? profileImagePath;

  const ListaAppBar({
    super.key,
    required this.userName,
    this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return AppBar(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      surfaceTintColor: isDarkMode ? Colors.grey[900] : Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                profileImagePath != null && profileImagePath!.isNotEmpty
                    ? FileImage(File(profileImagePath!)) as ImageProvider
                    : null,
            radius: 20,
            backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[300],
            child: profileImagePath == null || profileImagePath!.isEmpty
                ? Icon(
                    Icons.person,
                    color: isDarkMode ? Colors.white : Colors.black,
                    size: 24,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Text(
            "${"OLA".tr()} ${(userName ?? '').isEmpty ? "User" : userName}",
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          height: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
