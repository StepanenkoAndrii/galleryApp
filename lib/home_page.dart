import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];

  void initState() {
    super.initState();
    getData();
  }

  Future<String> getData() async {
    var onlineData = await http.get(
      Uri.parse(
          'https://api.unsplash.com/search/photos?page=1&per_page=20&client_id=ligwJtGLX19D8PnrWaJbBouLDIe1q_7JyvVTPbowoF8&query=nature'),
    );
    var jsonData = jsonDecode(onlineData.body);
    setState(() {
      data = jsonData['results'];
    });
    return "success";
  }

  String getPhotoDescription(String description) {
    if (description != 'null') return description;
    return 'No description';
  }

  String getAuthorUsername(String username) {
    if (username != 'null') return username;
    return 'Unknown username';
  }

  double getPhotoContainerHeight(int length, int index) {
    if (length <= 20)
      return 430;
    else if (length <= 38) return 480;
    return 520;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Gallery",
                style: GoogleFonts.dancingScript(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   color: Colors.blue,
                  // ),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(bottom: 80),
                  // height: getPhotoContainerHeight(
                  //     data[index]['description'].toString().length, index),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          data[index]['urls']['small'],
                          fit: BoxFit.cover,
                          height: 300,
                          width: 300,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Center(
                              child: Text(
                                getPhotoDescription(
                                    data[index]['description'].toString()),
                                style: GoogleFonts.indieFlower(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Center(
                              child: Text(
                                getAuthorUsername(
                                    data[index]['user']['username'].toString()),
                                style: GoogleFonts.indieFlower(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.75,
                      //   child: Center(
                      //     child: Text(
                      //       data[index]['user']['username'].toString() == 'null'
                      //           ? 'Unknown username'
                      //           : data[index]['user']['username'].toString(),
                      //       style: GoogleFonts.indieFlower(
                      //         textStyle: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 28,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
