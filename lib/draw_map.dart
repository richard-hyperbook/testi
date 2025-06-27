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
import 'flutter_flow_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

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
  String? path;
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
  double originalXCoord = 0;
  double originalYCoord = 0;
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
    title: 'Introduction',
    body: '''
    <h3>This is a hyperbook.</h3>
    A hyperbook is an ebook composed of chapters, where the chapters are arranged neither as a simple list
    nor a a hierachy (with sections, sub-sections, etc.).  A hyperbook's chapters are an inconnected network; the links
    between chapters indicate the logical connections between the contents of the chapters, just like the
    hyperlinks connecting websites on the Internet.  The Hyperbook App automtically draws a map like this for each hyperbook, 
    with chapters represented by boxes, and links shown as arrows.  
    <a href="#How to read a hyperbook" target="_blank" style="background-color:black;color:white;padding:2px;
    border:2px solid grey;border-radius:5px">Click here to discover how to read a hyperbook</a>
    ''',
    xCoord: 40.0,
    yCoord: 140.0,
    reference: DocumentReference(path: 'Introduction'),
    readStateIndex: kNotVisitedIndex,
  ),
  Chapter(
    title: 'How to read a hyperbook',
    body:'''
“Begin at the beginning," the King said, very gravely, "and go on till you come to the end: then stop.” (Lewis Carroll, <i>Alice in Wonderland</i>) 
For many books, like <i>Alice in Wonderland</i>, that is sound advice.  However, some books are more meaningful when read by following links from one chapter to another.  
In hyperbooks, the links appear like <a href="#Chapter Colours" 
target="_blank" style="background-color:black;color:white;padding:2px;
border:2px solid grey;border-radius:5px">this</a> in the text, and as arrows in the map.  Click <a href="#Chapter Colours" target="_blank" style="background-color:black;color:white;padding:2px;
border:2px solid grey;border-radius:5px">here</a> to read more about following links and how the colours of chapters change, or click <a href="#Re-arranging the map" target="_blank" style="background-color:black;color:white;padding:2px;
border:2px solid grey;border-radius:5px">here</a> to learn about re-arranging the map.  
<p>
Also, you can double-click any chapter to read it.
    ''',

           xCoord: 340.0,
    yCoord: 140.0,
    reference: DocumentReference(path: 'How to read a hyperbook'),
    readStateIndex: kNotVisitedIndex,
  ),
  Chapter(
    title: 'Chapter Colours',
    body:'''
    <p>In a normal book, we mark the place where we have read to by inserting a 
    slip of paper as a bookmark.&nbsp; E-book readers often have a digital 
    equivalent.&nbsp; With hyperbooks, as there is no defined reading order, 
    the app keeps track for you by changing the colour of each chapter to 
    reflect its state as you read it. These are the states that a 
    chapter can be in:
    <div style="background-color:white; text-align: left;"><p>
    <span style="font-family: 'material-icons';height:100px;">visibility_off</span><font color="#9e9e9e"> not seen</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">battery_0_bar</span><font color="#8bc34a"> visited</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">battery_3_bar</span><font color="#00bcd4"> partially read</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">battery_full</span><font color="#673ab7"> fully read</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">highlight</span><font color="#ffc107"> highlighted</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">thumb_down</span><font color="#ff9e80"> depreciated (i.e. not of interest)</font></p><p>
    <p><a href="#Choosing your colour palette" target="_blank" style="background-color:black;color:white;padding:2px;border:2px solid grey;border-radius:5px">Choosing your colour palette</a>
    <a href="#Changing the state of a chapter" target="_blank" style="background-color:black;color:white;padding:2px;border:2px solid grey;border-radius:5px">
    Changing the state of a chapter</a>
    <a href="#684a6749835905780600" target="_blank"style="background-color:black;color:white;padding:2px;border:2px solid grey;border-radius:5px">Comment by AA Milne: Comment 1</a>
     </div>
    ''',
    xCoord: 440.0,
    yCoord: 240.0,
    reference: DocumentReference(path: 'Chapter Colours'),
    readStateIndex: kNotVisitedIndex,
  ),
  Chapter(
    title: 'Re-arranging the map',
    body:'''
    
    ''',
    xCoord: 250.0,
    yCoord: 400.0,
    reference: DocumentReference(path: 'Re-arranging the map'),
    readStateIndex: kNotVisitedIndex,
  ),
  Chapter(
    title: 'Choosing your colour palette',
    body:'''
    <p>You can choose the colours used to represent the states that chapters 
    can be in.&nbsp; To do this, click on <i>profile</i> at the bottom of most 
    pages. Click on <i>Edit profile</i>, you will see this list - click on each 
    icon in turn to choose a colour.</p><p>
    <div style="background-color:white; text-align: left;"><p>
    <span style="font-family: 'material-icons';height:100px;"><font size="5">visibility_off</font>&nbsp;</span>
    <font color="#9e9e9e">not seen</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">
    <font size="5">battery_0_bar</font></span>&nbsp;<font color="#8bc34a">visited</font></p><p>
    <span style="font-family: 'material-icons';height:100px;"><font size="5">battery_3_bar</font></span>&nbsp;<font color="#00bcd4">partially read</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">battery_full</span>&nbsp;<font color="#673ab7">fully read</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">highlight</span><font color="#ffc107">&nbsp;highlighted</font></p><p>
    <span style="font-family: 'material-icons';height:100px;">thumb_down</span>&nbsp;<font color="#ff9e80">depreciated</font>
    </p><p> <a href="#" target="_blank" style="background-color:black;color:white;padding:2px;border:2px solid grey;border-radius:5px">title</a><br></p>
    </div>
    ''',
    xCoord: 340.0,
    yCoord: 500.0,
    reference: DocumentReference(path: 'Choosing your colour palette'),
    readStateIndex: kNotVisitedIndex,
  ),
  Chapter(
    title: 'Changing the state of a chapter',
    body:'''
    The Hyperbook App gives each chapter a colour that shows the attention
    you have given to that chapter.  Colour
    changes sometimes happen automatically, for example, when you visit a
    chapter for the first time.  Other colour changes are under your control,
    for example, if you click the <b>highlight</b> icon  
    <span style="font-family: 'material-icons';height:100px;">highlight</span>
     at the top of a chapter, the chapter's colour will change to indicate
     that you wish to return to it later.
     <p>
     It is recommended that you click the <b>partially read</b> icon
     <span style="font-family: 'material-icons';height:100px;"><font size="5">battery_3_bar</font></span>
      when you start reading each chapter; and that you click the
      <b>fully read</b> icon 
       <span style="font-family: 'material-icons';height:100px;">battery_full</span> 
       when you finish reading.  The <b>depreciated</b> icon can be clicked
       to indicate that you are unlikely to want to return to this chapter.
       
     
    
    
    ''',
    xCoord: 600.0,
    yCoord: 240.0,
    reference: DocumentReference(path: 'Changing the state of a chapter'),
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

SharedPreferences? globalSharedPrefs;
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
const double kScreenPadding = 20;
const double kButtonHeight = 22;
const FFButtonOptions kButtonOptions = FFButtonOptions(height: kButtonHeight);
const double kBoxSizeWidthFactor = 50.0;
const double kBoxSizeHeightFactor = 20.0;
const double kCollapsedBoxWidth = 75.0;
const double kCollapsedBoxHeight = 75.0;
const double kMinBoxWidth = 300.0;
const double kMinBoxHeight = 200.0;
const double kButtonBoxWidth = 160;
const double kButtonBoxHeight = kButtonHeight * 6;




const kStandardDuration = Duration(milliseconds: 500);

final List<Color> readStateColors = [
  Color.lerp(Colors.grey, Colors.white, 0.9)!,
  Color.lerp(Colors.green, Colors.white, 0.7)!,
  Color.lerp(Colors.blue, Colors.white, 0.7)!,
  Colors.blue,
  Colors.amber,
  Color.lerp(Colors.brown, Colors.orange, 0.3)!,
];

double nodeSize = 40;
DocumentReference chapterClicked = DocumentReference(path: '1');

class _DrawMapState extends State<DrawMap> {
  bool areChaptersLoaded = false;

  TextEditingController numberInputTextController = TextEditingController();
  TextEditingController zoomTextController = TextEditingController();
  TextEditingController nodeSizeTextController = TextEditingController();
  // HyperbooksRecord? thisHyperbook;

  Future<void> restoreSharedPreferences() async {
    globalSharedPrefs = await SharedPreferences.getInstance();

    for (int i = 0; i < items!.length; i++) {
      double? dx = globalSharedPrefs!.getDouble('x' + i.toString());
      double? dy = globalSharedPrefs!.getDouble('y' + i.toString());
      int? r = globalSharedPrefs!.getInt('r' + i.toString());
      print('(GP1)$dx*$dy&$r');
      if ((dx == null) || (dy == null) || (r == null)) {
        return;
      } else {
        currentChapterList[i].xCoord = dx;
        currentChapterList[i].yCoord = dy;
        currentChapterList[i].readStateIndex = globalSharedPrefs!.getInt(
          'r' + i.toString(),
        );
      }
    }
    chapterClicked.path = globalSharedPrefs!.getString('c');
  }

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
    for (int i = 0; i < currentChapterList.length; i++) {
      currentChapterList[i].originalXCoord = currentChapterList[i].xCoord!;
      currentChapterList[i].originalYCoord = currentChapterList[i].yCoord!;
    }

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
    for (int i = 0; i < items!.length; i++) {
      if (items![i].chapterReference!.path == chapterClicked.path) {
        expandedWidget = bItems[i];
      }
    }
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: 10,
            top: 10,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/hyperbooklogosvg10.svg',
                    width: 60,
                    height: 60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hyperbook App', style: TextStyle(fontSize: 25)),
                    Text('Double-click "Introduction" to get started')
                  ],
                ),
              ],
            ),
          ),
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: CurvedPainter(
              //  links: links,//links.map((item) => item.offset!).toList(),
            ),
          ),
          ..._buildItems(),
          expandedWidget,
          Positioned(
            left: MediaQuery.sizeOf(context).width - 160,
            top: 0,
            child: insertButtonBoxIcon())
        ],
      ),
      //   )
      //)
    );
  }

  Widget insertButtonBox(){
    return Container(
      height: kButtonBoxHeight,
      width: kButtonBoxWidth,
      padding: EdgeInsets.all(5),
      color: Colors.lightBlue,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        runSpacing: 10,
        spacing: 10,
        children: [
          FFButtonWidget(
            text: 'Re-centre',
            onPressed: () {
              int expandedIndex = 0;
              double expandedX = 0.0;
              double expandedY = 0.0;
              for (int i = 0; i < items!.length; i++) {
                if (items![i].chapterReference!.path ==
                    chapterClicked!.path) {
                  expandedIndex = i;
                  expandedX = items![i].offset!.dx;
                  expandedY = items![i].offset!.dy;
                  break;
                }
              }
              setState(() {
                for (int i = 0; i < items!.length; i++) {
                  currentChapterList[i].xCoord =
                      currentChapterList[i].xCoord! - expandedX + 100;
                  currentChapterList[i].yCoord =
                      currentChapterList[i].yCoord! - expandedY + 100;
                  items![i] = items![i].copyWithNewOffset(
                    Offset(
                      currentChapterList[i].xCoord!,
                      currentChapterList[i].yCoord!,
                    ),
                  );
                }
              });
            },
            options: kButtonOptions,
          ),
          FFButtonWidget(
            text: 'Reset',
            onPressed: () {
              setState(() {
                for (int i = 0; i < items!.length; i++) {
                  chapterClicked = currentChapterList[0].reference!;
                  currentChapterList[i].xCoord =
                      currentChapterList[i].originalXCoord;
                  currentChapterList[i].yCoord =
                      currentChapterList[i].originalYCoord;
                  items![i] = items![i].copyWithNewOffset(
                    Offset(
                      currentChapterList[i].originalXCoord,
                      currentChapterList[i].originalYCoord,
                    ),
                  );
                }
                populateChapters();
              });
            },
            options: kButtonOptions,
          ),
          FFButtonWidget(
            text: 'Save',
            onPressed: () async {
              globalSharedPrefs = await SharedPreferences.getInstance();
              for (int i = 0; i < items!.length; i++) {
                globalSharedPrefs!.setDouble(
                  'x' + i.toString(),
                  items![i].offset!.dx,
                );
                globalSharedPrefs!.setDouble(
                  'y' + i.toString(),
                  items![i].offset!.dy,
                );
                globalSharedPrefs!.setInt(
                  'r' + i.toString(),
                  currentChapterList[i].readStateIndex!,
                );
              }
              globalSharedPrefs!.setString('c', chapterClicked.path!);
            },
            options: kButtonOptions,
          ),
          FFButtonWidget(
            text: 'Restore',
            onPressed: () async {
              populateChapters();
              await restoreSharedPreferences();
              setState(() {});
            },
            options: kButtonOptions,
          ),
          FFButtonWidget(
            text: 'All on screen',
            onPressed: () async {
              for (int i = 0; i < items!.length; i++) {
                if (items![i].offset!.dx < 0) {
                  items![i] = items![i].copyWithNewOffset(
                    Offset(0, items![i].offset!.dy),
                  );
                }
                if (items![i].offset!.dx >
                    MediaQuery.sizeOf(context).width) {
                  items![i] = items![i].copyWithNewOffset(
                    Offset(
                      MediaQuery.sizeOf(context).width - kScreenPadding,
                      items![i].offset!.dy,
                    ),
                  );
                }
                if (items![i].offset!.dy < 0) {
                  items![i] = items![i].copyWithNewOffset(
                    Offset(items![i].offset!.dx, 0),
                  );
                }
                if (items![i].offset!.dy >
                    MediaQuery.sizeOf(context).height) {
                  items![i] = items![i].copyWithNewOffset(
                    Offset(
                      items![i].offset!.dx,
                      MediaQuery.sizeOf(context).height -
                          kScreenPadding,
                    ),
                  );
                }
              }
              // populateChapters();
              setState(() {});
            },
            options: kButtonOptions,
          ),
        ],
      ),
    );

  }

  Widget insertButtonBoxIcon(){
    return SizedBox(
      width: 40,
      height: 40,
      child: FlutterFlowIconButton(
          tooltipMessage: 'Map preferences',
          borderColor: Colors.black,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: kIconSettings,
          onPressed: () async {
            //%print('(D10-1)');
            showDialog<String>(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                          title: Text('Map preferences'),
                          content: SingleChildScrollView(
                            child: insertButtonBox(),
                                ),
                          );
                    });
              },
            );
          }),
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
      if (item.chapterReference!.path == chapterClicked!.path) {
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
        if ((items![i].chapterReference!.path == chapterClicked.path) &&
            (items![i].color == readStateColors[kNotVisitedIndex])) {
          items![i].color = readStateColors[kVisitedIndex];
          break;
        }
      }
    });
  }

  double widthOfBox(int textLength){
    double doubleTextLength = textLength.toDouble();
    double factor = sqrt(doubleTextLength) * kBoxSizeWidthFactor;
    if (factor < kMinBoxWidth){
      factor = kMinBoxWidth;
    }
    return factor;
  }

  double heightOfBox(int textLength){
    double doubleTextLength = textLength.toDouble();
    double factor = sqrt(doubleTextLength) * kBoxSizeHeightFactor;
    if (factor < kMinBoxHeight){
      factor = kMinBoxHeight;
    }
    return factor;
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
          width: (chapterClicked!.path == chapterReference!.path) ? widthOfBox(body!.length) : kCollapsedBoxWidth,
          height: (chapterClicked!.path == chapterReference!.path) ? heightOfBox(body!.length) : kCollapsedBoxHeight,
          curve: Curves.fastOutSlowIn,
          // color: (chapterClicked!.path == chapterReference!.path) ? Colors.amber : Colors.grey,
          /*onEnd: () {
            print('(HW10)');
          },*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: MouseRegion(
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  title!, overflow: TextOverflow.fade, /*style: Theme.of(context).textTheme.subhead*/
                                ),
                                SizedBox(width: 60),
                                FlutterFlowIconButton(
                                  icon: kIconPariallyRead,
                                  onPressed: () {
                                    print('HW40');
                                    for (
                                      int i = 0;
                                      i < currentChapterList.length;
                                      i++
                                    ) {
                                      if (chapterClicked.path ==
                                          currentChapterList[i].reference!.path) {
                                        globalSetState!(() {
                                          currentChapterList[i].readStateIndex =
                                              kFullyReadIndex;
                                          items![i].color =
                                              readStateColors[kPartiallyReadIndex];
                                        });
                                      }
                                    }
                                  },
                                ),
                                FlutterFlowIconButton(
                                  icon: kIconFullyRead,
                                  onPressed: () {
                                    print('HW40');
                                    for (
                                    int i = 0;
                                    i < currentChapterList.length;
                                    i++
                                    ) {
                                      if (chapterClicked.path ==
                                          currentChapterList[i].reference!.path) {
                                        globalSetState!(() {
                                          currentChapterList[i].readStateIndex =
                                              kFullyReadIndex;
                                          items![i].color =
                                          readStateColors[kFullyReadIndex];
                                        });
                                      }
                                    }
                                  },
                                ),
                                FlutterFlowIconButton(
                                  icon: kIconHighlighted,
                                  onPressed: () {
                                    print('HW41');
                                    for (
                                      int i = 0;
                                      i < currentChapterList.length;
                                      i++
                                    ) {
                                      if (chapterClicked.path ==
                                          currentChapterList[i].reference!.path) {
                                        globalSetState!(() {
                                          currentChapterList[i].readStateIndex =
                                              kHighlightedIndex;
                                          items![i].color =
                                              readStateColors[kHighlightedIndex];
                                        });
                                      }
                                    }
                                  },
                                ),
                                FlutterFlowIconButton(
                                  icon: kIconDepreciated,
                                  onPressed: () {
                                    print('HW41');
                                    for (
                                    int i = 0;
                                    i < currentChapterList.length;
                                    i++
                                    ) {
                                      if (chapterClicked.path ==
                                          currentChapterList[i].reference!.path) {
                                        globalSetState!(() {
                                          currentChapterList[i].readStateIndex =
                                              kHighlightedIndex;
                                          items![i].color =
                                          readStateColors[kDepredciatedIndex];
                                        });
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                            Container(
                              width: kDefaultNodeWidth,
                              margin: const EdgeInsets.only(top: 5.0),
                              child: //Text(body!),
                              HtmlWidget(
                                body!,
                                onTapUrl: (String value) {
                                  print('(HW1)${value}++++');
                                  String targetRef = value.substring(1);
                                  for (
                                    int i = 0;
                                    i < currentChapterList.length;
                                    i++
                                  ) {
                                    print(
                                      '(HW2)${i}????${targetRef}++++${currentChapterList[i].reference!.path}',
                                    );
                                    if (targetRef ==
                                        currentChapterList[i].reference!.path) {
                                      chapterClicked =
                                          currentChapterList[i].reference!;
                                      print(
                                        '(HW3A)${i}++++${chapterClicked.path}',
                                      );
                                      // break;
                                    }
                                    for (int i = 0; i < items!.length; i++) {
                                      print(
                                        '(HW3AA)${i}++++${items![i].chapterReference!.path}&&&&$items![i].color}',
                                      );
                                      if ((items![i].chapterReference!.path ==
                                              chapterClicked.path) &&
                                          (items![i].color ==
                                              readStateColors[kNotVisitedIndex])) {
                                        items![i].color =
                                            readStateColors[kVisitedIndex];
                                        print(
                                          '(HW3B)${i}++++${chapterClicked.path}',
                                        );
                                        // break;
                                      }
                                    }
                                    for (int i = 0; i < items!.length; i++) {
                                      if ((items![i].chapterReference!.path ==
                                              targetRef) &&
                                          (items![i].color ==
                                              readStateColors[kNotVisitedIndex])) {
                                        items![i].color =
                                            readStateColors[kVisitedIndex];
                                        print('(HW3C)${i}++++${targetRef}');
                                        // break;
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
                ),
              ),
              Expanded(child: Text(title!, overflow: TextOverflow.visible, softWrap: false,)),
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
