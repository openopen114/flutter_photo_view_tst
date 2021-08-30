import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 取得 route 傳過來的 arguments
    Map args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // ======> build <======
    print('===> page2 build');

    return Scaffold(
        appBar: AppBar(
          title: Text('${args['title']}'),
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop('===> From Page2');
            },
          ),
        ),
        body: PhotoView(
          maxScale: 2.0,
          minScale: 0.2,
          imageProvider: AssetImage('${args['photoName']}'),
        ));
  }
}
