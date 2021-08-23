import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_html Example'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            // Math.tex(
            //     r'f_1{(x)}=\sqrt{x-1},\hspace{0.2em}\hspace{0.2em}f_2{(x)}=x,\hspace{0.2em}\hspace{0.2em}f_3{(x)}=\tan x,\hspace{0.2em}\hspace{0.2em}f_4{(x)}={\{\begin{array}{l}\frac{x^2-1}{x-1}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\text{khi}\hspace{0.2em}\hspace{0.2em}x\neq1\\2\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\text{khi}\hspace{0.2em}\hspace{0.2em}x=1\end{array}}.'),
            html(),
          ],
        ),
      ),
    );
  }
}

Widget html() {
  return Html(
    data: r"""
                  <tex>f_1{(x)}=\sqrt{x-1},\hspace{0.2em}\hspace{0.2em}f_2{(x)}=x,\hspace{0.2em}\hspace{0.2em}f_3{(x)}=\tan x,\hspace{0.2em}\hspace{0.2em}f_4{(x)}={\{\begin{array}{l}\frac{x^2-1}{x-1}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\text{khi}\hspace{0.2em}\hspace{0.2em}x\neq1\\2\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\hspace{0.2em}\text{khi}\hspace{0.2em}\hspace{0.2em}x=1\end{array}}.</tex>
                  """,
    tagsList: Html.tags..add("tex"),
    customRender: {
      "tex": (context, element) => Math.tex(
            context.tree.element!.text,
            onErrorFallback: (FlutterMathException e) {
              return Text(e.message);
            },
          ),
    },
    shrinkWrap: true,
  );
}
