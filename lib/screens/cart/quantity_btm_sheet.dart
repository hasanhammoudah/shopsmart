import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 25,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: SubTitleTextWidget(
                        label: '${index + 1}',
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
