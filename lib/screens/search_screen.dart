import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TitlesTextWidget(
          label: 'Serach Screen',
          fontSize: 50,
        ),
      ),
    );
  }
}
