import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final databaseReference2 = FirebaseDatabase.instance;

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
              child: SingleChildScrollView(
                child: Container(
                  height: Height,
                  color: Color.fromRGBO(22, 29, 40, 1),
                  // color: Colors.white,
                  child: StreamBuilder(
                    initialData: null,
                    stream: databaseReference2
                        .reference()
                        .child('ESP32_Device')
                        .onValue,
                    builder: (context, AsyncSnapshot snapShot) {
                      if (snapShot.hasData) {
                        var dbData = snapShot.data.snapshot.value;
                        ESP32Device d = ESP32Device.fromJson(dbData);
                        num humi = d.humidity.data;
                        num temp = d.temperature.data;
                        num soil = d.soilMoisture.data;
                        return Column(
                          children: [
                            Row(
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
                                                  axisLabelStyle:
                                                      GaugeTextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                  interval: 10,
                                                  annotations: <
                                                      GaugeAnnotation>[
                                                    GaugeAnnotation(
                                                      // axisValue: humi.toDouble(),
                                                      axisValue: 50,
                                                      positionFactor: 0,
                                                      widget: Text(
                                                        '$humi',
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
                                                      cornerStyle: CornerStyle
                                                          .bothCurve),
                                                )
                                              ],
                                            ),
                                            Positioned.fill(
                                              bottom: 25,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
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
                                                  axisLabelStyle:
                                                      GaugeTextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                  interval: 10,
                                                  annotations: <
                                                      GaugeAnnotation>[
                                                    GaugeAnnotation(
                                                      axisValue: 50,
                                                      positionFactor: 0,
                                                      widget: Text(
                                                        '$temp',
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
                                                      cornerStyle: CornerStyle
                                                          .bothCurve),
                                                )
                                              ],
                                            ),
                                            Positioned.fill(
                                              bottom: 25,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
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
                            SizedBox(
                            ),
                            Row(
                              children: [
                                Expanded(
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
                                                    '$soil',
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
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              width: double.infinity,
                              height: 1,
                              color: Colors.white60,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 20),
                              child:
                              Column(
                                 mainAxisAlignment:
                                     MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'মোটর',
                                    style: GoogleFonts.mina(
                                      fontSize: 25,
                                      color: Color.fromRGBO(253, 191, 73, 1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
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
                                      print(
                                          'Current State of SWITCH IS: $state');
                                    },
                                  ),
                                ],
                              ),

                            )
                          ],
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ),
          );
  }
}
