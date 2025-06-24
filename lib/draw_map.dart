// Automatic FlutterFlow imports
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// import '/backend/backend.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_icon_button.dart';
// import 'package:hyperbook/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow_widgets.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
// import 'package:hyperbook/appwrite_interface.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import '../../chapter_read/chapter_read_widget.dart';
import 'package:arrow_pad/arrow_pad.dart';
// import 'permissions.dart';
// import 'package:infinity_view/infinity_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

GlobalKey _keyScreen = GlobalKey();
// double _nodeSize = kDefaultNodeSize;
bool _nodeSizeHasChanged = false;
bool isDrawingMap = false;

class Link {
  Link({this.start, this.end});
  final int? start;
  final int? end;
}

List<Link> links = <Link>[
  // Link(start: 0, end: 1),
  // Link(start: 0, end: 2),
  // Link(start: 0, end: 3),
  // Link(start: 1, end: 2),
  // Link(start: 1, end: 3),
];

bool _enableTranslation = false;
bool _showMapControls = false;

// @JsonSerializable()
class DocumentReference {
  final String? path;
  DocumentReference({this.path = '0'});
  // factory DocumentReference.fromJson(Map<String, dynamic> json) =>
  //     _$DocumentReferenceFromJson(json);
  // Map<String, dynamic> toJson() => _$DocumentReferenceToJson(this);
}

class Chapter {
  String? title;
  String? body;
  double? xCoord;
  double? yCoord;
  DocumentReference? reference;
  int? readStateIndex;
  Chapter({
    required this.title,
    required this.body,
    required this.xCoord,
    required this.yCoord,
    required this.reference,
    required this.readStateIndex,
  });
}

List<Chapter> currentChapterList = [
  Chapter(
    title: 'title 1',
    body:
        'Peter said to them, <a href="#2" target="_blank" style="background-color:black;color:white;padding:2px;border:2px solid grey;border-radius:5px">link to C2</a>  <a href="#3" target="_blank" style="background-color:black;color:white;padding:2px;border:2px solid grey;border-radius:5px">link to C3</a>"Repent, and each of you be baptized in the name of Jesus Christ for the forgiveness of your sins; and you will receive the gift of the Holy Spirit. "For the promise is for you and your children and for all who are far off, as many as the Lord our God will call to Himself." And with many other words he solemnly testified and kept on exhorting them, saying, "Be saved from this perverse generation!" So then, those who had received his word were baptized; and that day there were added about three thousand souls.(Acts 2:38-41)',
    xCoord: 25.0,
    yCoord: 50.0,
    reference: DocumentReference(path: '1'),
    readStateIndex: kNotVisitedIndex,
  ),
  Chapter(
    title: 'title 2',
    body:
        "They were continually devoting themselves to the apostles' teaching and to fellowship, to the breaking of bread and to prayer. Everyone kept feeling a sense of awe; and many wonders and signs were taking place through the apostles. (Acts 2:42-43)",
    xCoord: 300.0,
    yCoord: 400.0,
    reference: DocumentReference(path: '2'),
    readStateIndex: kNotVisitedIndex,
  ),
  Chapter(
    title: 'title 3',
    body:
        '<a href="#2">XXX</a>They were continually devoting themselves to the apostles teaching and to fellowship, to the breaking of bread and to prayer. Everyone kept feeling a sense of awe; and many wonders and signs were taking place through the apostles. (Acts 2:42-43)',
    xCoord: 700.0,
    yCoord: 500.0,
    reference: DocumentReference(path: '3'),
    readStateIndex: kNotVisitedIndex,
  ),
];

class DrawMap extends StatefulWidget {
  const DrawMap({
    super.key,
    this.width,
    this.height,
    this.user,
    this.hyperbook,
    this.isIntroductionMap,
    this.hyperbookTitle,
  });

  final double? width;
  final double? height;
  final DocumentReference? user;
  final DocumentReference? hyperbook;
  final bool? isIntroductionMap;
  final String? hyperbookTitle;

