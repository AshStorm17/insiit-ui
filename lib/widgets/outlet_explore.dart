import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/meal.dart';
import '../widgets/meal.dart';

class OutletExplore extends StatefulWidget {
  const OutletExplore({super.key});

  @override
  State<OutletExplore> createState() => _OutletExploreState();
}

class _OutletExploreState extends State<OutletExplore> {
  List<Meal> meals = [];

// Get the iems on screen load via GET reuqest
  @override
  void initState() {
    super.initState();
    fetchMeal();
  }

// The item list is updated in meals list
  Future<void> fetchMeal() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/food-items'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final items = data
          .map((item) => Meal(
                id: item['id'],
                name: item['name'],
                price: item['price'],
                description: item['description'],
                rating: item['rating'],
                size: item['size'],
                cal: item['cal'],
                image: item['image'],
                outletid: item['food_outlet_id'],
              ))
          .toList();

      setState(() {
        meals = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("Sorry but no items to show"),
    );

    if (meals.isNotEmpty) {
      content = Container(
        height: 450,
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealCard(
            meal: meals[index],
          ),
        ),
      );
    }
    return Column(children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 200,
            width: double.infinity,
            color: const Color(0xFFF6FFD3),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Order Food Online",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Feeling Hungry? You have come to the right place. Explore and enjoy delicious foods here",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 50,
            bottom: -20,
            child: Container(
              color: Color(0xFF),
              width: 300,
              child: FloatingActionButton(
                backgroundColor: Color(0xFFFFFBFE),
                onPressed: () => {},
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Search Dishes",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      content,
    ]);
  }
}
