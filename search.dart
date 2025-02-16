import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Состояние для выделения выбранного устройства
  String selectedDevice = 'Blurp V530';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '2 новых устройства',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Карточки устройств
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildDeviceCard(
                    deviceName: 'Blurp V530',
                    imagePath: 'lib/assets/drone1.png',
                    isSelected: selectedDevice == 'Blurp V530',
                    onTap: () {
                      setState(() {
                        selectedDevice = 'Blurp V530';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: _buildDeviceCard(
                    deviceName: 'Smart Slurp-2',
                    imagePath: 'lib/assets/drone2.png',
                    isSelected: selectedDevice == 'Smart Slurp-2',
                    onTap: () {
                      setState(() {
                        selectedDevice = 'Smart Slurp-2';
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Карточка для ручного выбора
            _buildManualSelectionCard(onTap: () {
              // Реализуйте переход на страницу ручного выбора
              print('Выбор вручную');
            }),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Логика добавления устройства
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF59D759),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: const Size(double.infinity, 70), // Увеличенная высота кнопки
            ),
            child: const Text(
              "Добавить устройство",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18, // Увеличенный текст
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Метод для создания карточки устройства
  Widget _buildDeviceCard({
    required String deviceName,
    required String imagePath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 160,
              height: 160,
            ),
            const SizedBox(height: 12),
            Text(
              deviceName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Метод для создания карточки ручного выбора
  Widget _buildManualSelectionCard({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/wifi.png', // Replace with your image path
              width: 40,
              height: 40,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            const Text(
              'Не найдено нужное?',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              'Выбрать вручную',
              style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
