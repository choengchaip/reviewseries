import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'TeaserPage.dart';

class serie_detail extends StatefulWidget {
  DocumentSnapshot serieDetail;

  serie_detail(this.serieDetail);

  _serie_detail createState() => _serie_detail(this.serieDetail);
}

class _serie_detail extends State<serie_detail> {
  DocumentSnapshot serieDetail;

  _serie_detail(this.serieDetail);

  TextStyle header = TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white);
  TextStyle teaser = TextStyle(fontSize: 40, fontWeight: FontWeight.w900);
  TextStyle loading = TextStyle(fontSize: 35, fontWeight: FontWeight.w900);
  TextStyle detail = TextStyle(fontSize: 25, fontWeight: FontWeight.w900);
  TextStyle website = TextStyle(
      fontSize: 25, fontWeight: FontWeight.w900, color: Colors.blueAccent);

  String url;
  String cate = '';

  Future getImage() async {
    String c;
    try {
      c = await FirebaseStorage.instance
          .ref()
          .child('series')
          .child(serieDetail.documentID + ".jpg")
          .getDownloadURL();
    } on PlatformException catch (a) {
      try {
        c = await FirebaseStorage.instance
            .ref()
            .child('series')
            .child(serieDetail.documentID + ".png")
            .getDownloadURL();
      } catch (b) {}
    }
    setState(() {
      url = c;
    });
  }

  Future getSerieType() async {
    for (int i = 0; i < serieDetail.data['categories'].length; i++) {
      setState(() {
        cate += (serieDetail.data['categories'][i].toString());
        if (i < serieDetail.data['categories'].length - 1) {
          cate += ', ';
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSerieType();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;
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
                      'เรื่อง ${this.serieDetail.data['name']}',
                      style: header,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xffF0CCEA),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: 300,
                      color: Color(0xffF0C2EA),
                      alignment: Alignment.center,
                      child: url == null
                          ? Text(
                              'Loading',
                              style: loading,
                            )
                          : Image.network(url),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return teaser_page(serieDetail.data['video_path']);
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          padding: EdgeInsets.only(left: 45,right: 45,top: 10,bottom: 10),
                          child: Text('Teaser',style: teaser,),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'ไซต์ : ',
                              style: detail,
                            ),
                          ),
                          Container(
                            child: Text(
                              'ไปที่เว็ไซต์',
                              style: website,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'ประเภท : ${cate}',
                              style: detail,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Text('สถานี : ${serieDetail.data['station']}',style: detail,),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'นักแสดง : ',
                              style: detail,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Wrap(
                                children: List.generate(serieDetail.data['actors'].length, (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                    ),
                                    padding: EdgeInsets.all(4),
                                    margin: EdgeInsets.only(right: 15,bottom: 5),
                                    child: Text(serieDetail.data['actors'][index],style: detail,),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Text('เรื่องย่อ : ${serieDetail.data['detail']}',style: detail,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
