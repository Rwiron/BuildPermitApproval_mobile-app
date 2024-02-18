import 'package:bui/views/widgets/customApp.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';

class Status extends StatelessWidget {
  const Status({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final String username = box.read('username') ?? 'Guest';

    final List<String> imageList = [
      'assets/images/stress.png',
      'assets/images/shares.png',
      'assets/images/happy.png',
      // Add more image paths as needed
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Replace with actual user image URL
                backgroundColor: Colors.indigo.shade300,
                radius: 24,
              ),
              title: Text(
                'Hi $username 👋',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 32),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              items: imageList
                  .map((item) => ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15), // Rounded corners for each image
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.asset(
                              item,
                              fit: BoxFit
                                  .cover, // Cover the entire space of the container
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  '', // Optional: You can add a caption or remove this Text widget
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'Start Your Building Journey Today!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 17, 120),
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Get your building request processed with ease and efficiency. Tap the button below to begin.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // ... other widgets
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to FeedStatus screen
              },
              child: Text('Apply for Request'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 24, 17, 120),
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
