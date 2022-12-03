import 'package:flutter/material.dart';
import 'package:neonpen/neonpen.dart';
import 'package:number_to_word_arabic/number_to_word_arabic.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double _numberFrom = 0;
  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  String flous = '';

  void arabe() {
    setState(() {
      flous = (((_numberFrom.toString().split(".")[0]) != "0")
          ? (Tafqeet.convert(_numberFrom.toString().split(".")[0]))
          : "صفر") +
          " دينار و " +
          ((((_numberFrom.toString().split(".")[1] + "000").substring(0, 3)) !=
              "000")
              ? Tafqeet.convert(((_numberFrom.toString().split(".")[1] + "000")
              .substring(0, 3)))
              : "صفر") +
          " مليم";
    });
  }

  void anglais() {
    setState(() {
      flous = (((_numberFrom.toString().split(".")[0]) != "0")
          ? (NumberToWordsEnglish.convert(
          int.parse(_numberFrom.toString().split(".")[0])))
          : "zero") +
          " Dinar & " +
          ((((_numberFrom.toString().split(".")[1] + "000").substring(0, 3)) !=
              "000")
              ? NumberToWordsEnglish.convert(int.parse(
              ((_numberFrom.toString().split(".")[1] + "000")
                  .substring(0, 3))))
              : "zero") +
          " Millime";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Measures Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Measures Converter'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Neonpen(
                text: const Text(
                  'Workshop 2 ',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                color: Colors.purple,
                padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                opacity: 0.3,
                emphasisWidth: 10,
                emphasisOpacity: 0.3,
                emphasisAngleDegree: 2,
                enableLineZiggle: true,
                lineZiggleLevel: 2,
                isDoubleLayer: false,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                    //Border color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ),
                    labelText: 'Enter Value',
                  ),
                  //keyboardType: TextInputType.number,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberFrom = rv;
                      });
                    }
                  },
                ),
              ),
              Text(
                (_numberFrom == null) ? '' : _numberFrom.toString(),
                style: const TextStyle(
                  fontSize: 23,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.yellow),
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(13)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
                  onPressed: () {
                    arabe();
                  },
                  child: const Text(
                    'Convert to arabic',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(13)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
                  onPressed: () {
                    anglais();
                  },
                  child: const Text(
                    'Convert to english',
                  )),
              const SizedBox(height: 20),
              Container(
                width: 300,
                child: Text(
                  flous,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 30,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