  @override
  _DrawMapState createState() => _DrawMapState();
}

// List<ChaptersRecord> chapterDocs = [];

List<ItemModel>? items;
TransformationController _transformationController = TransformationController();
TextEditingController _numberInputTextController = TextEditingController();
int _previousDaysToHighlight = 0;
double xOffset = 0.0;
double yOffset = 0.0;
// int hightlightChapterIndex = 0;
const int kUserLevelNotLoggedIn = 0;
const int kUserLevelFree = 1;
const int kUserLevelPro = 2;
const int kUserLevelSupervisor = 99;

const double kAbbBarButtonSize = 40;
const double kArrowPadSize = 100;
const double mapShiftIncrement = 15.0;
const double kDefaultNodeSize = 40.0;

const String kGuestUserDisplayName = 'Guest';

const kConectedUserNodeSizePrefLabel = 'conectedUserNodeSize';
const kConectedUserXCoordPrefLabel = 'xCoord';
const kConectedUserYCoordPrefLabel = 'yCoord';
const kConectedUserReadStateIndexPrefLabel = 'readStateIndex';

const Color primary = Colors.blue;
const Color secondary = Colors.yellow;
const Color accent1 = Colors.green;
const Color accent2 = Colors.red;

const double kPhonewWidthThreashold = 650;
const double kIntroductionChapterXCoord = 50.1;
const double kIntroductionChapterYCoord = 50.2;
const double kMinRandomXCoord = 20;
const double kMinRandomYCoord = 20;
const double kMaxRandomXCoord = 300;
const double kMaxRandomYCoord = 300;
const double zoomChangeMultiplyer = 1.1;
const double kDefaultNodeWidth = 350;
const double kXFocus = 100;
const double kYFocus = 100;

const int kNotVisitedIndex = 0;
const int kVisitedIndex = 1;
const int kPartiallyReadIndex = 2;
const int kFullyReadIndex = 3;
const int kHighlightedIndex = 4;
const int kDepredciatedIndex = 5;
const String kNotVisitedString = 'Not visited';
const String kVisitedString = 'Visited';
const String kPartiallyReadString = 'Partially read';
const String kFullyReadString = 'Fully Read';
const String kHighlightedString = 'Highlighted';
const String kDepredciatedString = 'Depreciated';
const String kAwaitingApprovalString = 'Awaiting approval';

const kStandardDuration = Duration(milliseconds: 500);

final List<Color> readStateColors = [
  Color.lerp(Colors.grey, Colors.white, 0.9)!,
  Color.lerp(Colors.green, Colors.white, 0.75)!,
  Colors.lightBlue,
  Colors.blue,
  Colors.amber,
  Colors.brown,
];

double nodeSize = 40;
DocumentReference chapterClicked = DocumentReference(path: '1');

class _DrawMapState extends State<DrawMap> {
  bool areChaptersLoaded = false;

  TextEditingController numberInputTextController = TextEditingController();
  TextEditingController zoomTextController = TextEditingController();
  TextEditingController nodeSizeTextController = TextEditingController();
  // HyperbooksRecord? thisHyperbook;

  @override
  void initState() {
    super.initState();
    // setuptUserList(context);
    // thisHyperbook = getHyperbookRecordFromCache(hyperbook: widget.hyperbook);
    _enableTranslation = true;
    items = <ItemModel>[
      // ItemModel(offset: Offset(70, 100), text: 'text1A'),
      //  ItemModel(offset: Offset(200, 100), text: 'text2A'),
      //   ItemModel(offset: Offset(200, 230), text: 'text3'),
    ];
    _previousDaysToHighlight = 0;
    //print('(NW1)${items!.length}');

    populateChapters();
    areChaptersLoaded = false;
    print('(D1000)${items!.length}');
  }

  void updateNumber(int value) {
    //%print('(N2100)${_previousDaysToHighlight}&&&&${value}');
    _previousDaysToHighlight = value;
  }

