
////import 'dart:async';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_radio_player/flutter_radio_player.dart';
//
//
//class RadioTestPage extends StatefulWidget {
//  var playerState = FlutterRadioPlayer.flutter_radio_paused;
//  var volume = 0.8;
//
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<RadioTestPage> {
//  int _currentIndex = 0;
//  final List<Widget> _children = [
//    new RadioTestPage(),
//  ];
//
//  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
//
//  @override
//  void initState() {
//    super.initState();
//    initRadioService();
//  }
//
//  Future<void> initRadioService() async {
//    try {
//      await _flutterRadioPlayer.init("Flutter Radio Example", "Live", "http://live.mp3quran.net:9992/;", "false");
//    } on PlatformException {
//      print("Exception occurred while trying to register the services.");
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: const Text('Flutter Radio Player Example'),
//        ),
//        body: Center(
//          child: Column(
//            children: <Widget>[
//              StreamBuilder(
//                  stream: _flutterRadioPlayer.isPlayingStream,
//                  initialData: widget.playerState,
//                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                    String returnData = snapshot.data;
//                    print("object data: " + returnData);
//                    switch (returnData) {
//                      case FlutterRadioPlayer.flutter_radio_stopped:
//                        return RaisedButton(
//                            child: Text("Start listening now"),
//                            onPressed: () async {
//                              await initRadioService();
//                            });
//                        break;
//                      case FlutterRadioPlayer.flutter_radio_loading:
//                        return Text("Loading stream...");
//                      case FlutterRadioPlayer.flutter_radio_error:
//                        return RaisedButton(
//                            child: Text("Retry ?"),
//                            onPressed: () async {
//                              await initRadioService();
//                            });
//                        break;
//                      default:
//                        return Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              IconButton(
//                                  onPressed: () async {
//                                    print("button press data: " +
//                                        snapshot.data.toString());
//                                    await _flutterRadioPlayer.playOrPause();
//                                  },
//                                  icon: snapshot.data ==
//                                      FlutterRadioPlayer
//                                          .flutter_radio_playing
//                                      ? Icon(Icons.pause)
//                                      : Icon(Icons.play_arrow)),
//                              IconButton(
//                                  onPressed: () async {
//                                    await _flutterRadioPlayer.stop();
//                                  },
//                                  icon: Icon(Icons.stop))
//                            ]);
//                        break;
//                    }
//                  }),
//              Slider(
//                  value: widget.volume,
//                  min: 0,
//                  max: 1.0,
//                  onChanged: (value) => setState(() {
//                    widget.volume = value;
//                    _flutterRadioPlayer.setVolume(widget.volume);
//                  })),
//              Text("Volume: " + (widget.volume * 100).toStringAsFixed(0)),
//              SizedBox(
//                height: 15,
//              ),
//              Text("Metadata Track "),
//              StreamBuilder<String>(
//                  initialData: "",
//                  stream: _flutterRadioPlayer.metaDataStream,
//                  builder: (context, snapshot) {
//                    return Text(snapshot.data);
//                  }),
//              RaisedButton(child: Text("Change URL"), onPressed: () async {
//                _flutterRadioPlayer.setUrl("http://live.mp3quran.net:8008/;", "false");
//              })
//            ],
//          ),
//        ),
//        bottomNavigationBar: new BottomNavigationBar(
//            currentIndex: this._currentIndex,
//            onTap: (int index) {
//              setState(() {
//                _currentIndex = index;
//              });
//            },
//            items: [
//              BottomNavigationBarItem(
//                  icon: new Icon(Icons.home), title: new Text('Home')),
//              BottomNavigationBarItem(
//                  icon: new Icon(Icons.pages), title: new Text('Second Page'))
//            ]),
//      ),
//    );
//  }
//}

import 'dart:async';
import 'dart:math';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:player/views/play-page/play-page.dart';
import 'package:player/views/play-page/playClasses.dart';
  import 'package:rxdart/rxdart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class play2 extends StatefulWidget {
  MediaItem playmediaItem;
  play2(@required this.playmediaItem);

  @override
  MainScreen createState() => MainScreen();
}


class MainScreen extends  State<play2> {
  List<MediaItem> queue = [];

