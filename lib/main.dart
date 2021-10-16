import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

Future<List<Ospedale>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('URL_DA_INSERIRE');
      print(response.body);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Ospedale> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Ospedale>((json) => Ospedale.fromJson(json)).toList();
}

/*
  I dati visualizzati da Genova P.S. sono dati pubblici resi disponibili dal 118 di Genova e dall'Ente ospedaliero Ospedali Galliera
*/

class Ospedale {
  final String nomePS;
  final String totaleAttesa;
  final String totaleVisita;
  final String ar;
  final String ag;
  final String av;
  final String ab; 
  final String vr;
  final String vg;
  final String vv;
  final String vb; 
  final String obi;
  final String ora;
  final String tot;

  Ospedale({this.nomePS, this.totaleAttesa, this.totaleVisita, this.obi, this.ab, this.ag, this.ar, this.av, this.vb, this.vg, this.vr, this.vv, this.ora, this.tot});

  factory Ospedale.fromJson(Map<String, dynamic> json) {
    print("JSON");
    String stringa = jsonEncode(json);
    dynamic aaa = jsonDecode(stringa);
    print(aaa);
    print(aaa['ab']);

    return Ospedale(
      nomePS: json['nomeps'] as String,
      totaleAttesa: json['totaleattesa'] as String,
      totaleVisita: json['totalevisita'] as String,
      ar: json['ar'] as String,
      ag: json['ag'] as String,
      av: json['av'] as String,
      ab: json['ab'] as String,
      vr: json['vr'] as String,
      vg: json['vg'] as String,
      vv: json['vv'] as String,
      vb: json['vb'] as String,
      obi: json["obi"] as String,
      ora: json["ora"] as String,
      tot: json["tot"] as String
    );
  }
}
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Genova P.S.';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {

  
  final String title;

  final String descrizioneUno="I dati relativi ai Pronto Soccorso e ai Punti di Primo Intervento dell'area metropolitana di Genova sono pubblici e resi disponibili dal 118 di Genova e dall'Ente ospedaliero Ospedali Galliera all'indirizzo web: www.galliera.it//118. Genova P.S. facilita solamente la lettura di queste informazioni attraverso uno Smartphone.";
  final String descrizioneDue="Attenzione: i dati mostrati e il numero effettivo dei pazienti per ogni ospedale possono non essere aggiornati in tempo reale a causa dei tempi di elaborazione o di malfunzionamenti dei sistemi informatici.";
  final String descrizioneTre="In caso di emergenza chiama il Numero unico di emergenza 112 ";

  final String descrizioneQuattro="Developed By Riccardo Riggi";


  MyHomePage({Key key, this.title}) : super(key: key);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent[700],
        leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.hospitalUser, color: Colors.white,),
      ),
      actions: <Widget>[
        IconButton(
              icon: Icon(FontAwesomeIcons.info),
              onPressed: () {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    backgroundColor: Colors.white,
                    content: Container(
                      padding: EdgeInsets.fromLTRB(0,36,0,0),
                      child: 
                    Column(

                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                            icon: FaIcon(FontAwesomeIcons.hospitalUser, 
                            color: Colors.blueAccent[700],
                            size: 50,)),
                            
                            ],
                          ),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0,30,0,0),
                                child: Text(
                                  "Genova P.S.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                            ],
                          ), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(0,20,0,0),
                                child: Text(descrizioneUno,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  maxLines: 15,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(0,20,0,0),
                                child: Text(descrizioneDue,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  maxLines: 15,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(0,20,0,20),
                                child: Text(descrizioneTre,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  maxLines: 15,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                          Container(
                            height:3.0,
                            width:300,
                            color: Colors.blueAccent[700],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(0,20,0,0),
                                child: Text(descrizioneQuattro,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 15,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                            ],
                          )
                          
                        ],
                      ),
                    ),
                  
                    duration: Duration(days: 365),                    
                  ));
               
              },
              
            ),
           
      ],
      ),
      body: FutureBuilder<List<Ospedale>>(
        initialData: List(),
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(ospedali: snapshot.data)
              : Center(child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent[700]),));
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Ospedale> ospedali;

  PhotosList({Key key, this.ospedali}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1
      ),
      itemCount: ospedali.length,
      itemBuilder: (context, index) {
        return SchedaOspedale(ospedale: ospedali[index]);
      },
    );
  }
}



class SchedaOspedale extends StatelessWidget{

  final Ospedale ospedale;

  const SchedaOspedale({Key key, @required this.ospedale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
      
      
      child: Container(
        
        width: double.infinity,
        height: 370.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0.0,3.0),
            blurRadius: 15.0 
            )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: 
              Text(
              ospedale.nomePS.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              
              ),
            ),
            ),
            
            Container(
              height:3.0,
              width:70,
              color: Colors.blueAccent[700],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                    "Pazienti in attesa: "+ospedale.totaleAttesa,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                       color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  )
                  
                ],
              ),
              Column(
                
                children: <Widget>[
                  Row(
                  
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      QuadratoValore(ar: ospedale.ar, color: Colors.redAccent[700]),
                      QuadratoValore(ar: ospedale.ag, color: Colors.yellowAccent[700]),
                      QuadratoValore(ar: ospedale.av, color: Colors.greenAccent[700]),
                      QuadratoValore(ar: ospedale.ab, color: Colors.grey[700]),
                    ],
                  )
               
                  
                ],
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                    child: Text(
                    "Pazienti in visita: "+ospedale.totaleVisita,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                       color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  )
                  
                ],
              ),
              Column(
                
                children: <Widget>[
                  Row(
                  
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      QuadratoValore(ar: ospedale.vr, color: Colors.redAccent[700]),
                      QuadratoValore(ar: ospedale.vg, color: Colors.yellowAccent[700]),
                      QuadratoValore(ar: ospedale.vv, color: Colors.greenAccent[700]),
                      QuadratoValore(ar: ospedale.vb, color: Colors.grey[700]),
                    ],
                  )
               
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                    child: Text(
                    "Pazienti in Osservazione Breve Intensiva: "+ospedale.obi,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                       color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  )
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                    "Pazienti totali: "+ospedale.tot,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                       color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  )
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(
                    "Dati aggiornati alle ore: "+ospedale.ora,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                       color: Colors.black87,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  )
                  
                ],
              ),
              
          ],
        ),
      ),
    );
    

  } 
  
}

class QuadratoValore extends StatelessWidget{
  final String ar;
  final Color color;


const QuadratoValore({Key key, @required this.ar, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    color: color,
                    child: Text(
                    ar,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                       color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  );
  } 


}