  String arrowPadValue = '';
  Widget insertArrowPad(Function externalSetState) {
    if (_showMapControls) {
      return ArrowPad(
        padding: const EdgeInsets.all(8.0),
        height: kArrowPadSize,
        width: kArrowPadSize,
        iconColor: Colors.white,
        innerColor: primary,
        outerColor: secondary,
        splashColor: accent1,
        hoverColor: accent2,
        clickTrigger: ClickTrigger.onTapUp,
        onPressed: (direction) {
          xOffset = 0;
          yOffset = 0;
          switch (direction) {
            case PressDirection.up:
              {
                yOffset = -mapShiftIncrement;
                break;
              }
              ;
            case PressDirection.right:
              {
                xOffset = mapShiftIncrement;
                break;
              }
              ;
            case PressDirection.down:
              {
                yOffset = mapShiftIncrement;
                break;
              }
              ;
            case PressDirection.left:
              {
                xOffset = -mapShiftIncrement;
                break;
              }
              ;
            default:
              {
                break;
              }
          }
          print('(AP1)${xOffset}:${yOffset}');
          for (int i = 0; i < items!.length; i++) {
            items![i] = items![i].copyWithNewOffset(
              Offset(
                items![i].offset!.dx + xOffset,
                items![i].offset!.dy + yOffset,
              ),
            );
          }
          externalSetState(() {});
        },
      );
    } else {
      return Container();
    }
  }

