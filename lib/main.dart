import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var deskripsi;
  var saat_ini;
  var kelembapan;
  var kecepatan_angin;

  Future getWeather() async {
    http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?q=Pamulang&units=metric&lang=id&metric&appid=3e06acddebb47bc30b4665889815a240");
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.deskripsi = result['weather'][0]['description'];
      this.saat_ini = result['weather'][0]['main'];
      this.kelembapan = result['main']['humidity'];
      this.kecepatan_angin = result['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text("Pamulang",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600))),
                Text(temp != null ? temp.toString() + "\u00b0" : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(saat_ini != null ? temp.toString() : "Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Temperatur"),
                  trailing: Text(
                      temp != null ? temp.toString() + "\u00b0" : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Cuaca"),
                  trailing:
                      Text(saat_ini != null ? saat_ini.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Kelembapan"),
                  trailing: Text(
                      kelembapan != null ? kelembapan.toString() : "Loading"),
                ),
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Kecepatan Angin"),
                    trailing: Text(kecepatan_angin != null
                        ? kecepatan_angin.toString()
                        : "Loading")),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
