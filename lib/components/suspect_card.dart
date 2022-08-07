import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cidade_segura/components/anotation_form.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:flutter/material.dart';

class SuspectCard extends StatefulWidget {
  SuspectCard({Key? key, required this.suspect}) : super(key: key);
  final Suspect suspect;

  @override
  State<SuspectCard> createState() => _SuspectCardState();
}

class _SuspectCardState extends State<SuspectCard> {
  bool _exbanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(widget.suspect.name),
          SizedBox(),
          Text(widget.suspect.userEmail),
          SizedBox(),
          IconButton(
            onPressed: () {
              setState(() {
                _exbanded = !_exbanded;
              });
            },
            icon: Icon(Icons.expand_more),
          ),
          if (_exbanded)
            Container(
              height: widget.suspect.urlImage.length * 50 + 20,
              child: ListView(
                children: widget.suspect.urlImage
                    .map((url) => Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: FittedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Image.network(url))),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
