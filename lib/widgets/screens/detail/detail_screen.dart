import 'package:flutter/widgets.dart';

class DetailScreen extends StatelessWidget {
  static const String route = "DetailScreen";

  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(route));
  }
}
