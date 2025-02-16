import 'package:flutter/material.dart';

// Подключите экраны (замените пути на ваши файлы)
import 'map.dart'; // Экран карты
import 'search.dart'; // Экран поиска
import 'set.dart'; // Экран настроек
import 'dashed.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondScreen(),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _currentIndex = 0;

  // Список экранов для навигации
  final List<Widget> _screens = [
    SecondScreenHome(), // Главная страница с переключателями и ползунками
    SearchScreen(),
    ChatScreen(),// Экран поиска// Экран карты
    MapScreen(),
    SettingsScreen(),// Экран настроек
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Показ текущего экрана
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Текущий индекс
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Обновление текущего индекса
          });
        },
        type: BottomNavigationBarType.fixed, // Для фиксированного количества иконок
        selectedItemColor: Color(0xFF59D759), // Цвет активного элемента
        unselectedItemColor: Colors.grey, // Цвет неактивных элементов
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Главная",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Поиск",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "Чат-бот",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Зоны",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),
        ],
      ),
    );
  }
}




// Экран с переключателями и ползунками
class SecondScreenHome extends StatefulWidget {
  @override
  _SecondScreenHomeState createState() => _SecondScreenHomeState();
}

class _SecondScreenHomeState extends State<SecondScreenHome> {
  bool _blurpSwitch = true; // Переключатель Blurp
  bool _slurpSwitch = false; // Переключатель Smart Slurp

  double _speedValue = 70; // Значение скорости
  double _economyValue = 40; // Значение экономии заряда

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECECEC), // Цвет фона страницы
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Главное",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/a.png'), // Путь к изображению
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSwitchCard(
                            title: "Blurp V530",
                            isOn: _blurpSwitch,
                            onChanged: (value) {
                              setState(() {
                                _blurpSwitch = value;
                              });
                            },
                          ),
                          const SizedBox(width: 16),
                          _buildSwitchCard(
                            title: "Smart Slurp-2",
                            isOn: _slurpSwitch,
                            onChanged: (value) {
                              setState(() {
                                _slurpSwitch = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildRoundedSlider(
                        label: "Скорость",
                        value: _speedValue,
                        onChanged: (newValue) {
                          setState(() {
                            _speedValue = newValue;
                          });
                        },
                        iconPath: 'lib/assets/speed_icon.png',
                      ),
                      const SizedBox(height: 20),
                      _buildRoundedSlider(
                        label: "Экономия заряда",
                        value: _economyValue,
                        onChanged: (newValue) {
                          setState(() {
                            _economyValue = newValue;
                          });
                        },
                        iconPath: 'lib/assets/battery_icon.png',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchCard({
    required String title,
    required bool isOn,
    required ValueChanged<bool> onChanged,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Switch(
              value: isOn,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[300],
              onChanged: onChanged,
            ),
            const SizedBox(height: 10),
            Text(
              isOn ? "Вкл" : "Откл",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isOn ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    required String iconPath,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
      BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
      ),
      ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    label,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    Image.asset(
    iconPath,
    width: 32,
    height: 32,
    fit: BoxFit.cover,
    ),
    ],
    ),
    const SizedBox(height: 10),
    Slider(
    value: value,
    min: 0,
    max: 100,
    activeColor: Colors.green,
    inactiveColor: Colors.grey,
    onChanged: onChanged,
    ),
    ],
    ),
    );
  }
}
