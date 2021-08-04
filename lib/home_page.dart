import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'increased_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var _onlineData = await http.get(
      Uri.parse(
          'https://api.unsplash.com/search/photos?page=1&per_page=20&client_id=ligwJtGLX19D8PnrWaJbBouLDIe1q_7JyvVTPbowoF8&query=nature'),
    );
    var _jsonData = jsonDecode(_onlineData.body);
    setState(() {
      _data = _jsonData['results'];
    });
  }

  String _getPhotoDescription(String _description) {
    if (_description != 'null') return _description;
    return 'No description';
  }

  String _getAuthorUsername(String _username) {
    if (_username != 'null') return _username;
    return 'Unknown username';
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
                itemCount: _data.length,
                itemBuilder: (context, index) => RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            IncreasedImage(_data[index]['urls']['small']),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            _data[index]['urls']['small'],
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
                                  _getPhotoDescription(
                                      _data[index]['description'].toString()),
                                  style: GoogleFonts.indieFlower(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Center(
                                child: Text(
                                  _getAuthorUsername(_data[index]['user']
                                          ['username']
                                      .toString()),
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
                      ],
                    ),
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
