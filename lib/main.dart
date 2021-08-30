import 'package:flutter/material.dart';
import 'package:flutter_photo_view_tst/page2.dart';
import 'package:flutter_photo_view_tst/page3.dart';

void main() {
  runApp(
    AppContextProvider(MaterialApp(
//    home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/Page3': (BuildContext context) => Page3(),
        '/Page2': (BuildContext context) => Page2(),
      },
    )),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // =====> build <======

    // 圖片List
    List<String> urls = [
      'assets/images/1.jpeg',
      'assets/images/2.jpeg',
      'assets/images/3.jpeg',
      'assets/images/4.jpeg',
      'assets/images/5.jpeg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Photo View'),
      ),
      body: Column(
        children: List.generate(urls.length, (index) {
          // Gesture Detector
          return GestureDetector(
            // on Tap Event
            onTap: () {
              // 跳轉頁面
              NavigatorState nav = Navigator.of(context);

              // 設定 title , photo URL
              AppContextProvider.of(context, 'main')?.title = "main $index 標題 ";
              AppContextProvider.of(context, 'main')?.photoURL = urls[index];

              nav
                  .pushNamed('/Page2')
                  .then((value) => print('page2回傳:${value}'));

              // nav.pushNamed('/Page2', arguments: {
              //   'title': 'Page2',
              //   'photoName': urls[index]
              // }).then((res) => print(res));
            },
            child: _buildImageView(urls[index]),
          );
        }),
      ),
    );
  }

  /*
  *
  * 產生 image view
  *
  * */
  Widget _buildImageView(String url, {String title = 'demo...'}) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      // AspectRatio
      child: AspectRatio(
        aspectRatio: 16 / 9,
        // Container
        child: Container(
          // Container decoration
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover),
          ),
          // Container  (文字部分)
          child: Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(width: 8.0, color: Colors.white30),
            ),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white54,
                  fontFamily: 'Monoton',
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}

/**
 *
 * AppContextProvider
 *
 * */
class AppContextProvider extends InheritedModel<String> {
  ///Add a field for your data
  String? title;
  String? photoURL;

  AppContextProvider(Widget child) : super(child: child);

  /// Typically the `inheritFrom` method is called from a model-specific
  /// static `of` method
  static AppContextProvider? of(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<AppContextProvider>(context,
        aspect: aspect);
  }

  ///Runs once for each widget to determine if that widget should be rebuild
  ///Checks the aspect for a dependent widget and returns true if that
  ///widget should be rebuild depending on a certain condition.
  @override
  bool updateShouldNotifyDependent(
      AppContextProvider oldWidget, Set<String> aspects) {
    if (aspects.contains('title') && title != oldWidget.title) {
      print("title Only widget one is rebuild");
      return true;
    }
    if (aspects.contains('photoURL') && photoURL != oldWidget.photoURL) {
      print("photoURL Only widget two is rebuild");
      return true;
    }
    return false;
  }

  @override
  bool updateShouldNotify(AppContextProvider oldWidget) {
    print("First updateShouldNotify is checked");
    return true;
  }
}
