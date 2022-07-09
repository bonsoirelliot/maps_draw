import 'package:flutter/material.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/theme/styles.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: StaticData.defaultPadding,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  const Icon(Icons.help_outline_rounded),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Экран справки'.toUpperCase(),
                    style: AppStyles.h5,
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              const Text(
                'Тут будет какой-то текст о приложении и о том, что оно делает ',
                style: AppStyles.h5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
