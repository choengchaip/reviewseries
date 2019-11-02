import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'SerieDetail.dart';

class series_list extends StatefulWidget {
  String seriesStyle;

  series_list(this.seriesStyle);

  _series_list createState() => _series_list(this.seriesStyle);
}

class _series_list extends State<series_list> {
  String seriesStyle;

  _series_list(this.seriesStyle);

  TextStyle header =
      TextStyle(fontSize: 45, fontWeight: FontWeight.w900, color: Colors.white);
  TextStyle name = TextStyle(fontSize: 35, fontWeight: FontWeight.w900);
  TextStyle part = TextStyle(fontSize: 30);
  List<DocumentSnapshot> series;
  List<String> images = List<String>();

  final _db = Firestore.instance;

  Future getAllSeries() async {
    await _db
        .collection('series')
        .where('type', isEqualTo: this.seriesStyle)
        .getDocuments()
        .then((docs) {
      setState(() {
        series = docs.documents;
      });
    });
    for (int i = 0; i < series.length; i++) {
      String url;
      try {
        url = await FirebaseStorage.instance
            .ref()
            .child('series')
            .child(series[i].documentID + ".jpg")
            .getDownloadURL();
      } on PlatformException catch (a) {
        try {
          url = await FirebaseStorage.instance
              .ref()
              .child('series')
              .child(series[i].documentID + ".png")
              .getDownloadURL();
        } catch (b) {}
      }
      setState(() {
        images.add(url);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllSeries();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;

    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: _paddingTop,
              color: Color(0xffF0CCEA),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.only(left: 2, right: 10),
              color: Color(0xff5A5F63),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 55,
                      width: 60,
                      color: Colors.white,
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xff5A5F63),
                        size: 25,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Text(
                      this.seriesStyle,
                      style: header,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xffF0CCEA),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: series == null ? 0 : series.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return serie_detail(series[index]);
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 15),
                          height: 200,
                          color: Color(0xffF0C2EA),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                                color: Colors.red,
                                alignment: Alignment.bottomLeft,
                                height: 45,
                                child: Text(
                                  'เรื่อง ${series[index].data['name']}',
                                  style: name,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: images.length < index+1 ? CircularProgressIndicator() : Image.network(images[index]),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'จำนวน ${series[index].data['parts']} ตอน',
                                            style: part,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
