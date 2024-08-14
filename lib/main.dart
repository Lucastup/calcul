import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headlineMedium:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  void _launchWhatsApp() async {
    final phone = '31971963279'; // Número do telefone
    final url = Uri.parse(
        'https://wa.me/$phone?text=Olá,%20gostaria%20de%20mais%20informações!');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Não foi possível abrir o WhatsApp.';
      }
    } catch (e) {
      print('Erro ao tentar abrir o WhatsApp: $e');
      // Adicione uma UI para mostrar uma mensagem de erro para o usuário, se necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThicknessCalculator()),
                    );
                  },
                  child: Text('Calcular Espessura'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CBUQCalculator()),
                    );
                  },
                  child: Text('Calcular CBUQ'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Lucas Moreira',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _launchWhatsApp,
                  child: Text('WhatsApp'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThicknessCalculator extends StatefulWidget {
  @override
  _ThicknessCalculatorState createState() => _ThicknessCalculatorState();
}

class _ThicknessCalculatorState extends State<ThicknessCalculator> {
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _tonsController = TextEditingController();

  String _result = 'Resultado:';

  void _calculateResult() {
    final widthText = _widthController.text;
    final lengthText = _lengthController.text;
    final tonsText = _tonsController.text;

    final width = double.tryParse(widthText.replaceAll(',', '.'));
    final length = double.tryParse(lengthText.replaceAll(',', '.'));
    final tons = double.tryParse(tonsText.replaceAll(',', '.'));

    if (width == null || length == null || tons == null) {
      setState(() {
        _result = 'Por favor, insira valores válidos.';
      });
      return;
    }

    final area = width * length;

    if (area == 0) {
      setState(() {
        _result = 'Área não pode ser zero.';
      });
      return;
    }

    final intermediateResult = tons / area;
    final result = (intermediateResult / 2.4) * 100;

    setState(() {
      _result = 'Resultado: ${result.toStringAsFixed(2)} centímetros';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Espessura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Largura (em metros):'),
            TextField(
              controller: _widthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Insira a largura'),
            ),
            SizedBox(height: 10),
            Text('Comprimento (em metros):'),
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Insira o comprimento'),
            ),
            SizedBox(height: 10),
            Text('Toneladas:'),
            TextField(
              controller: _tonsController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Insira as toneladas'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateResult,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class CBUQCalculator extends StatefulWidget {
  @override
  _CBUQCalculatorState createState() => _CBUQCalculatorState();
}

class _CBUQCalculatorState extends State<CBUQCalculator> {
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _depthController = TextEditingController();

  String _result = 'Resultado:';

  void _calculateResult() {
    final widthText = _widthController.text;
    final lengthText = _lengthController.text;
    final depthText = _depthController.text;

    final width = double.tryParse(widthText.replaceAll(',', '.'));
    final length = double.tryParse(lengthText.replaceAll(',', '.'));
    final depth = double.tryParse(depthText.replaceAll(',', '.'));

    if (width == null || length == null || depth == null) {
      setState(() {
        _result = 'Por favor, insira valores válidos.';
      });
      return;
    }

    final volume = width * length * depth;
    final result = (volume * 2.4).toStringAsFixed(2);

    setState(() {
      _result = 'Resultado: $result toneladas';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de CBUQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Largura (em metros):'),
            TextField(
              controller: _widthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Insira a largura'),
            ),
            SizedBox(height: 10),
            Text('Comprimento (em metros):'),
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Insira o comprimento'),
            ),
            SizedBox(height: 10),
            Text('Profundidade (em metros):'),
            TextField(
              controller: _depthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Insira a profundidade'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateResult,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
