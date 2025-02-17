import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insiit/screens/representatives.dart';
import 'mess.dart';
import '../screens/outlets.dart';
import 'bus_standalone.dart';
import '../screens/complaints.dart';
import '../screens/animation.dart';
import 'package:animations/animations.dart';
import 'events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
var name = FirebaseAuth.instance.currentUser!.displayName;

var nameArray = name?.split(" ");

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromARGB(255, 233, 236, 255),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
                height: 280,
                child: Center(
                    child: Text(
                  "Event $index",
                  style: const TextStyle(color: Colors.indigo),
                )),
              ),
            ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text('Hi, ${nameArray?[0]}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: const Text("Welcome Back!!",
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // const SizedBox(
        //   height: 10,
        // ),
        
        Row(
            children: [
                    Card(
                        surfaceTintColor: const Color(0xFFE4D7FF),
                        color: const Color(0xFFE0D0FF),
                        margin: const EdgeInsets.all(16.0),
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                          splashColor: const Color.fromARGB(103, 159, 111, 255),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BusPageStandalone()),
                            );
                          },
                          child: SizedBox(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2 -
                                32, // minus 32 due to the margin

                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_bus_filled_outlined,
                                  color: Color(0xFF5B33AC),
                                ),
                                Text(
                                  "Bus Schedule",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF5B33AC),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Card(
                        surfaceTintColor: Colors.white,
                        color: const Color(0xFFFFD8C4),
                        margin: const EdgeInsets.all(16.0),
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                          splashColor: const Color.fromARGB(123, 255, 166, 121),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OutletScreen()),
                            );
                          },
                          child: SizedBox(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2 -
                                32, // minus 32 due to the margin

                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant_menu_outlined,
                                  color: Color.fromARGB(255, 127, 57, 0),
                                ),
                                Text(
                                  "Outlets",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 127, 57, 0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ]),
                  InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventWidget()),
              );
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text("What's on the Campus?",
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const EventWidget()));
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ],
                )
                // const ListTile(

                //   leading: Icon(Icons.food_bank_outlined),
                //   title: Text("What is in the Mess?"),
                //   trailing: IconButton(onPressed: (), icon: icon)
                // ),
                ),
          ),
                  SafeArea(
              child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 1),
                  SizedBox(
                    height: 140,
                    child: PageView.builder(
                      controller: controller,
                      // itemCount: pages.length,
                      itemBuilder: (_, index) {
                        return pages[index % pages.length];
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: pages.length,
                    effect: const WormEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      type: WormType.normal,
                    ),
                  ),
                ]),
          )),
              //  Row(
              //     children: [
              //       Card(
              //           color: Color(0xFFD7F1FF),
              //           margin: EdgeInsets.all(16.0),
              //           child: InkWell(
              //             borderRadius: BorderRadius.all(Radius.circular(16.0)),
              //             splashColor: Color.fromARGB(173, 194, 233, 255),
              //             onTap: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) =>
              //                         const FadeThroughTransitionDemo()),
              //               );
              //             },
              //             child: SizedBox(
              //               height: 120,
              //               width: MediaQuery.of(context).size.width / 2 -
              //                   32, // minus 32 due to the margin

              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   Icon(Icons.pending_actions_outlined,
              //                       color: Color(0xFF398AB7)),
              //                   Text(
              //                     "Complaints",
              //                     style: TextStyle(
              //                       fontSize: 15,
              //                       color: Color(0xFF398AB7),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           )),
              //       Card(
              //           surfaceTintColor: Colors.white,
              //           color: Color(0xFFFFF6A1),
              //           margin: EdgeInsets.all(16.0),
              //           child: InkWell(
              //             borderRadius: BorderRadius.all(Radius.circular(16.0)),
              //             splashColor: Color.fromARGB(144, 224, 216, 146),
              //             onTap: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => RepresentativesPage()),
              //               );
              //             },
              //             child: SizedBox(
              //               height: 120,
              //               width: MediaQuery.of(context).size.width / 2 -
              //                   32, // minus 32 due to the margin

              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   Icon(
              //                     Icons.contact_emergency_outlined,
              //                     color: Color.fromARGB(255, 141, 130, 25),
              //                   ),
              //                   Text(
              //                     "Representatives",
              //                     style: TextStyle(
              //                       fontSize: 15,
              //                       color: Color.fromARGB(255, 141, 130, 25),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           )),
              //     ],
              //   ),
            
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MealsDisplayScreen()),
                  );
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Text("What's in the Mess?",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const MealsDisplayScreen()));
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ])
                    // const ListTile(

                    //   leading: Icon(Icons.food_bank_outlined),
                    //   title: Text("What is in the Mess?"),
                    //   trailing: IconButton(onPressed: (), icon: icon)
                    // ),
                    ),
              ),
              const SizedBox(
                height: 90,
              ),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EventWidget()),
                  );
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Text("What's on the Campus?",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const EventWidget()));
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ],
                   
                        )
                    // const ListTile(

                    //   leading: Icon(Icons.food_bank_outlined),
                    //   title: Text("What is in the Mess?"),
                    //   trailing: IconButton(onPressed: (), icon: icon)
                    // ),
                    ),
              ),
            ],
          ),
        );
  }
}