  Widget insertZoomControl(Function externalSetState) {
    if (_showMapControls) {
      final centerX = MediaQuery.sizeOf(context).width * 0.5;
      final centerY = MediaQuery.sizeOf(context).height * 0.5;

      actionZoomChange(int value) {
        double changeMulipyer = zoomChangeMultiplyer;
        if (value < 0) {
          changeMulipyer = 1.0 / zoomChangeMultiplyer;
        }
        print('(AP20)$changeMulipyer}');
        for (int i = 0; i < items!.length; i++) {
          items![i] = items![i].copyWithNewOffset(
            Offset(
              (items![i].offset!.dx - centerX) * changeMulipyer + centerX,
              (items![i].offset!.dy - centerY) * changeMulipyer + centerY,
            ),
          );
        }
        externalSetState(() {});
      }

      return SizedBox(
        width: 80,
        height: 60,
        child: Container(
          width: 100,
          child: NumberInputPrefabbed.directionalButtons(
            initialValue: 0,
            onIncrement: (value) {
              actionZoomChange(1);
            },
            onDecrement: (value) {
              actionZoomChange(-1);
            },
            isInt: true,
            scaleHeight: 0.8,
            controller: zoomTextController,
            style: TextStyle(fontSize: 0.1),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget insertRecentHighlightControl() {
    return Container(
      width: 400,
      height: 100,
      child: Wrap(
        children: [
          Text('Indicate changes more recent than '),
          Container(
            width: 70,
            child: NumberInputPrefabbed.directionalButtons(
              initialValue: _previousDaysToHighlight,
              onChanged: (value) {
                updateNumber(value.toInt());
              },
              onIncrement: (value) {
                updateNumber(value.toInt());
              },
              onDecrement: (value) {
                updateNumber(value.toInt());
              },
              isInt: true,
              scaleHeight: 0.8,
              controller: numberInputTextController,
            ),
          ),
          Text(' days'),
        ],
      ),
    );
  }

  Widget insertNodeSizeControl() {
    // setCachedConnectedUsersList(widget.hyperbook!);
    // int? connectedUserIndex = getCurrentConnectedUserIndex(widget.hyperbook!);
    // print('(PR20)${connectedUserIndex}');
    return Container(
      width: 400,
      height: 100,
      child: Wrap(
        children: [
          Text('Set size of nodes in map  '),
          Container(
            width: 100,
            child: NumberInputPrefabbed.directionalButtons(
              initialValue:
                  1, // currentCachedConnectedUsers[connectedUserIndex!].nodeSize!,
              onChanged: (value) {
                nodeSize = value.toDouble();
                _nodeSizeHasChanged = true;
              },
              onIncrement: (value) {
                // currentCachedConnectedUsers[connectedUserIndex].nodeSize =
                //     value.toDouble();
                nodeSize = value.toDouble();
                _nodeSizeHasChanged = true;
              },
              onDecrement: (value) {
                print('(N3910)${value}');
                // currentCachedConnectedUsers[connectedUserIndex].nodeSize =
                //     value.toDouble();
                nodeSize = value.toDouble();
                _nodeSizeHasChanged = true;
              },
              isInt: true,
              scaleHeight: 0.8,
              controller: nodeSizeTextController,
            ),
          ),
          Text(' pixels'),
        ],
      ),
    );
  }

  Widget insertMapSaveButton() {
    return Padding(padding: const EdgeInsets.all(8.0));
  }

  Widget insertShowMapControls(Function localSetState) {
    return SizedBox(
      width: 350,
      child: CheckboxListTile(
        title: Text('Show map controls'),
        isError: false,
        tristate: false,
        value: _showMapControls,
        onChanged: (bool? value) {
          localSetState(() {
            _showMapControls = value!;
          });
        },
      ),
    );
  }

  Widget makeScreen() {
    print('(RA1A)${0}');
    //populateChapters();
    // setCachedConnectedUsersList(widget.hyperbook!);
    // int? connectedUserIndex = getCurrentConnectedUserIndex(widget.hyperbook!);
    // print('(RA1B)${connectedUserIndex}&&&&${_nodeSizeHasChanged}');
    // if (connectedUserIndex == null) {
    //   return Center(child: Text('Hyperbook map not available'));
    // }
    List<Widget> bItems = _buildItems();
    Widget expandedWidget = bItems.first;
    for(int i = 0; i < items!.length; i++){
      if(items![i].chapterReference!.path == chapterClicked.path){
        expandedWidget = bItems[i];
      }
    }
    return Scaffold(
      body: SizedBox(
        height: 500,
        width: 2000,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: CurvedPainter(
                  //  links: links,//links.map((item) => item.offset!).toList(),
                ),
              ),
              ..._buildItems(),
              expandedWidget,
              // Positioned(left: 0, top: 0, child: insertArrowPad(setState)),
            ],
          ),
        ),
      ),
      //   )
      //)
    );
  }

  void populateChapters(
    //   DocumentReference? parent
  ) {
    // List<ChaptersRecord> chapterList =
    //     await queryChaptersRecordOnce(parent: parent);
    // List<ReadReferencesRecord> readReferenceList = [];
    //     await queryReadReferencesRecordOnce(parent: widget.user);

    //+//%print('(C87-0)$chapterList');
    //+//%print('(C87-1)$readReferenceList');
    areChaptersLoaded = true;
    items!.clear();
    for (int i = 0; i < currentChapterList.length; i++) {
      final Chapter chapter = currentChapterList[i];

      final List<Color> defaultColors = <Color>[
        Colors.grey,
        Colors.lime,
        Colors.lightBlue,
        Colors.blue,
        Colors.amber,
        Colors.blueGrey,
      ];

      double x = currentChapterList[i].xCoord!;
      double y = currentChapterList[i].yCoord!;
      final String title = currentChapterList[i].title!;
      final String body = currentChapterList[i].body!;
      Color color = Colors.amber;
      int state = 0;
      print('(HW4)${i}....${currentChapterList[i].reference}');

      items!.add(
        ItemModel(
          offset: Offset(x, y),
          title: title,
          body: body,
          color: readStateColors[currentChapterList[i].readStateIndex!],
          chapterState: state,
          borderRadius: 0,
          chapterReference: currentChapterList[i].reference,
        ),
      );
    }

    //%print('(D43-1)${links.length}');
    links.clear();
    for (int i = 0; i < currentChapterList.length; i++) {
      int stringPos = 0;
      int subStartPos = 0;
      int subEndPos = 0;
      String body = currentChapterList[i].body!;
      while (stringPos != -1) {
        String targetRef = '';
        subStartPos = body.indexOf('#', stringPos);
        if (subStartPos != -1) {
          subEndPos = body.indexOf('"', subStartPos);
          if (subEndPos != -1) {
            targetRef = body.substring(subStartPos + 1, subEndPos);
            for (int j = 0; j < currentChapterList.length; j++) {
              print(
                '(D43-1A)${i}%${j}£${currentChapterList[j].reference!.path!.length}&&&&${targetRef.length}|${currentChapterList[j].reference!.path.runtimeType}====${targetRef.characters}<<<<',
              );
              print(
                '(D43-1B)${currentChapterList[j].reference!.path == targetRef}%%%%${(currentChapterList[j].reference!.path).toString().compareTo(targetRef)}++++${currentChapterList[j].reference!.path.toString() == targetRef}',
              );
              if (currentChapterList[j].reference!.path == targetRef) {
                links.add(Link(start: i, end: j));
                print('(D43-2)${links.length}');
                break;
              }
            }
            print('(D43-3)$subEndPos');
            subStartPos = subEndPos;
          }
          print('(D43-4)$subEndPos');
          if (subEndPos > 0) {
            stringPos = subEndPos;
          } else {
            stringPos = -1;
          }
          print('(D43-5)$subEndPos');
        } else {
          stringPos = -1;
        }
        print('(D43-6)$subEndPos');
      }
      print('(D43-7)$subEndPos');
    }
    print('(D43-8)${links.length}');

    return;
  }

  Function onDragStart(int index) => (double x, double y) {
    print('(D23-1)$x*$y?${Offset(x, y)}');
    setState(() {
      items![index] = items![index].copyWithNewOffset(Offset(x, y));
    });
  };

  @override
  Widget build(BuildContext context) {
    //populateChapters();
    print('NN91Build draw_map');

    return makeScreen();
  }

  List<Widget> _buildItems() {
    final List<Widget> res = <Widget>[];
    int expandedItemIndex = 0;
    int itemCount = 0;
    print('(D21)${items!.length}');
    items!.asMap().forEach((int ind, ItemModel item) {
      print('(D26)${item.title}#${item.offset}@');
      res.add(
        _Item(
          onDragStart: onDragStart(ind),
          offset: item.offset,
          title: item.title,
          chapterReference: item.chapterReference, //item.chapter,
          body: item.body,
          color: item.color,
          hyperbook: widget.hyperbook,
          chapterState: item.chapterState,
          readReference: null, //item.readReference,
          borderRadius: item.borderRadius,
          chapterSymbol: null, //item.chapterSymbol,
          hyperbookTitle: widget.hyperbookTitle,
          // chapter: item.
          chapterAuthor: null, //item.chapterAuthor,
          chapterXCoord: item.chapterXCoord,
          chapterYCoord: item.chapterYCoord,
          createdTime: null, //item.createdTime,
          modifiedTime: null, //item.modifiedTime,
          globalSetState: setState,
        ),
      );
      if(item.chapterReference!.path == chapterClicked!.path){
        expandedItemIndex = itemCount;
      }
    });
    //%print('(D22)$res%$items');
/*
    //List<Widget> builtItems = _buildItems();
    int expandedItemIndex = 0;
    for (int i = 0; i < res.length; i++) {
      if (res[i].chapterReference!.path == chapterClicked!.path) {
        expandedItemIndex = i;
        break;
      }
    }
    Widget tempItem = builtItems[expandedItemIndex];
    builtItems[expandedItemIndex] = builtItems.last;
    builtItems.last = tempItem;
    */
    return res;
  }
}

// bool heightWidthFlag = false;
bool borderRadius = false;
bool heartbeatFlag = false;
bool translateFlag = false;
bool aflag = false;

// var animatedWithHeight = Text(
//   "My Height and width will start animating upon click",
// );

class _Item extends StatelessWidget {
  const _Item({
    this.offset,
    this.onDragStart,
    this.title,
    this.chapterReference,
    this.body,
    this.color,
    this.hyperbook,
    this.chapterState,
    this.readReference,
    this.borderRadius,
    this.chapterSymbol,
    this.hyperbookTitle,
    this.chapter,
    this.chapterAuthor,
    this.chapterXCoord,
    this.chapterYCoord,
    this.createdTime,
    this.modifiedTime,
    this.globalSetState,
  });

