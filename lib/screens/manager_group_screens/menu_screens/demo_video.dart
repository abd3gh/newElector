// // ignore_for_file: avoid_print
//
// import 'package:elector/api/api_controllers/controllers.dart';
// import 'package:elector/constants.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:klocalizations_flutter/klocalizations_flutter.dart';
// import 'package:video_player/video_player.dart';
//
// class DemoVideo extends StatefulWidget {
//   const DemoVideo({Key? key}) : super(key: key);
//
//   @override
//   State<DemoVideo> createState() => _DemoVideoState();
// }
//
// class _DemoVideoState extends State<DemoVideo> {
//   late VideoPlayerController _controller;
//   var data;
//   bool isLoading = false;
//
//   getvideo() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       ApiControllers().getvideos().then((value) => {
//             setState(() {
//               isLoading = false;
//             }),
//             if (value != null)
//               {
//                 setState(() {
//                   data = value['data'];
//                 }),
//                 print("the data is $data"),
//                 _controller = VideoPlayerController.network(
//                     'http://voting.creativesarea.com/api/${data['video']}')
//                   ..initialize().then((_) {
//                     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//                     setState(() {});
//                   })
//               }
//             else
//               {}
//           });
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getvideo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: color1,
//         ),
//         title: LocalizedText(
//           'الفيديو التوضيحي',
//           style: GoogleFonts.cairo(
//             fontWeight: FontWeight.bold,
//             fontSize: 17.sp,
//             color: color1,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: white,
//         elevation: 0,
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Stack(children: [
//               Positioned(
//                 right: MediaQuery.of(context).size.width / 2,
//                 top: 200.h,
//                 child: Image.asset('assets/Ellipse 30.png'),
//               ),
//               Positioned(
//                 left: MediaQuery.of(context).size.width - 90.w,
//                 top: -80.h,
//                 child: Image.asset(
//                   'assets/Ellipse 30.png',
//                   height: 147.h,
//                   width: 147.w,
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 20.w,
//                   vertical: 10.h,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//
//                     Center(
//                       child: _controller.value.isInitialized
//                           ? AspectRatio(
//                               aspectRatio: _controller.value.aspectRatio,
//                               child: VideoPlayer(_controller),
//                             )
//                           : const CircularProgressIndicator(),
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     Visibility(
//                       visible: !isLoading,
//                       child: FloatingActionButton(
//                         backgroundColor: color1,
//                         onPressed: () {
//                           setState(() {
//                             _controller.value.isPlaying
//                                 ? _controller.pause()
//                                 : _controller.play();
//                           });
//                         },
//                         // backgroundColor: m,
//                         child: Icon(
//                           _controller.value.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow,
//
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//     );
//   }
// }

import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DemoVideo extends StatefulWidget {
  const DemoVideo({Key? key}) : super(key: key);

  @override
  State<DemoVideo> createState() => _DemoVideoState();
}

class _DemoVideoState extends State<DemoVideo> {

  bool isLoading = false;
  late YoutubePlayerController _controller;
  var data;
  getvideo() async {
    setState(() {
      isLoading = true;
    });
    try {
      ApiControllers().getvideos().then((value) => {
            if (value != null)
              {
                setState(() {
                  data = value['data'];
                  var url = data['video'];
                  _controller = YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(url)!,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  );

                    isLoading = false;

                }),
                print("the data is $data"),

              }
            else
              {}
          });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    getvideo();
  }

  @override
  void deactive() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?
        Center(child: CircularProgressIndicator(),)
        :YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: white,
          iconTheme: IconThemeData(color: color1,),
          title: Text(
            'video',
            style: GoogleFonts.mirza(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
        ),
        body: Column(
          children: [
            player,
            SizedBox(
              height: 25.h,
            ),

            WidgetButton(
              onPress: () {
                _controller.toggleFullScreenMode();
              },
              text: 'عرض بكامل الشاشة',
              buttonColor: color1,
            ),
          ],
        ),
      ),
    );
  }
}
