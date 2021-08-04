import 'package:flutter/material.dart';

class IncreasedImage extends StatelessWidget {
  final String _path;

  IncreasedImage(this._path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Image.network(
              _path,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}
