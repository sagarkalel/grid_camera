import 'package:flutter/material.dart';
import 'package:grid_camera/src/extensions.dart';

import 'gap.dart';

class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget(this.requestForPermission, {super.key});
  final VoidCallback requestForPermission;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 95,
        color: const Color(0xFFFFEABC),
        child: Row(
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 28,
              color: Theme.of(context).primaryColor,
            ),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enable Permission",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Theme.of(context).primaryColor)),
                Text(
                  "Enable camera permission. Without this, camera won't work.",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ).expand,
            const Gap(24),
            InkWell(
              onTap: () => requestForPermission(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 1.5,
                      color: Theme.of(context).primaryColor,
                    )),
                child: Text("Enable now",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).primaryColor)),
              ),
            ),
          ],
        ).padXXDefault,
      ),
    );
  }
}
