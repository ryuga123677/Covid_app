import 'package:covid_app/worldstate.dart';
import 'package:flutter/material.dart';
class detailscreen extends StatefulWidget {
  String name;
  String image;
int population;
  int totalcases;
   detailscreen({super.key,required this.name,required this.image,required this.totalcases,required this.population});


  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.lightBlueAccent.shade100,

      appBar: AppBar(backgroundColor: Colors.orangeAccent.shade100,
        title: Text(widget.name),
        centerTitle: true,
      ),
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
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(color: Colors.tealAccent,
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                        reusablerow(title: 'Cases', value: widget.totalcases.toString()),
                        reusablerow(title: 'Name', value: widget.name.toString()),
                        reusablerow(title: 'Population', value:widget.population.toString())
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),]
      ),
    );
  }
}
