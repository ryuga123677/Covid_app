import 'dart:io';

import 'package:covid_app/countrylist.dart';
import 'package:covid_app/stats_services.dart';
import 'package:covid_app/worldstatemodel.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';
import 'package:pie_chart/pie_chart.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
class worldstate extends StatefulWidget {
  const worldstate({super.key});

  @override
  State<worldstate> createState() => _worldstateState();
}

class _worldstateState extends State<worldstate> with TickerProviderStateMixin{
  late final AnimationController control=AnimationController(
  duration: Duration(seconds:3),
  vsync:this)..repeat();
  @override
  void dispose() {
    super.dispose();
    control.dispose();
  }
  statservices stateservice =statservices();
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: Stack(
        children: [
          Container(height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent.shade100,Colors.purpleAccent.shade100,Colors.orangeAccent.shade100],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
            )
          ),),
          SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                FutureBuilder(
                    future: stateservice.fetchworldrecords(),
                    builder: (context,AsyncSnapshot<Worldstatemodel> snapshot){
                  if(!snapshot.hasData)
                    {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                       color: Colors.white,
                        size: 50.0,
                        controller: control,
                      ));


                    }
                  else
                    {
                        return Column(
                          children: [
                            PieChart(dataMap: {
                              'total':double.parse(snapshot.data!.cases.toString()),
                              'recovered':double.parse(snapshot.data!.recovered.toString()),
                              'deaths':double.parse(snapshot.data!.deaths.toString()),
                              'active':double.parse(snapshot.data!.active.toString())
                            },
                              colorList: [Colors.green,Colors.red,Colors.yellow,Colors.blue],

                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.disc,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left
                              ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            ),
                            Card(color: Colors.tealAccent.shade100,
                              child: Column(
                                children: [
                                  reusablerow(title: 'Total', value: snapshot.data!.cases.toString()),
                                  reusablerow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  reusablerow(title: 'Active', value: snapshot.data!.active.toString()),
                                  reusablerow(title: 'Recovered', value: snapshot.data!.active.toString())

                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            InkWell(onTap:()
                    {Navigator.push(context, MaterialPageRoute(builder: (context) => countrylist()));
                      },
                              child:
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text('Track countries',style: TextStyle(fontFamily: 'Merienda'))),
                              ),


                            )

                          ],
                        );
                    }

                }),

              ],

            ),
          ),
        ),]
      ),
    );
  }
}
class reusablerow extends StatelessWidget {
  String title,value;
   reusablerow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:18.0,right: 10,top:10,bottom: 5),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title,style: TextStyle(fontFamily: 'Merienda'),),
              Text(value,style: TextStyle(fontFamily: 'Merienda'))

            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
