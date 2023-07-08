import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// API URL : https://api.npoint.io/99c279bb173a6e28359c/data

class Surah {
  final String arti;
  final String asma;
  final int ayat;
  final String nama;
  final String type;
  final String urut;
  final String audio;
  final String nomor;
  final String rukuk;
  final String keterangan;

  Surah({
    required this.arti,
    required this.asma,
    required this.ayat,
    required this.nama,
    required this.type,
    required this.urut,
    required this.audio,
    required this.nomor,
    required this.rukuk,
    required this.keterangan,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      arti: json['arti'],
      asma: json['asma'],
      ayat: json['ayat'],
      nama: json['nama'],
      type: json['type'],
      urut: json['urut'],
      audio: json['audio'],
      nomor: json['nomor'],
      rukuk: json['rukuk'],
      keterangan: json['keterangan'],
    );
  }
}

class SurahList extends StatefulWidget {
  @override
  _SurahListState createState() => _SurahListState();
}

class _SurahListState extends State<SurahList> {
  List<Surah> surahList = [];
  List<Surah> filteredSurahList = [];

  TextEditingController searchController = TextEditingController();

  Future<List<Surah>> fetchSurah() async {
    final response = await http.get(
      Uri.parse('https://api.npoint.io/99c279bb173a6e28359c/data'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Surah.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load surah');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSurah().then((value) {
      setState(() {
        surahList = value;
        filteredSurahList = value;
      });
    });
  }

  void filterSurah(String query) {
    List<Surah> filteredSurahs = surahList
        .where(
            (surah) => surah.nama.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredSurahList = filteredSurahs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Surah Alquran'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: searchController,
                        onChanged: filterSurah,
                        decoration: InputDecoration(
                          labelText: 'Cari Surah',
                          border: OutlineInputBorder(),
                          fillColor: Colors.pink.withOpacity(0.1),
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 2.0,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        'Nama',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Arti',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Asma',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Ayat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                  rows: filteredSurahList.map((surah) {
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          surah.nama,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                        DataCell(Text(
                          surah.arti,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                        DataCell(Text(
                          surah.asma,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                        DataCell(Text(
                          surah.ayat.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                        DataCell(Text(
                          surah.type,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      secondaryHeaderColor: Colors.blue,
      hintColor: Color.fromARGB(255, 26, 105, 151),
    ),
    home: SurahList(),
  ));
}
