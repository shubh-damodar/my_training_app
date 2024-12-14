import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_training_app/features/dashboard/data/models/training_model.dart';
import 'package:my_training_app/utils/custom_text.dart';

class SummeryOfTrainingScreen extends StatelessWidget {
  final Training training;
  const SummeryOfTrainingScreen({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(training.trainingName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(training.backgroundImage),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    training.highlight,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${training.trainingName} (${training.rating})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(training.profileImage),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            training.trainer,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(training.work),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(training.address),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      if (training.offerPrice != training.price)
                        Text(
                          '${training.price}  ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 1,
                            decorationColor: Colors.red,
                          ),
                        ),
                      CustomText(
                        text: training.offerPrice,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Enroll Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
