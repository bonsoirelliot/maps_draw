import 'package:flutter/material.dart';
import 'package:map_draw/sections/support/padded_text.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ...paddedText(
                [
                  'Для корректной работы приложения необходим смартфон с минимальными системными требованиями:',
                  'Android 5 или iOS 12',
                  'Чтобы создать фигуру, откройте настройки (иконка шестеренки) -> выберите "Список всех фигур" -> "Создать новую фигуру"',
                  'Чтобы добавить точку, нажмите кнопку с иконкой "Плюс"',
                  'Чтобы удалить точку, нажмите кнопку с иконкой "Корзина"',
                  'Чтобы обновить местоположение, нажмите кнопку с  иконкой "Навигация"',
                  'Смена цвета и названия фигур также происходит в поп-апе настроек (иконка шестеренки)',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
