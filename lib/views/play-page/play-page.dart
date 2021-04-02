import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:player/views/play-page/playClasses.dart';
import 'package:audio_service/audio_service.dart';

 import '../test.dart';
/*
class Play extends StatefulWidget {
  String reciterName;
  String suraName;
  String suraLink;
  Play(this.suraName,this.reciterName,this.suraLink);

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  final BehaviorSubject<double> _dragPositionSubject =
  BehaviorSubject.seeded(null);
  List<MediaItem> queue = [];


  bool _loading;

  @override
  void initState() {
    super.initState();
    /*if(AudioService.running==true)
      AudioService.stop();*/
    _loading = false;
    for (int i = 0; i < 1; i++) {
      queue.add(
        MediaItem(
        id: widget.suraLink,//
        album: "قرآن",
        title: widget.suraName,
        artist: widget.reciterName,
        playable: true,
        duration: Duration(milliseconds: 50739),
        //artUri: "https://images-na.ssl-images-amazon.com/images/I/71Dpex3OrOL.png",
      )
      );
    }
    _startAudioPlayerBtn();
  }

  double seekPos,position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primColor,
      body: Column(
        children: <Widget>[
          myContainerAppBar(widget.reciterName),
          StreamBuilder<AudioState>(
            stream: _audioStateStream,
              builder: (context, snapshot) {
                final audioState = snapshot.data;
                final queue = audioState?.queue;
                final mediaItem = audioState?.mediaItem;
                final playbackState = audioState?.playbackState;
                final processingState =
                    playbackState?.processingState ?? AudioProcessingState.none;
                final playing = playbackState?.playing ?? false;
                return Container(
                  height: 0.93.sh,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
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
                        children: <Widget>[
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
                          autoText(widget.suraName, 1, 17.ssp, FontWeight.w700,
                              Colors.black),
                          autoText(
                              'رواية حفص عن عاصم', 1, 10.ssp, FontWeight.w400,
                              Colors.black54),
                          StreamBuilder(
                            stream: Rx.combineLatest2<double, double, double>(
                                _dragPositionSubject.stream,
                                Stream.periodic(Duration(milliseconds: 20)),
                                    (dragPosition, _) => dragPosition),

                            builder: (context, snapshot) {

                              //print(snapshot.data.toString()+"*********************************************************");
                              position = snapshot.data  ?? playbackState.currentPosition.inMilliseconds.toDouble();
                               double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
                              return Column(
                                children: [
                                  if (duration != null)
                                    Slider(
                                      min: 0.0,
                                      max: duration,
                                      value: max(0.0, min(position, duration)),
                                      activeColor: primColor,
                                      inactiveColor: Colors.grey,
                                      onChanged: (value) {
                                        _dragPositionSubject.add(value);
                                      },
                                      onChangeEnd: (value) {
                                        position = value;
                                        AudioService.seekTo(Duration(milliseconds: value.toInt()));
                                        _dragPositionSubject.add(null);
                                      },
                                    ),
                                  //    autoText("${state.currentPosition}",1,17.ssp,FontWeight.w700,Colors.black),
                                ],
                              );
                            },
                          ),
                          //positionIndicator(mediaItem, playbackState),
                     /*     Slider(
                            value: 5,
                            onChanged: (value) => {},
                            activeColor: primColor,
                            max: 20,
                          ),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    position=0.0;
                                   });
                                  AudioService.seekTo(Duration(milliseconds: 0));

                                  AudioService.pause();
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
                              ),
                              playing?
                              GestureDetector(
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
                              ):
                              GestureDetector(
                                onTap:(){
                                  setState(() {
                                    if(position==0)
                                      position=50;
                                  });
                                  AudioService.play();
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
                              ),

                              GestureDetector(
                                onTap:AudioService.rewind ,
                                child: Container(
                                  height: 30.h,
                                  width: 30.h,
                                  child: Icon(Icons.repeat, color: primColor, size: 20.sp,),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      border: Border.all(
                                          color: primColor,
                                          width: 1.5.sp
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }


  _startAudioPlayerBtn() async {
    List<dynamic> list = List();
    for (int i = 0; i < queue.length; i++) {
      var m = queue[i].toJson();
      list.add(m);
    }
    var params = {"data": list};
        setState(() {
          _loading = true;
        });
        await AudioService.start(
          androidEnableQueue:true,
          androidNotificationClickStartsActivity: true,
          androidStopForegroundOnPause: true,
          androidResumeOnClick: true,
          androidNotificationChannelDescription: 'ya rab ',
          androidArtDownscaleSize: Size.fromHeight(50),
          androidNotificationOngoing: true,
          backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
          androidNotificationChannelName: 'Audio Player',
          //androidNotificationColor: 0xFFFFFFFF,
          androidNotificationIcon: 'mipmap/ic_launcher',
          params: params,
        );
        setState(() {
          _loading = false;
        });
      }

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
    double seekPos;
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 50)),
              (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        double position = snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
        double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
        return Column(
          children: [
            if (duration != null)
              Slider(
                min: 0.0,
                max: duration,
                value: seekPos ?? max(0.0, min(position, duration)),
                activeColor: primColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  _dragPositionSubject.add(value);
                },
                onChangeEnd: (value) {
                  AudioService.seekTo(Duration(milliseconds: value.toInt()));
                  seekPos = value;
                  _dragPositionSubject.add(null);
                },
              ),
          ],
        );
      },
    );
  }
}

Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
        (queue, mediaItem, playbackState) => AudioState(
      queue,
      mediaItem,
      playbackState,
    ),
  );
}

void _audioPlayerTaskEntrypoint(List list) async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
*/
class AudioPlayerTask extends BackgroundAudioTask {
  final _mediaLibrary = MediaLibrary();
  AudioPlayer _player = new AudioPlayer();
  AudioProcessingState _skipState;
   Seeker _seeker;
  StreamSubscription<PlaybackEvent> _eventSubscription;

  List<MediaItem> queue=[] ;
  int get index => _player.currentIndex;
  MediaItem get mediaItem => index == null ? null : queue[index];

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    queue.clear();
    List mediaItems = params['data'];
    for (int i = 0; i < mediaItems.length; i++) {
      MediaItem mediaItem = MediaItem.fromJson(mediaItems[i]);
      queue.add(mediaItem);
    }
     // Broadcast media item changes.
    _player.currentIndexStream.listen((index) {
      if (index != null) AudioServiceBackground.setMediaItem(queue[index]);
    });
    // Propagate all events from the audio player to AudioService clients.
    _eventSubscription = _player.playbackEventStream.listen((event) {
      _broadcastState();
    });
    // Special processing for state transitions.
    _player.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
        // In this example, the service stops when reaching the end.
          onStop();
          break;
        case ProcessingState.ready:
        // If we just came from skipping between tracks, clear the skip
        // state now that we're ready to play.
          _skipState = null;
          break;
        default:
          break;
      }
    });

    // Load and broadcast the queue
    AudioServiceBackground.setQueue(queue);
    try {
      await _player.setAudioSource(ConcatenatingAudioSource(
        children:
        queue.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
      ));
      // In this example, we automatically start playing on start.
      onPlay();
    } catch (e) {
      print("Error: $e");
      onStop();
    }
  }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {
    // Then default implementations of onSkipToNext and onSkipToPrevious will
    // delegate to this method.
    final newIndex = queue.indexWhere((item) => item.id == mediaId);
    if (newIndex == -1) return;
    // During a skip, the player may enter the buffering state. We could just
    // propagate that state directly to AudioService clients but AudioService
    // has some more specific states we could use for skipping to next and
    // previous. This variable holds the preferred state to send instead of
    // buffering during a skip, and it is cleared as soon as the player exits
    // buffering (see the listener in onStart).
    _skipState = newIndex > index
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
    // This jumps to the beginning of the queue item at newIndex.
    _player.seek(Duration.zero, index: newIndex);
    // Demonstrate custom events.
    AudioServiceBackground.sendCustomEvent('skip to $newIndex');
  }

  @override
  Future<void> onPlay() => _player.play();

  @override
  Future<void> onPause() => _player.pause();

  @override
  Future<void> onSeekTo(Duration position) => _player.seek(position);

  @override
  Future<void> onFastForward() => _seekRelative(fastForwardInterval);

  @override
  Future<void> onRewind() => _seekRelative(-rewindInterval);

  @override
  Future<void> onSeekForward(bool begin) async => _seekContinuously(begin, 1);

  @override
  Future<void> onSeekBackward(bool begin) async => _seekContinuously(begin, -1);

  @override
  Future<void> onStop() async {
    await _player.dispose();
    await _player.stop();

    _eventSubscription.cancel();
    // It is important to wait for this state to be broadcast before we shut
    // down the task. If we don't, the background task will be destroyed before
    // the message gets sent to the UI.
    await _broadcastState();
    // Shut down this task
    await super.onStop();
  }

  Future<void> _seekRelative(Duration offset) async {
    var newPosition = _player.position + offset;
    // Make sure we don't jump out of bounds.
    if (newPosition < Duration.zero) newPosition = Duration.zero;
    if (newPosition > mediaItem.duration) newPosition = mediaItem.duration;
    // Perform the jump via a seek.
    await _player.seek(newPosition);
  }

   void _seekContinuously(bool begin, int direction) {
    _seeker?.stop();
    if (begin) {
      _seeker = Seeker(_player, Duration(seconds: 10 * direction),
          Duration(seconds: 1), mediaItem)
        ..start();
    }
  }

  /// Broadcasts the current state to all clients.
  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: [
        MediaAction.seekTo,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      ],
      androidCompactActions: [0, 1, 3],
      processingState: _getProcessingState(),
      playing: _player.playing,
      position: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    );
  }


  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState;
    switch (_player.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_player.processingState}");
    }
  }
}