  // final double? size = 40;
  final Offset? offset;
  final Function? onDragStart;
  final String? title;
  final DocumentReference? chapterReference;
  final String? body;
  final Color? color;
  final DocumentReference? hyperbook;
  final int? chapterState;
  final DocumentReference? readReference;
  final double? borderRadius;
  final String? chapterSymbol;
  final String? hyperbookTitle;
  final Chapter? chapter;
  final DocumentReference? chapterAuthor;
  final double? chapterXCoord;
  final double? chapterYCoord;
  final DateTime? createdTime;
  final DateTime? modifiedTime;
  final Function? globalSetState;

  _handleDrag(details) {
    // final positionScreen = _keyScreen.currentContext!.findRenderObject()!.localToGlobal(Offset.zero);

    print('(D23-0)$details££££${details.globalPosition}');
    final x = details.globalPosition.dx /*+ xOffset*/;
    final y = details.globalPosition.dy - 100 /*+ yOffset*/;
    onDragStart!(x, y);
  }

  bool highlightChapter(DateTime modifiedTime) {
    int days = DateTime.now().difference(modifiedTime).inDays;
    print('(N2110)${days}####${DateTime.now()}&&&&${modifiedTime}');
    return (days < _previousDaysToHighlight);
  }

  void animateHeightWidth(DocumentReference chapterReference) {
    globalSetState!(() {
      chapterClicked = chapterReference;
      // animatedWithHeight = Text("");
      // heightWidthFlag = !heightWidthFlag;
      for (int i = 0; i < currentChapterList.length; i++) {
        if (currentChapterList[i].reference!.path == chapterClicked.path) {
          currentChapterList[i].readStateIndex = kVisitedIndex;
          break;
        }
      }
      for (int i = 0; i < items!.length; i++) {
        if (items![i].chapterReference!.path == chapterClicked.path) {
          items![i].color = readStateColors[kVisitedIndex];
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('(D27)${title}++++${body}^^^^${offset!.dy}');
    bool isRecentChangesZero = _previousDaysToHighlight == 0;
    double nodeSize = kDefaultNodeSize;
    return Positioned(
     // duration: kStandardDuration,
      left: offset!.dx - nodeSize / 2 /*+ xOffset*/,
      top: offset!.dy - nodeSize / 2 /*+ yOffset*/,
      child: GestureDetector(
        onPanStart: (details) {
          print('(N1000)${details}');
          _enableTranslation = false;
          _handleDrag(details);
        },
        onPanUpdate: (details) {
          print('(N1001)${details}%${_transformationController.value}');
          _handleDrag(details);
          _enableTranslation = true;
        },
        onDoubleTap: () {
          animateHeightWidth(chapterReference!);
        },
        child: AnimatedContainer(
          duration: kStandardDuration,
          height: (chapterClicked!.path == chapterReference!.path) ? 400 : 75,
          width: (chapterClicked!.path == chapterReference!.path) ? 400 : 75,
          // color: (chapterClicked!.path == chapterReference!.path) ? Colors.amber : Colors.grey,
          onEnd: () {
            print('(HW10)');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MouseRegion(
                cursor: SystemMouseCursors.precise,
                child: Container(
                  // width: nodeSize,
                  // height: nodeSize,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    // width: nodeSize! - 8.0,
                    // height: nodeSize! - 8.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          title! /*style: Theme.of(context).textTheme.subhead*/,
                        ),
                        new Container(
                          width: kDefaultNodeWidth,
                          margin: const EdgeInsets.only(top: 5.0),
                          child: //Text(body!),
                          HtmlWidget(
                            body!,
                            onTapUrl: (String value) {
                              print('(HW1)${value}++++');
                              String targetRef = value.substring(1);
                              for (
                                int i = 0; i < currentChapterList.length; i++){
                                print(
                                  '(HW2)${i}????${targetRef}++++${currentChapterList[i].reference!.path}',
                                );
                                if (targetRef ==
                                    currentChapterList[i].reference!.path) {
                                  chapterClicked =
                                      currentChapterList[i].reference!;
                                  print('(HW3)${i}++++${chapterClicked.path}');
                                  break;
                                }
                                for (int i = 0; i < items!.length; i++) {
                                  if (items![i].chapterReference!.path == chapterClicked.path) {
                                    items![i].color = readStateColors[kVisitedIndex];
                                    break;
                                  }
                                }
                                for (int i = 0; i < items!.length; i++) {
                                  if (items![i].chapterReference!.path == targetRef) {
                                    items![i].color = readStateColors[kVisitedIndex];
                                    break;
                                  }
                                }
                                globalSetState!(() {});
                              }
                              return true;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(title!),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  // CurvedPainter({this.offsets});
  // final List<Offset>? offsets;
  //  CurvedPainter({));
  // final List<Link>? links;

  @override
  void paint(Canvas canvas, Size size) {
    print('(XH14A)$links%');
    if (links.isNotEmpty) {
      links.asMap().forEach((int index, Link link) {
        // if (index == 0) return;
        final Offset o2 =
            items![links[index].start!].offset! /*+ Offset(xOffset, yOffset)*/;
        final Offset o1 =
            items![links[index].end!].offset! /*+ Offset(xOffset, yOffset*/;
        print('(D42)$o1*$o2&$index?$link');
        canvas.drawLine(
          o1,
          o2,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2,
        );
        final double x1 = o1.dx;
        final double y1 = o1.dy;
        final double x2 = o2.dx;
        final double y2 = o2.dy;
        final double xDiff = x2 - x1;
        final double yDiff = y2 - y1;
        final double angle = atan2(yDiff, xDiff);
        final double transx = (x1 + x2) * 0.5;
        final double transy = (y1 + y2) * 0.5;
        canvas.translate(transx, transy);
        canvas.rotate(angle);
        final Paint paint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0;
        canvas.drawLine(const Offset(0.0, 0.0), const Offset(10.0, 5.0), paint);
        canvas.drawLine(
          const Offset(0.0, 0.0),
          const Offset(10.0, -5.0),
          paint,
        );
        canvas.rotate(-angle);
        canvas.translate(-transx, -transy);
      });
    }
  }

  @override
  bool shouldRepaint(CurvedPainter oldDelegate) => true;
}

class ItemModel {
  ItemModel({
    this.offset,
    this.title,
    this.body,
    this.color,
    this.chapterState,
    this.borderRadius,
    this.chapterXCoord,
    this.chapterYCoord,
    required this.chapterReference,
  });

  final Offset? offset;
  final String? title;
  final String? body;
  Color? color;
  final int? chapterState;
  final double? borderRadius;
  final double? chapterXCoord;
  final double? chapterYCoord;
  final DocumentReference? chapterReference;

  ItemModel copyWithNewOffset(Offset offset) {
    return ItemModel(
      offset: offset,
      title: title,
      body: body,
      color: color,
      chapterState: chapterState,
      borderRadius: borderRadius,
      chapterXCoord: chapterXCoord,
      chapterYCoord: chapterYCoord,
      chapterReference: chapterReference,
    );
  }
}
