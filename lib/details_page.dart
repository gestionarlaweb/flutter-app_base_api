import 'package:app_base_api/main.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Equipo equipo;
  const DetailsPage({Key? key, required this.equipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: equipo.name,
              child: Image.network(
                equipo.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: BackButton(
              color: Colors.purple,
            ),
          ),
          Positioned(
            left: 20,
            top: 400,
            right: 20,
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      equipo.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      equipo.city,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 8),
                    Text(equipo.description,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
