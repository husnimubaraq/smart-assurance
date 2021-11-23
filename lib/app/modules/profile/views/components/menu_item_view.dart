import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/modules/profile/controllers/profile_controller.dart';

class MenuItemView extends GetView<ProfileController> {
  MenuItemView(this.label, this.icon, this.onTap);
  final String label;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(icon, color: Colors.grey, size: 18),
                ),
                Text(
                  label,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.black87),
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey, size: 18)
          ],
        ),
      ),
    );
  }
}
