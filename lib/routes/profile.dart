import 'package:S_ATM/profileinfo.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map data;
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  int total ;
  List outputs;
   Map info ={
      'Makram Ali':Info(adderess: 'debrk',balance:'10000'),
      'Zeyad mamdouh':Info(adderess: 'كفر المصيلحه',balance:'20000'),
      'Mahmoud Sabry':Info(adderess: 'shbien',balance:'2000'),
      
      };
  // ignore: non_constant_identifier_names
  CreateAlertDialog(BuildContext context)async{
    return showDialog(context: context,builder:(context){
    return AlertDialog(
      backgroundColor: Colors.blue[400],
      title: Text('confrim',style: TextStyle(
        color:Colors.white,
        fontFamily: 'FredokaOne'
      ),),
      content: Text(_text) ,
      actions: <Widget>[
        MaterialButton(
          onPressed: ()async{
             Navigator.pop(context);
            setState(() {
              if (int.parse(_text)>int.parse(info['${outputs[0]["label"]}'].balance)){
             _text="your maximum withdraw is ${info['${outputs[0]["label"]}'].balance}";
              }else{
                total =int.parse(info['${outputs[0]["label"]}'].balance)-int.parse(_text);
              info['${outputs[0]["label"]}'].balance=total.toString();
              }
            });
         
        },
        child: Text('confirm',style: TextStyle(color:Colors.white),),
        )
      ],
                   

    );
    });
  }


  

@override
void initState() { 
  super.initState();
  _speech = stt.SpeechToText();
}
  @override
  Widget build(BuildContext context) {
    
    data=  ModalRoute.of(context).settings.arguments;
    outputs= data['outputs'];
   
    return  Scaffold(
     
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app,size: 35,), onPressed: (){Navigator.pushReplacementNamed(context, '/');})
        ],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage('assets/${outputs[0]["label"]}.jpeg'),
              ),
            ),
            Divider(
              color: Colors.grey[800],
              height: 60.0,
            ),
            Text(
              'NAME',
              style: TextStyle(
               
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '${outputs[0]["label"]}',
              style: TextStyle(
               
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'HOMETOWN',
              style: TextStyle(
                
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              info['${outputs[0]["label"]}'].adderess,
              style: TextStyle(
              
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'CURRENT BALANCE',
              style: TextStyle(
                
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
               info['${outputs[0]["label"]}'].balance,
              style: TextStyle(
               
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height:30),
            Text(_text),
            
          ],
        ),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }
   void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
           
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      CreateAlertDialog(context);
    }
  }
}