 void t= Timer(Duration(seconds: 3), () {
  print("Yeah, this line is printed after 3 seconds");

  });

  @override
  void initState() {

    print(widget.playmediaItem!=MediaLibrary.items[0]);

    if(widget.playmediaItem!=MediaLibrary.items[0])
    {

       Timer(Duration(seconds: 3),()async{
         queue.add(widget.playmediaItem);
         AudioService.connect();
         audioPlayerButton();
       });
    }
    else{
      queue.add(widget.playmediaItem);
      AudioService.connect();
      audioPlayerButton();
    }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primColor,
      body: Center(
        child: StreamBuilder<bool>(
          stream: AudioService.runningStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              // Don't show anything until we've ascertained whether or not the
              // service is running, since we want to show a different UI in
              // each case.
              return SizedBox();
            }
            final running = snapshot.data ?? false;
            return Container(
              height: 0.93.sh,
              child: Stack(
                children: [
                  Positioned(
                    left: -(1.sw),
                    child: Container(
                      height: 0.93.sh,
                      width: 2.sw,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(800.r)),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                          duration: Duration(seconds: 2),
                          curve: Curves.bounceInOut,
                          height: 150.h,
                          width: 150.h,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: primColor,
                                  width: 3.sp
                              ),
                              borderRadius: BorderRadius.circular(50.r)
                          ),
                          child: myImageContainer(context, '')
                      ),
                      autoText(widget.playmediaItem.title, 1, 17.ssp, FontWeight.w700,
                          Colors.black),
                      autoText(
                          widget.playmediaItem.artist, 1, 10.ssp, FontWeight.w400,
                          Colors.black54),
                      // UI to show when we're running, i.e. player state/controls.

                      // Queue display/controls.
                      /*
                      StreamBuilder<QueueState>(
                        stream: _queueStateStream,
                        builder: (context, snapshot) {
                          final queueState = snapshot.data;
                          final queue = queueState?.queue ?? [];
                          final mediaItem = queueState?.mediaItem;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (queue != null && queue.isNotEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.skip_previous),
                                      iconSize: 64.0,
                                      onPressed: mediaItem == queue.first
                                          ? null
                                          : AudioService.skipToPrevious,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.skip_next),
                                      iconSize: 64.0,
                                      onPressed: mediaItem == queue.last
                                          ? null
                                          : AudioService.skipToNext,
                                    ),
                                  ],
                                ),
                              if (mediaItem?.title != null) Text(mediaItem.title),
                            ],
                          );
                        },
                      ),*/
                      // Play/pause/stop buttons.
                      StreamBuilder<bool>(
                        stream: AudioService.playbackStateStream
                            .map((state) => state.playing)
                            .distinct(),
                        builder: (context, snapshot) {
                          final playing = snapshot.data ?? false;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (playing) pauseButton() else playButton(),
                              stopButton(),
                            ],
                          );
                        },
                      ),
                      // A seek bar.
                      StreamBuilder<MediaState>(
                        stream: _mediaStateStream,
                        builder: (context, snapshot) {
                          final mediaState = snapshot.data;
                          return SeekBar(
                            duration:
                            mediaState?.mediaItem?.duration ?? Duration.zero,
                            position: mediaState?.position ?? Duration.zero,
                            onChangeEnd: (newPosition) {
                              AudioService.seekTo(newPosition);
                            }, onChanged: (Duration value) {  },
                          );
                        },
                      ),
                      // Display the processing state.
                      /*
                      StreamBuilder<AudioProcessingState>(
                        stream: AudioService.playbackStateStream
                            .map((state) => state.processingState)
                            .distinct(),
                        builder: (context, snapshot) {
                          final processingState =
                              snapshot.data ?? AudioProcessingState.none;
                          return Text(
                              "Processing state: ${describeEnum(processingState)}");
                        },
                      ),
                      // Display the latest custom event.
                      StreamBuilder(
                        stream: AudioService.customEventStream,
                        builder: (context, snapshot) {
                          return Text("custom event: ${snapshot.data}");
                        },
                      ),*/
                      // Display the notification click status.
                      /*
                      StreamBuilder<bool>(
                        stream: AudioService.notificationClickEventStream,
                        builder: (context, snapshot) {
                          return Text(
                            'Notification Click Status: ${snapshot.data}',
                          );
                        },
                      ),
                      */
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Stream<MediaState> get _mediaStateStream =>
      Rx.combineLatest2<MediaItem, Duration, MediaState>(
          AudioService.currentMediaItemStream,
          AudioService.positionStream,
              (mediaItem, position) => MediaState(mediaItem, position));

  Stream<QueueState> get _queueStateStream => Rx.combineLatest2<List<MediaItem>, MediaItem, QueueState>(
      AudioService.queueStream,
      AudioService.currentMediaItemStream,
          (queue, mediaItem) => QueueState(queue, mediaItem));

  audioPlayerButton() {
    print("audio p");
    List<dynamic> list = [];
    for (int i = 0; i < queue.length; i++) {
      var m = queue[i].toJson();
      list.add(m);
    }
    var params = {"data": list};

    AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Service Demo',
      // Enable this if you want the Android service to exit the foreground state on pause.
      //androidStopForegroundOnPause: true,
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidEnableQueue: true,
      params: params,
    );
    print("audio p");

  }

