import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: const Border(
                left: BorderSide(
                  color: Colors.green,
                  width: 5,
                ),
              ),
            ),
            child: const Column(
              children: [
                Text(
                  'Zailabidin',
                  style: TextStyle(fontSize: 25),
                ),
                Text('+7(953)7634027'),
                Text('sulajmankulovzajlabidin@gmail.com')
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.person,
                size: 35,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Личные данные',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
          const Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.shopping_basket_rounded,
                    size: 35,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Мои заказы',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Бонусы',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.room),
                  Text(
                    'Мои адресса',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.chat),
                  Text(
                    'Чат',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.language),
                  Text(
                    'Язык приложение',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
