import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

const ghDarkest = Color.fromARGB(255, 13, 17, 23);
const darker = Color.fromARGB(255, 33, 37, 43);
const lessDark = Color.fromARGB(255, 40, 44, 52);

/// Fix sometimes blurry text when using HTML renderer on web.
///
/// Works by forcing the renderer to use <p> elements instead of drawing on a canvas.
///
/// TODO: Remove when upstream is fixed :) [flutter/flutter#81215](https://github.com/flutter/flutter/issues/81215)
TextTheme _fixBlurryTextIssue81215(TextTheme theme) {
  const style = TextStyle(fontFeatures: [FontFeature.proportionalFigures()]); 
  return theme.merge(const TextTheme(
    displayLarge: style, displayMedium: style, displaySmall: style,
    headlineLarge: style, headlineMedium: style, headlineSmall: style,
    titleLarge: style, titleMedium: style, titleSmall: style,
    bodyLarge: style, bodyMedium: style, bodySmall: style,
    labelLarge: style, labelMedium: style, labelSmall: style,
  ));
}

const mainTextThemeBuilder = GoogleFonts.poppinsTextTheme;

_getTitleStyle(context) =>
    GoogleFonts.vollkorn(textStyle: Theme.of(context).textTheme.headlineMedium).copyWith(
      color: Colors.grey[400],
      fontWeight: FontWeight.w200,
);


_addFont(ThemeData baseTheme) {
  return baseTheme.copyWith(
      textTheme: _fixBlurryTextIssue81215(mainTextThemeBuilder(baseTheme.textTheme)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _addFont(ThemeData(
          primarySwatch: Colors.grey,
          useMaterial3: true,
          brightness: Brightness.dark,
          backgroundColor: darker,
          canvasColor: ghDarkest,
          cardTheme: CardTheme(
            elevation: 0,
            shadowColor: Colors.transparent,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.grey[200]!,
              )
            )
          )
      )),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(
            image: NetworkImage(images.first),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.40),
              BlendMode.dstATop,
            ))),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        ),
                        child: Column(
                          children: [
                            ..._buildContent(context)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Flexible(child: SizedBox()),
              const _FooterChip2(),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildContent(context) => [
  Align(
    alignment: Alignment.topCenter,
      child: Text('Jay Warrick', style: _getTitleStyle(context)))
  ,
  const SizedBox(height: 8,),
  const Text(ResumeContent.lead),
  const Text('<LinkedIn> <GitHub> <Etc>'),
  const Details(
    summary: Text('Work'),
    details: [
      Text('Project 1'),
      Text('Project 2'),
    ],
  ),
  const Details(
    summary: Text('Projects'),
    details: [
      Text('Project 1'),
      Text('Project 2'),
    ],
  ),
];


class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        // TODO - flutter Icon & Link
        const _FooterChip(text: 'Hand built with Flutter'),
        // SizedBox(width: 12,),
        // const _FooterChip(text: 'Image from Unsplash'),
      ],
    );
  }
}


class _FooterChip2 extends StatelessWidget {
  const _FooterChip2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(color: Colors.grey[600]!, width: 1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Hand built with Flutter', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey[400]!)
          ),
          Image.network('https://img.icons8.com/color/22/flutter.png'),
        ],
      ),
    );
  }
}


class _FooterChip extends StatelessWidget {
  final String text;
  const _FooterChip({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(color: Colors.grey[500]!, width: 1),
        ),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.grey[300]!)
      ),
    );
  }
}



class ResumeContent {

  ResumeContent._();

  static const String lead = '''
    Building pro-social, well crafted tech products with a focus on cross-functional leadership. 
    Specialization in cross-platform mobile apps, food industry, IoT,  and internal automation. 
    Started in FAANG in Seattle; now going local in Austin TX.
  ''';

}



////////// Widgets

/// Ala a "Details" markdown section
class Details extends StatefulWidget {

  final Widget summary;
  final List<Widget> details;

  const Details({Key? key, required this.summary, required this.details}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Summary Toggle
        InkWell(
          child: Row(
            children: [
              expanded ? const Icon(Icons.arrow_drop_down) : const Icon(Icons.arrow_right),
              widget.summary,
            ],
          ),
          onTap: () => setState(() => expanded = !expanded),
        ),
        // Details
        if (expanded)
          ...widget.details
      ],
    );
  }
}

const image0 = 'https://images.unsplash.com/photo-1665624223976-b18dbd0fe817?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1828&q=80';
const image1 = 'https://images.unsplash.com/photo-1669647561467-891414e9b140?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1828&q=80';
const image2 = 'https://images.unsplash.com/photo-1668882706297-73b7567bf271?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
const images = [image1, image0, image2];
