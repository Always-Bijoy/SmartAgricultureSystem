import 'package:firebase_auth/firebase_auth.dart';

// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:realtime_database/Model/device.dart';
import 'package:realtime_database/Service/firebase_auth.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //todo: for web
  final databaseReference2 = FirebaseDatabaseWeb.instance;

  // final databaseReference2 = FirebaseDatabase();

  final FirebaseAuthService _user = FirebaseAuthService();

  User logUser;

  bool isAuth = false;

  void initState() {
    super.initState();

    logUser = _user.logedcurrentUser();
    if (logUser == null) {
      isAuth = true;
    } else {
      isAuth = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var Width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    return isAuth
        ? Login()
        : Scaffold(
            backgroundColor: Color.fromRGBO(22, 29, 40, 1),
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  _user.logout();
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, '/login', (_) => false);
                  Navigator.pushNamed(context, '/');
                },
                child: Icon(
                  Icons.logout,
                ),
              ),
              // backgroundColor: Color.fromRGBO(22, 29, 40, 1),
              backgroundColor: Colors.blue,
              title: Text(
                // 'Data read from device',
                'স্মার্ট কৃষি ব্যবস্থা',
                style: GoogleFonts.mina(
                  fontSize: 20,
                  // color: Color.fromRGBO(253, 191, 73, 1),
                  color: Colors.white70,
                  letterSpacing: 2,
                ),
              ),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.network(
                        'https://1.bp.blogspot.com/-tz29PgKz-3M/XiBk6dMEkdI/AAAAAAAAEqI/J9ifMws0Z_YLlWlvCLQMhaWEBwtCFZdGQCEwYBhgL/s1600/Mujib%2BBorsho.png',
                        fit: BoxFit.contain,
                      ),
                    )),
              ],
            ),
            body: SafeArea(
              child: StreamBuilder(
                initialData: null,
                stream: databaseReference2
                    .reference()
                    .child('ESP32_Device')
                    .onValue,
                builder: (context, AsyncSnapshot snapShot) {
                  if (snapShot.hasData) {
                    //todo: enable when run mobile
                    // var dbData = snapShot.data.snapshot.value; // for mobile
                    var dbData = snapShot.data.value; //for web
                    ESP32Device d = ESP32Device.fromJson(dbData);
                    num humi = d.humidity.data;
                    num temp = d.temperature.data;
                    num soil = d.soilMoisture.data;
                    num soil2 = d.soilMoisture2.data;
                    return ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 8, bottom: 1, left: 8, right: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xff1C2754),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: Height / 2.7,
                                      child: Stack(
                                        children: [
                                          SfRadialGauge(
                                            enableLoadingAnimation: true,
                                            animationDuration: 4500,
                                            axes: <RadialAxis>[
                                              RadialAxis(
                                                axisLabelStyle: GaugeTextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                                interval: 10,
                                                annotations: <GaugeAnnotation>[
                                                  GaugeAnnotation(
                                                    // axisValue: humi.toDouble(),
                                                    axisValue: 50,
                                                    positionFactor: 0,
                                                    widget: Text(
                                                      "${humi.toStringAsFixed(2)} \u00B0C",
                                                      style: GoogleFonts.mina(
                                                        fontSize: 20,
                                                        color: Color.fromRGBO(
                                                            253, 191, 73, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                maximum: 100,
                                                minimum: 0,
                                                pointers: <GaugePointer>[
                                                  RangePointer(
                                                    animationType:
                                                        AnimationType.ease,
                                                    enableAnimation: true,
                                                    animationDuration: 4500,
                                                    value: humi.toDouble(),
                                                    width: 0.12,
                                                    sizeUnit:
                                                        GaugeSizeUnit.factor,
                                                    cornerStyle:
                                                        CornerStyle.bothCurve,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: <Color>[
                                                          Color(0xFFCC2B5E),
                                                          Color(0xFF753A88)
                                                        ],
                                                            stops: <double>[
                                                          0.25,
                                                          0.75
                                                        ]),
                                                  ),
                                                  MarkerPointer(
                                                    value: humi.toDouble(),
                                                    markerHeight: 30,
                                                    markerWidth: 30,
                                                    markerType:
                                                        MarkerType.circle,
                                                    color: Colors.lightBlue,
                                                  ),
                                                ],
                                                axisLineStyle: AxisLineStyle(
                                                    thickness: 20,
                                                    color: Colors.blue[200],
                                                    cornerStyle:
                                                        CornerStyle.bothCurve),
                                              )
                                            ],
                                          ),
                                          Positioned.fill(
                                            bottom: 25,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                'আর্দ্রতা',
                                                style: GoogleFonts.mina(
                                                  fontSize: 25,
                                                  color: Color.fromRGBO(
                                                      253, 191, 73, 1),
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: Height / 2.7,
                                      child: Stack(
                                        children: [
                                          SfRadialGauge(
                                            enableLoadingAnimation: true,
                                            animationDuration: 4500,
                                            axes: <RadialAxis>[
                                              RadialAxis(
                                                axisLabelStyle: GaugeTextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                                interval: 10,
                                                annotations: <GaugeAnnotation>[
                                                  GaugeAnnotation(
                                                    axisValue: 50,
                                                    positionFactor: 0,
                                                    widget: Text(
                                                      temp.toStringAsFixed(2),
                                                      style: GoogleFonts.mina(
                                                        fontSize: 25,
                                                        color: Color.fromRGBO(
                                                            253, 191, 73, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                maximum: 100,
                                                minimum: 0,
                                                pointers: <GaugePointer>[
                                                  RangePointer(
                                                    animationType:
                                                        AnimationType.ease,
                                                    enableAnimation: true,
                                                    animationDuration: 4500,
                                                    value: temp.toDouble(),
                                                    width: 0.12,
                                                    sizeUnit:
                                                        GaugeSizeUnit.factor,
                                                    cornerStyle:
                                                        CornerStyle.bothCurve,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: <Color>[
                                                          Color(0xFFCC2B5E),
                                                          Color(0xFF753A88)
                                                        ],
                                                            stops: <double>[
                                                          0.25,
                                                          0.75
                                                        ]),
                                                  ),
                                                  MarkerPointer(
                                                    value: temp.toDouble(),
                                                    markerHeight: 30,
                                                    markerWidth: 30,
                                                    markerType:
                                                        MarkerType.circle,
                                                    color: Colors.lightBlue,
                                                  ),
                                                ],
                                                axisLineStyle: AxisLineStyle(
                                                    thickness: 20,
                                                    color: Colors.blue[200],
                                                    cornerStyle:
                                                        CornerStyle.bothCurve),
                                              )
                                            ],
                                          ),
                                          Positioned.fill(
                                            bottom: 25,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                'তাপমাত্রা',
                                                style: GoogleFonts.mina(
                                                  fontSize: 25,
                                                  color: Color.fromRGBO(
                                                      253, 191, 73, 1),
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(),
                        Container(
                          margin: EdgeInsets.only(
                              top: 8, bottom: 1, left: 8, right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xff1C2754),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Container(
                                        // height: Height / 2.7,
                                        height: 250,
                                        child: SfRadialGauge(
                                          enableLoadingAnimation: true,
                                          animationDuration: 4500,
                                          axes: <RadialAxis>[
                                            RadialAxis(
                                              interval: 50,
                                              axisLabelStyle: GaugeTextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                              annotations: <GaugeAnnotation>[
                                                GaugeAnnotation(
                                                  axisValue: soil.toDouble(),
                                                  positionFactor: 0,
                                                  widget: Text(
                                                    soil.toStringAsFixed(2),
                                                    style: GoogleFonts.mina(
                                                      fontSize: 25,
                                                      color: Color.fromRGBO(
                                                          253, 191, 73, 1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              maximum: 500,
                                              minimum: 0,
                                              pointers: <GaugePointer>[
                                                RangePointer(
                                                  animationType:
                                                      AnimationType.ease,
                                                  enableAnimation: true,
                                                  animationDuration: 4500,
                                                  value: soil.toDouble(),
                                                  width: 0.12,
                                                  sizeUnit:
                                                      GaugeSizeUnit.factor,
                                                  cornerStyle:
                                                      CornerStyle.bothCurve,
                                                  gradient: const SweepGradient(
                                                      colors: <Color>[
                                                        Color(0xFFCC2B5E),
                                                        Color(0xFF753A88)
                                                      ],
                                                      stops: <double>[
                                                        0.25,
                                                        0.75
                                                      ]),
                                                ),
                                                MarkerPointer(
                                                  value: soil.toDouble(),
                                                  markerHeight: 30,
                                                  markerWidth: 30,
                                                  markerType: MarkerType.circle,
                                                  color: Colors.lightBlue,
                                                ),
                                              ],
                                              axisLineStyle: AxisLineStyle(
                                                  thickness: 20,
                                                  color: Colors.blue[200],
                                                  cornerStyle:
                                                      CornerStyle.bothCurve),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'মাটির আদ্রতা',
                                        style: GoogleFonts.mina(
                                          fontSize: 25,
                                          color:
                                              Color.fromRGBO(253, 191, 73, 1),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 8, bottom: 1, left: 8, right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xff1C2754),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'মোটর',
                                  style: GoogleFonts.mina(
                                    fontSize: 25,
                                    color: Color.fromRGBO(253, 191, 73, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                // SizedBox(
                                //   width: 50,
                                // ),
                                LiteRollingSwitch(
                                  //initial value
                                  value: true,
                                  textOn: 'চালু',
                                  textOff: 'বন্ধ',
                                  // colorOn: Colors.greenAccent[700],
                                  // colorOff: Colors.redAccent[700],
                                  colorOn: Color(0xFF753A88),
                                  colorOff: Color(0xFFCC2B5E),
                                  // iconOn: Icons.done,
                                  iconOff: Icons.remove_circle_outline,
                                  textSize: 16.0,
                                  onChanged: (bool state) {
                                    //Use it to manage the different states
                                    print('Current State of SWITCH IS: $state');
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          );
  }
}
