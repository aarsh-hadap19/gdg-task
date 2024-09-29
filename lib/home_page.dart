import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> data = [];
  int currentIndex = 0;
  bool isDataLoaded = false;  // Track if data is loaded for animation

  // Fetch all documents from Firestore collection
  Future<void> fetchData() async {
    if (data.isEmpty) {
      // Fetch data from Firestore only if not already fetched
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('content').get();

      List<Map<String, dynamic>> fetchedData = snapshot.docs.map((doc) {
        return {
          'text': doc['text'],
          'imageUrl': doc['url'],
        };
      }).toList();

      setState(() {
        data = fetchedData;
        currentIndex = 0;  // Reset the index after fetching
      });

      // Trigger animation after a brief delay
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          isDataLoaded = true;
        });
      });
    }
  }

  // Show next image/text
  void showNext() {
    if (data.isNotEmpty) {
      setState(() {
        currentIndex = (currentIndex + 1) % data.length;  // Circular index for next
      });
    }
  }

  // Show previous image/text
  void showPrevious() {
    if (data.isNotEmpty) {
      setState(() {
        currentIndex = (currentIndex - 1 + data.length) % data.length;  // Circular index for previous
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.black,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Push content to top and buttons to bottom
          children: [
            Expanded(
              child: Center(
                child: data.isEmpty
                    ? const Text(
                  'Click button to fetch data',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
                    : AnimatedOpacity(
                  opacity: isDataLoaded ? 1.0 : 0.0,  // 1.0 when data is loaded, 0.0 when not
                  duration: const Duration(seconds: 1),  // Animation duration
                  child: Column(
                    mainAxisSize: MainAxisSize.min,  // Minimize space taken by column
                    children: [
                      // Image container with fixed height and width
                      SizedBox(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          data[currentIndex]['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data[currentIndex]['text'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: data.isEmpty
                  ? ElevatedButton(
                onPressed: fetchData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 50),
                ),  // Only show the load button when data is empty
                child: const Text("Get Data", style: TextStyle(fontSize: 20)),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,  // Center the buttons
                children: [
                  IconButton(
                    onPressed: showPrevious,  // Show previous when data is loaded
                    icon: const Icon(Icons.arrow_back_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    iconSize: 30,
                    tooltip: "Previous",
                    padding: const EdgeInsets.all(16),
                    splashColor: Colors.red,
                  ),
                  const SizedBox(width: 20),  // Space between the two buttons
                  IconButton(
                    onPressed: showNext,  // Show next when data is loaded
                    icon: const Icon(Icons.arrow_forward_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    iconSize: 30,
                    tooltip: "Next",
                    padding: const EdgeInsets.all(16),
                    // splashColor: Colors.blue,
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
