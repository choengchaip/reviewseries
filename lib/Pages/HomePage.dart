import 'package:flutter/material.dart';
import 'SeriesList.dart';


class home_page extends StatefulWidget{
  _home_page createState() => _home_page();
}

class _home_page extends State<home_page>{

  TextStyle header = TextStyle(fontSize: 45,fontWeight: FontWeight.w900);
  TextStyle option = TextStyle(fontSize: 30,fontWeight: FontWeight.w900,color: Colors.white);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        color: Color(0xffF0CCEA),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("Review Series",style: header,),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(image: AssetImage("assets/images/homepage.png",),fit: BoxFit.fitHeight)
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return series_list('Thai');
                }));
              },
              child: Container(
                height: 60,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xff5A5F63),
                ),
                child: Text('Thai',style: option,),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return series_list('Korea');
                }));
              },
              child: Container(
                height: 60,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xff5A5F63),
                ),
                child: Text('Korea',style: option,),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return series_list('Japan');
                }));
              },
              child: Container(
                height: 60,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xff5A5F63),
                ),
                child: Text('Japan',style: option,),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return series_list('America');
                }));
              },
              child: Container(
                height: 60,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xff5A5F63),
                ),
                child: Text('America',style: option,),
              ),
            ),
          ],
        )
      ),
    );
  }
}