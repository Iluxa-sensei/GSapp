import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Карта",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.book, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/book');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Row(
              children: [
                Icon(Icons.error, color: Colors.red, size: 24),
                SizedBox(width: 8),
                Text(
                  "Найдено 'n' угрозы",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Увеличенная картинка с округленными углами
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'lib/assets/map_image.png', // Замените на путь к вашей картинке
                width: double.infinity,
                height: 400, // Увеличенная высота
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Текст "Локация 1"
            Text(
              "Локация 1",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Spacer(),

            // Увеличенная кнопка "Добавить локацию"
            ElevatedButton(
              onPressed: () {
                // Логика добавления локации
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF59D759),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(
                    double.infinity, 70), // Увеличенная высота кнопки
              ),
              child: Text(
                "Запись с дрона",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
