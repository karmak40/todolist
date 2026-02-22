import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  final String greeting;
  final String? avatarUrl;
  final VoidCallback? onProfileTap;

  const UserHeader({
    super.key,
    required this.userName,
    required this.greeting,
    this.avatarUrl,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProfileTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppConstants.cardBackgroundColor,
            backgroundImage:
                avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null
                ? const Icon(
                    Icons.person,
                    size: 40,
                    color: AppConstants.textSecondary,
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.accentColor,
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppConstants.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
