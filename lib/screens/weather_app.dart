// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class WeatherApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Weather App"),
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(
//             Icons.search,
//             size: 30,
//             color: Colors.white,
//           ),
//         ),
//         actions: [
//           Container(
//             margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
//             child: GestureDetector(
//               onTap: () => print('Menu Clicked!'),
//               child: SvgPicture.asset('assets/menu.svg',
//                   height: 30, width: 30, color: Colors.white),
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/mrng.jpg',
//               fit: BoxFit.cover,
//               height: double.infinity,
//               width: double.infinity,
//             ),
//             Container(
//               decoration: BoxDecoration(color: Colors.black38),
//             ),
//             Container(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                       children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 120,
//                       ),
//                       Text(
//                         'Thrissur',
//                         style: GoogleFonts.lato(
//                           fontSize: 35,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         'Hello',
//                         style: GoogleFonts.lato(
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.symmetric(vertical: 40),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white30),
//                         ),
//                       ),

//                       Row(
//                         children: [
//                           Text(
//                             'Thrissur',
//                             style: GoogleFonts.lato(
//                               fontSize: 35,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             'Hello',
//                             style: GoogleFonts.lato(
//                               fontSize: 20,
//                               color: Colors.white,
//                             ),
//                           )
//                         ],
//                       ),

//                     ],
//                   ),
//                 ],

//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import '../models/weather_locations.dart';
import '../widgets/buildin_transform.dart';
import '../widgets/single_weather.dart';
import '../widgets/slider_dot.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  late String bgImg;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == 'Sunny') {
      bgImg = 'assets/mrng.jpg';
    } else if (locationList[_currentPage].weatherType == 'Night') {
      bgImg = 'assets/nyt.jpg';
    } else if (locationList[_currentPage].weatherType == 'Rainy') {
      bgImg = 'assets/rainy.jpg';
    } else if (locationList[_currentPage].weatherType == 'Cloudy') {
      bgImg = 'assets/cloudy.jpg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () => print('Menu Clicked!'),
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              bgImg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.only(top: 140, left: 15),
              child: Row(
                children: [
                  for (int i = 0; i < locationList.length; i++)
                    if (i == _currentPage) SliderDot(true) else SliderDot(false)
                ],
              ),
            ),
            TransformerPageView(
              scrollDirection: Axis.horizontal,
              transformer: ScaleAndFadeTransformer(),
              viewportFraction: 0.8,
              onPageChanged: _onPageChanged,
              itemCount: locationList.length,
              itemBuilder: (ctx, i) => SingleWeather(i),
            ),
          ],
        ),
      ),
    );
  }
}
