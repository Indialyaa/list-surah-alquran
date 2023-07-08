import 'package:flutter/material.dart';

class QuranPage extends StatelessWidget {
  final List<QuranData> quranList;

  const QuranPage({Key? key, required this.quranList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Surat Alquran'),
      ),
      body: ListView.builder(
        itemCount: quranList.length,
        itemBuilder: (context, index) {
          final quran = quranList[index];
          return ListTile(
            title: Text(
              '${quran.nomor}. ${quran.nama}',
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              quran.asma,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            onTap: () {
              // Aksi yang ingin diambil saat surat Alquran dipilih
              print('Surat Alquran dipilih: ${quran.nama}');
            },
          );
        },
      ),
    );
  }
}

class QuranData {
  final int nomor;
  final String nama;
  final String asma;

  QuranData({required this.nomor, required this.nama, required this.asma});
}

void main() {
  // Contoh data surat Alquran
  final List<QuranData> quranList = [
    QuranData(nomor: 1, nama: 'Al-Fatihah', asma: 'الْفَاتِحَةُ'),
    QuranData(nomor: 2, nama: 'Al-Baqarah', asma: 'الْبَقَرَةُ'),
    QuranData(nomor: 3, nama: 'Ali Imran', asma: 'آلِ عِمْرَانَ'),
    // Tambahkan surat Alquran lainnya di sini
  ];

  runApp(
    MaterialApp(
      title: 'Surat Alquran',
      home: QuranPage(quranList: quranList),
    ),
  );
}
