import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/utils/hex_to_color.dart';

class MembersSearchField extends StatelessWidget {
  const MembersSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorExtension("CBCBCB"),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: ColorExtension("6F6F6F"),
            weight: 100,
            size: 20,
          ),
          hintText: 'Search ...',
          hintStyle: TextStyle(
            fontFamily: 'poppins',
            color: ColorExtension("6F6F6F"),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
