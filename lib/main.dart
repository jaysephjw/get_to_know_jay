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

const mainTextThemeBuilder = GoogleFonts.jetBrainsMonoTextTheme;

_getTitleStyle(context) =>
    GoogleFonts.vollkorn(textStyle: Theme.of(context).textTheme.headlineMedium).copyWith(
      color: Colors.grey[300],
      fontWeight: FontWeight.w200,
);

_jobTitleStyle(context) =>
    GoogleFonts.vollkorn(textStyle: Theme.of(context).textTheme.titleLarge).copyWith(
      color: Colors.grey[200],
      shadows: [
        Shadow(color: Colors.transparent)
      ],
      // fontWeight: FontWeight.w200,
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
              Colors.black.withOpacity(.15),
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
                        maxWidth: 900,
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
              const _MadeWithFlutterChip(),
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
      child: Text('Jay Warrick', style: _getTitleStyle(context))),
  const SizedBox(height: 16),
  const Text(ResumeContent.lead),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.network('https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white'),
      const SizedBox(width: 4),
      Image.network('https://img.shields.io/badge/linkedin-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white'),
    ],
  ),
  // const Text('<LinkedIn> <GitHub> <Etc>'),
  const SizedBox(height: 8),

  const Align(
    alignment: Alignment.centerLeft,
      child: Text('Work')
  ),
  const SizedBox(height: 4),
  ...ResumeContent.jobs,
  const SizedBox(height: 8),

  // const Align(
  //     alignment: Alignment.centerLeft,
  //     child: Text('Projects')
  // ),
  // const Details(
  //   summary: Text('Projects'),
  //   details: [
  //     Text('Project 1'),
  //     Text('Project 2'),
  //   ],
  // ),
  // const SizedBox(height: 8),

  const Align(
      alignment: Alignment.centerLeft,
      child: Text('Languages')
  ),
  const SizedBox(height: 4),
  Align(
    alignment: Alignment.centerLeft,
    child: Wrap(
      spacing: 4,
      runSpacing: 4,

      children: languages.map((e) => Image.network(e)).toList(),
    ),
  ),
  const SizedBox(height: 8),

  const Align(
      alignment: Alignment.centerLeft,
      child: Text('Technologies')
  ),
  const SizedBox(height: 4),
  Align(
    alignment: Alignment.centerLeft,
    child: Wrap(
      spacing: 4,
      runSpacing: 4,
      children: technologies.map((e) => Image.network(e)).toList(),
    ),
  )
];

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class _MadeWithFlutterChip extends StatelessWidget {
  const _MadeWithFlutterChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      // decoration: ShapeDecoration(
      //   shape: StadiumBorder(
      //     side: BorderSide(color: Colors.grey[600]!, width: 1),
      //   ),
      // ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Hand built with Flutter', style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey[500]!)
          ),
          const SizedBox(width: 2),
          Image.network('https://img.icons8.com/color/18/flutter.png'),
        ],
      ),
    );
  }
}





////////// Widgets


class Job extends StatelessWidget {

  final String dateRange;
  final String title;
  final List<String> bullets;

  const Job({Key? key, required this.dateRange, required this.title, required this.bullets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bulletsStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
        fontSize: 13,
        color: Colors.grey[300]
    );
    return Details(
      summary: Text(dateRange),
      details: [
        const SizedBox(height: 2),
        IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _jobTitleStyle(context)),
              Container(height: 1, color: Colors.white),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...bullets.map((e) {
          e = e.trim();
          final boldUntil = e.indexOf(':');
          if (boldUntil > 0) {
            return RichText(
              text: TextSpan(
                  style: bulletsStyle,
                  children: [
                    TextSpan(text: '• ${e.substring(0,boldUntil+1)}\n',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: e.substring(boldUntil+1),
                        style: const TextStyle(color: Color(0xFFBDBDBD))),
                  ]
              ),
            );
          } else {
            return Text('• $e',
                style: const TextStyle(fontWeight: FontWeight.bold));
          }

        }).toList().paddedWith(const SizedBox(height: 4)),
        const SizedBox(height: 4),
      ],
    );
  }
}



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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
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
      ),
    );
  }
}

final languages = [
  'https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white',
  'https://img.shields.io/badge/Kotlin-0095D5?&style=for-the-badge&logo=kotlin&logoColor=white',
  'https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue',
  'https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white',
  'https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white',
  'https://img.shields.io/badge/Scala-DC322F?style=for-the-badge&logo=scala&logoColor=white',
  'https://img.shields.io/badge/ObjectiveC-E24628?style=for-the-badge&logo=c&logoColor=white',
];

