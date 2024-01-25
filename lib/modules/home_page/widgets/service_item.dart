import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final IconData icon;
  const ServiceItem({
    super.key,
    required this.onPress,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.25),
                spreadRadius: 0.1,
                blurRadius: 10,
                // changes position of shadow
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.blue,
                size: 40,
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
