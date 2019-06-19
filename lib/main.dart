import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tabs(),
    ));

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Conversor de Unidades", style: TextStyle(fontSize: 25))
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                text: "Volume",
              ),
              Tab(
                text: "Medida",
              ),
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          _buildVolumeTab(),
          _buildMedidaTab(),
        ]),
      ),
    );
  }
}

Widget _buildVolumeTab() {
  final microlitroController = TextEditingController();
  final mililitroController = TextEditingController();
  final litroController = TextEditingController();

  final numberFormat = NumberFormat("#,###.######", "PT");

  void _clearAll(){
    microlitroController.text = "";
    mililitroController.text = "";
    litroController.text = "";
  }

  void _microlitroChanged(String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }

    double microlitro = double.parse(text.replaceAll(",", "."));
    mililitroController.text = numberFormat.format(microlitro / 1000);
    litroController.text = numberFormat.format(microlitro / 1000 / 1000);
  }

  void _mililitroChanged(String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }

    double mililitro = double.parse(text.replaceAll(",", "."));
    litroController.text = numberFormat.format(mililitro / 1000);
    microlitroController.text = numberFormat.format(mililitro * 1000);
  }

  void _litroChanged(String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }

    double litro = double.parse(text.replaceAll(",", "."));
    mililitroController.text = numberFormat.format(litro * 1000);
    microlitroController.text = numberFormat.format(litro * 1000 * 1000);
  }

  //Microlitro, mililitro, litro
  return Container(
    child: SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _buildTextField("Microlitro (μl)", microlitroController, _microlitroChanged),
          Divider(),
          _buildTextField("Mililitro (ml)", mililitroController, _mililitroChanged),
          Divider(),
          _buildTextField("Litro (l)", litroController, _litroChanged),
        ],
      ),
    ),
  );
}

Widget _buildMedidaTab() {
  final _microgramaController = TextEditingController();
  final _miligramaController = TextEditingController();
  final _gramaController = TextEditingController();

  final numberFormat = NumberFormat("#,###.######", "PT");

  void _clearAll(){
    _microgramaController.text = "";
    _miligramaController.text = "";
    _gramaController.text = "";
  }

  void _onMicrogramaChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }

    double micrograma = double.parse(text.replaceAll(",", "."));
    _miligramaController.text = numberFormat.format(micrograma / 1000);
    _gramaController.text = numberFormat.format(micrograma / 1000 / 1000);
  }

  void _onMiligramaChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }

    double miligrama = double.parse(text.replaceAll(",", "."));
    _gramaController.text = numberFormat.format(miligrama / 1000);
    _microgramaController.text = numberFormat.format(miligrama * 1000);
  }

  void _onGramaChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }

    double grama = double.parse(text.replaceAll(",", "."));
    _miligramaController.text = numberFormat.format(grama * 1000);
    _microgramaController.text = numberFormat.format(grama * 1000 * 1000);
  }

  //Micrograma, miligrama e grama
  return Container(
    child: SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _buildTextField("Micrograma (µg)", _microgramaController, _onMicrogramaChanged),
          Divider(),
          _buildTextField("Miligrama (mg)", _miligramaController, _onMiligramaChanged),
          Divider(),
          _buildTextField("Grama (g)", _gramaController, _onGramaChanged),
        ],
      ),
    ),
  );
}

Widget _buildTextField(String label, TextEditingController controller, Function onChanged){
  return TextField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black))),
    cursorColor: Colors.black,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