  RaisedButton startButton(String label, VoidCallback onPressed) =>
      RaisedButton(
        child: Text(label),
        onPressed: onPressed,
      );

  GestureDetector pauseButton () => GestureDetector(
    onTap:  AudioService.pause,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 50.h,
      width: 50.h,
      child:  Icon(
        Icons.pause,
        color: Colors.white,
        size: 40.sp,),
      decoration: BoxDecoration(
          color: primColor,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(
              color: primColor,
              width: 1.5.sp
          )
      ),
    ),
  );

  GestureDetector playButton() => GestureDetector(
    onTap:() async {
      if(AudioService.running==false)
       {
         audioPlayerButton();
         Timer(Duration(seconds: 2),()async{
            AudioService.connect();
            await AudioService.play();
         });
       }
      else  await AudioService.play();
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 50.h,
      width: 50.h,
      child:  Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 40.sp,),
      decoration: BoxDecoration(
          color: primColor,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(
              color: primColor,
              width: 1.5.sp
          )
      ),
    ),
  );

  GestureDetector stopButton() => GestureDetector(
    onTap: (){
      AudioService.stop();
    },
    child: Container(
      height: 30.h,
      width: 30.h,
      child: Icon(
        Icons.stop,
        color: primColor, size: 20.sp,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
              color: primColor,
              width: 1.5.sp
          )
      ),
    ),
  );
}

class QueueState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  QueueState(this.queue, this.mediaItem);
}

class MediaState {
  final MediaItem mediaItem;
  final Duration position;
  MediaState(this.mediaItem, this.position);
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    @required this.onChanged,
    @required this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
   double _dragValue;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    final value = min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
        widget.duration.inMilliseconds.toDouble());
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return Stack(
      children: [
        Slider(
          activeColor: primColor,
          inactiveColor: Colors.grey,
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: value,
          onChanged: (value) {
            if (!_dragging) {
              _dragging = true;
            }
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd(Duration(milliseconds: value.round()));
            }
            _dragging = false;
          },
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  } 

  Duration get _remaining => widget.duration - widget.position;
}

// NOTE: Your entrypoint MUST be a top-level function.
void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

/// This task defines logic for playing a list of podcast episodes.

/// Provides access to a library of media items. In your app, this could come
/// from a database or web service.

class Seeker {
  final AudioPlayer player;
  final Duration positionInterval;
  final Duration stepInterval;
  final MediaItem mediaItem;
  bool _running = false;

  Seeker(
      this.player,
      this.positionInterval,
      this.stepInterval,
      this.mediaItem,
      );

  start() async {
    _running = true;
    while (_running) {
      Duration newPosition = player.position + positionInterval;
      if (newPosition < Duration.zero) newPosition = Duration.zero;
      if (newPosition > mediaItem.duration) newPosition = mediaItem.duration;
      player.seek(newPosition);
      await Future.delayed(stepInterval);
    }
  }

  stop() {
    _running = false;
  }
}
//player.duration.inMilliseconds.toDouble();