import 'package:covid_app/detailscreen.dart';
import 'package:covid_app/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class countrylist extends StatefulWidget {
  const countrylist({super.key});

  @override
  State<countrylist> createState() => _countrylistState();
}

class _countrylistState extends State<countrylist> {
  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    statservices stateservices = statservices();
    return Scaffold(backgroundColor: Colors.lightBlueAccent.shade100,

      appBar: AppBar(backgroundColor: Colors.orangeAccent.shade100,
        title: Text('country list',style: TextStyle(fontFamily: 'Merienda')),
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
          SafeArea(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value)
                {
                  setState(() {

                  });
                },
                controller: search,
                decoration: InputDecoration(
                  hintText: 'search with country names',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
              Expanded(child:FutureBuilder
                (future: stateservices.fetchcountrylist(),
                builder:(context,AsyncSnapshot<List<dynamic>> snapshot)
                {
                  if(!snapshot.hasData)
                    {
                      return ListView.builder(itemCount:10,

                          itemBuilder: (context,index){
                            return Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey.shade100,

                              child: Column(
                                children: [
                                  ListTile(
                                    title:Container(height: 10,width: 89,color: Colors.white,),
                                    subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                    leading: Container(height: 18,width: 89,color: Colors.white,)
                                  )

                                ],
                              ),
                            );
                          });;

                    }
                  else
                    {
                      return ListView.builder(itemCount: snapshot.data!.length,

                          itemBuilder: (context,index){
                        String name =snapshot.data![index]['country'];
                        if(search.text.isEmpty)
                          {
                            return Column(
                              children: [
                                InkWell(
                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country'],style: TextStyle(fontFamily: 'Merienda')),
                                    subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(fontFamily: 'Merienda')),
                                    leading: Image(

                                      height:50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> detailscreen(name: snapshot.data![index]['country'],image:   snapshot.data![index]['countryInfo']['flag'],totalcases:   snapshot.data![index]['cases'],population: snapshot.data![index]['population'],)));

                                  },
                                )

                              ],
                            );

                          }
                        else if(name.toLowerCase().contains(search.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> detailscreen(name: snapshot.data![index]['country'],image:   snapshot.data![index]['countryInfo']['flag'],totalcases:   snapshot.data![index]['cases'],population: snapshot.data![index]['population'],)));
                          },
                                child: ListTile(
                                  title:Text(snapshot.data![index]['country'],style: TextStyle(fontFamily: 'Merienda')),
                                  subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(fontFamily: 'Merienda')),
                                  leading: Image(

                                    height:50,
                                    width: 50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']
                                    ),),
                                ),
                              )

                            ],
                          );
                        }
                        else
                          {
                            return Container();
                          }

                      });

                    }

                },
              ))
            ],
          ),
        ),]
      ),

    );
  }
}
