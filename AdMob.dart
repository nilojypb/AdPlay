import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdPlay - Ganhe Assistindo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AdPlayHomePage(),
    );
  }
}

class AdPlayHomePage extends StatefulWidget {
  @override
  _AdPlayHomePageState createState() => _AdPlayHomePageState();
}

class _AdPlayHomePageState extends State<AdPlayHomePage> {
  int _points = 0;
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeAd();
  }

  // Inicializa o anúncio
  void _initializeAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // ID de teste do AdMob
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Falha ao carregar o anúncio: $error');
        },
      ),
    );
    _bannerAd.load();
  }

  // Função para ganhar pontos ao assistir ao anúncio
  void _watchAd() {
    setState(() {
      _points += 10; // Simula ganhar pontos ao assistir um anúncio
    });
    // Lógica de exibição do anúncio real pode ser implementada aqui
    print('Pontos acumulados: $_points');
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdPlay - Ganhe Assistindo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Você tem $_points pontos!',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _watchAd,
            child: Text('Assistir a um anúncio'),
          ),
          if (_isAdLoaded) 
            Container(
              height: 50,
              child: AdWidget(ad: _bannerAd),
            ),
        ],
      ),
    );
  }
}
