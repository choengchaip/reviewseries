import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class teaser_page extends StatefulWidget {
  String url;

  teaser_page(this.url);

  _teaser_page createState() => _teaser_page(this.url);
}

class _teaser_page extends State<teaser_page> {
  String url;

  _teaser_page(this.url);

  Future getVideoPath() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(this.url);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 300,
                  color: Colors.white,
                  child: YoutubePlayer(
                    context: context,
                    initialVideoId: this.url,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _paddingTop,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
