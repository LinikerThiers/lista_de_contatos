import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? profileImagePath;

  const ListaAppBar({
    super.key,
    required this.userName,
    this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                profileImagePath != null && profileImagePath!.isNotEmpty
                    ? AssetImage(profileImagePath!) as ImageProvider
                    : null,
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: profileImagePath == null || profileImagePath!.isEmpty
                ? const Icon(Icons.person, color: Colors.black, size: 24)
                : null,
          ),
          const SizedBox(width: 10),
          Text(
            "${"OLA".tr()} $userName",
            style: const TextStyle(
              color: Colors.black,
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
            color: Colors.grey[300],
            height: 1,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
