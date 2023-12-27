import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final bool isLocked;
  final bool questionOption;
  final VoidCallback onTap;
  final String title;
  const OptionCard({
    super.key,
    required this.isLocked,
    required this.questionOption,
    required this.onTap, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //stopTime();
        // if (!myquestions.isLocked) {
        //   setState(() {
        //     myquestions.isLocked = true;
        //     myquestions
        //             .selectedWiidgetOption =
        //         questionOption;
        //   });

        //   isLocked = myquestions.isLocked;
        //   if (myquestions
        //       .selectedWiidgetOption
        //       .isCorrect) {
        //     score++;
        //   }
        // }
        onTap.call();
      },
      child: Container(
        height: 45,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: questionOption ? Colors.green : Colors.red),
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            isLocked == true
                ? questionOption
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
