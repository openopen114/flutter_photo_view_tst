import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'main.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 取得 route 傳過來的 arguments
    // Map args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // appContext
    AppContextProvider? appContext =
        AppContextProvider.of(context, 'title,photoURL');

    // ======> build <======
    print('===> page2');

    return Scaffold(
        appBar: AppBar(
          title: Text('${appContext?.title}'),
          leading: BackButton(
            onPressed: () {
              appContext?.title = '新標題formPage2';
              Navigator.of(context).pop('===> From Page2');
            },
          ),
        ),
        body: PhotoView(
          maxScale: 2.0,
          minScale: 0.2,
          imageProvider: AssetImage('${appContext?.photoURL}'),
        ));
  }
}
