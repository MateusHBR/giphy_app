import 'package:flutter/material.dart';
import 'package:giphy_app/utils/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future dataFuture;

  Api api = Api();
  @override
  void initState() {
    super.initState();
    api.getGifs().then((map) {
      print(map);
    });
  }

  Future<Map<String, dynamic>> _getDataFuture() async {
    return await api.getGifs();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.width * 0.03,
              ),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: "Pesquise aqui!",
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: api.getGifs(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Center(
                          child: Icon(
                            Icons.error,
                            size: size.height * 0.2,
                            color: Colors.red,
                          ),
                        );
                      }
                      return Container(
                        child: _createGifTable(context, snapshot, size),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createGifTable(context, snapshot, size) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: size.height * 0.02,
        mainAxisSpacing: size.width * 0.02,
      ),
      // itemCount: snapshot.data["data"].lenght,
      itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Image.network(
            snapshot.data["data"][index]["images"]["fixed_height"]["url"],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