final technologies = [
  'https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white',
  'https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white',
  'https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white',
  'https://img.shields.io/badge/ReactiveX-B7178C?style=for-the-badge&logo=reactivex&logoColor=white',
  'https://img.shields.io/badge/Bluetooth-0082FC?style=for-the-badge&logo=bluetooth&logoColor=white',
  'https://img.shields.io/badge/Jetpack_Compose-4285F4?style=for-the-badge&logo=jetpackcompose&logoColor=white',
];


class ResumeContent {
  ResumeContent._();
  static const String lead = '''
    Building pro-social, well crafted tech products with a focus on cross-functional leadership. Specialization in cross-platform mobile apps, food industry, IoT,  and internal automation. Started in FAANG in Seattle; now going local in Austin TX.
  ''';

  static const List<Job> jobs = [
    Job(
        dateRange: '2021-2022',
        title: 'Director of Technology @ PrepToYourDoor [Austin, TX]',
        bullets: [
          '''
          Lead tech strategy: Met weekly with CEO to give tech perspective on all aspects of the business, define tech strategy, and identify next area of investment
          ''',
          '''
          Built the internal tech stack: Including dozens of scripts, integrations, services, and web app to automate and internal operations and empower internal teams across the business.
          ''',
          ''' 
          Built a mini data pipeline for critical metrics: From egress, to storage, to display. Provided crucial top-level business metrics such as MAU and LTV.
          ''',
          '''
          Switched vendors for our core software platform: Coordinated the year-long effort from start to finish- from change proposal, to vendor selection, to contract, to company-wide transition plan.  
          ''',
          '''
          Improved company processes: for Standard Operating Procedures (SOPs) after evangelizing the concept. Created tracking board for OKRs. 
          ''',
          '''
          Liaison w external partners: Primary point of contact w our core tech platform   vendor. Triaged requests, managed exec interaction, drove resolution.
          ''',
        ]
    ),
    Job(
        dateRange: '2016-2020',
        title: 'Mobile Tech Lead, Flutter Lead @ Axon Enterprise [Seattle, WA]',
        bullets: [
          '''
Lead development of an ambitious cross-platform Flutter app for the NYPD: Brought Axon’s core web product, Evidence.com, truly onto mobile for the first time. Architected, planned, coded, tested, and launched the app from scratch to 1000s of public servants at the NYPD over 9 months. Worked closely with product and design to create a lean MVP and meet city deadlines.
          ''',
          '''
Served as mobile tech lead: Lead a team of 5 engineers developing 7 production iOS and Android apps used daily by thousands of public servants world-wide.
          ''',
          ''' 
Proposed and reviewed org-level design decisions: From Bluetooth protocols for connecting to IoT wearables, such as body worn cameras, to app architectures, to the mobile authentication models.
          ''',
          '''
Security & cryptographic experience: Developed with over-the-air encryption, client token management, embedded certificates, JWTs, permission grants, revocation patterns, and HLS encrypted streaming.
          ''',
          '''
Worked across code-bases: Jumped into other code bases as needed, plumbing one feature through the entire stack: SQL -> Scala -> Thrift -> JS React/Redux -> Kotlin/Swift/ObjectiveC.
          ''',
          '''
Mentored and developed team members: Interviewed and coached new hires, pair-programmed with stuck teammates, and managed and mentored interns from project to hiring decisions.
          ''',
        ]
    ),
    Job(
        dateRange: '2013-2015',
        title: 'Android Developer @ Amazon.com | Kindle Reader [Seattle, WA]',
        bullets: [
          '''
Implemented the ‘About the Book’ page in Kindle Reader on Android and E-ink devices: Involving a dynamic widget layout and content system, it’s the first page users see when opening a new book. Deployed to millions of users. 
          ''',
          '''
Became key resource during time of transition: As the most senior remaining member, trained new team members on the team’s tech stack and was the team's primary technical point of contact.
          ''',
        ]
    ),

  ];
}

const image0 = 'https://images.unsplash.com/photo-1665624223976-b18dbd0fe817?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1828&q=80';
const image1 = 'https://images.unsplash.com/photo-1669647561467-891414e9b140?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1828&q=80';
const image2 = 'https://images.unsplash.com/photo-1668882706297-73b7567bf271?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
const images = [image1, image0, image2];

extension PaddedElement<E> on List<E> {
  List<E> paddedWith(E pad) {
    final newList = List.filled(length + length - 1, pad);
    for (int i=0; i < length; i++) {
      newList[i*2] = this[i];
    }
    return newList;
  }
}