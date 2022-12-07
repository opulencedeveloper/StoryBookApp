import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/books.dart';
import '../provider/favorite_book.dart';

const double buttonSize = 40;

class BookDetailsScreen extends StatefulWidget {
  static const routeName = './book-details-route-name';
  const BookDetailsScreen({Key? key}) : super(key: key);
  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with SingleTickerProviderStateMixin {
  var _loadedInitData = false;
  String? _bookId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      _bookId = ModalRoute.of(context)?.settings.arguments.toString();
      // print(_id);
    }
    _loadedInitData = true;
  }

  late AnimationController controller;

  bool val = false;
  Color color = Colors.black;
  Color color2 = Colors.black;
  Color general = Colors.black;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  showOverlay(BuildContext context, String val) async {
    //OverlayState overlayState = Overlay.of(context);
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            top: 410,
            right: MediaQuery.of(context).size.width * 0.41,
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: val == 'UnSaved' ? 86 : 65,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff8C8C8C),
                  borderRadius: BorderRadius.circular(10),
                ),
                // radius: 10,
                child: Text(val,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            )));
    overlayState!.insert(overlayEntry);

    await Future.delayed(const Duration(seconds: 1));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    //final theme2 = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final userColor = Provider.of<Books>(context);
    final pickedColor = userColor.selectedTheme;
    bool val2 = Provider.of<FavoriteBooks>(context)
        .isBookFavorite(_bookId as String);
    pickedColor ? general = Colors.black : Colors.white;
    final loadedBook = Provider.of<Books>(context, listen: false)
        .findBookById(_bookId as String);

    Widget myAnimatedWidget() {
      if (val == false) {
        return Icon(
          Icons.star,
          color: color,
          size: 20,
          key: ValueKey(0),
        );
      }
      print("ch");
      return Icon(
        Icons.more_vert,
        color: color2,
        size: 30,
        key: ValueKey(0),
      );
    }

    Widget buildItem(IconData icon) => SizedBox(
          height: buttonSize,
          width: buttonSize,
          child: FloatingActionButton(
            heroTag:
                icon, //give each floating action button printed a unique tag to prevent error, i used the name icon beacuse it is unique to each icon printed on the floating action button
            elevation: 0,
            splashColor: Colors.black,
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Icon(
                  icon,
                  color: Colors.black,
                )),
            onPressed: (() {
              if (controller.status == AnimationStatus.completed) {
                if (icon == Icons.brightness_2_outlined) {
                  Provider.of<Books>(context, listen: false).setTheme(false);
                  return;
                }
                if (icon == Icons.brightness_2_rounded) {
                  Provider.of<Books>(context, listen: false).setTheme(true);
                  return;
                }
                setState(() {
                  val = false;
                });
                controller.reverse();
              } else {
                setState(() {
                  val = true;
                });
                controller.forward();
              }
            }),
          ),
        );
    return Scaffold(
      // extendBodyBehindAppBar: true,
      //    appBar: AppBar(
      //  actions: [
      //    Flow(
//
      //  delegate:   //FlowMenuDelegate(controller: controller),

      //  children: <IconData>[val == false ? Icons.more_vert : Icons.close,

      //  Icons.menu,

      //pickedColor ? Icons.brightness_2_outlined : Icons.brightness_2_rounded,

      //  Icons.reply,

      //  ].map(buildItem).toList(),

      //  )

      //  ,
      //  ],
      // elevation: 0.0,
      //  toolbarHeight: 140,
      //  backgroundColor: Colors. transparent,
      //leading: CircleAvatar(

      //  radius: 10,

      //    backgroundColor: Colors.blue)

      //  ),
      backgroundColor: pickedColor ? Colors.grey[100] : const Color(0xff424242),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Flow(
        delegate: FlowMenuDelegate(controller: controller),
        children: <IconData>[
          // AnimatedSwitcher(
          //     transitionBuilder: (Widget child, Animation<double> animation) => RotationTransition(
          //           child: child,
          //           turns: animation,
          //         ),
          //     duration: const Duration(seconds: 1), //milliseconds: 350
          //     child: myAnimatedWidget()),
          val == false ? Icons.more_vert : Icons.close,
          Icons.menu,
          pickedColor
              ? Icons.brightness_2_outlined
              : Icons.brightness_2_rounded,
          Icons.reply,
        ].map(buildItem).toList(),
      ),
      body: SafeArea(
        child: SizedBox(
            height: (mediaQuery.size.height - mediaQuery.padding.top),
            //padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(children: [
              SingleChildScrollView(
                  child: Column(
                children: [
                  Stack(clipBehavior: Clip.none, children: [
                    SizedBox(
                        height: 426,
                        width: double.infinity,
                        child: Image.network(
                          loadedBook.imageUrl,
                          fit: BoxFit.cover,
                          //scale: 0.1,
                        )),

                    Positioned(
                        bottom: -21,
                        right: 10,
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                const Color(0xffCAD5E7), //<-- SEE HERE

                            child: SizedBox(
                                height: buttonSize,
                                width: buttonSize,
                                child: IconButton(
                                  onPressed: () {
                                    showOverlay(
                                        context, val2 ? 'UnSaved' : 'Saved');

                                    Provider.of<FavoriteBooks>(context,
                                            listen: false)
                                        .addFavoriteBook(
                                            loadedBook.id,
                                            loadedBook.title,
                                            loadedBook.imageUrl,
                                            loadedBook.author);
                                  },
                                  color: const Color(0xff699BF7),
                                  icon: Consumer<FavoriteBooks>(
                                    builder: (_, cartBadge, _n) =>
                                        cartBadge.isBookFavorite(loadedBook.id)
                                            ? const Icon(
                                                Icons.favorite_rounded,
                                                size: 24,
                                              )
                                            : const Icon(Icons.favorite_rounded,
                                                size: 24, color: Colors.white),
                                  ),
                                ))))

                    //SizedBox(
                    //         height: buttonSize,
                    //         width: buttonSize,
                    //         child: CircleAvatar(
                    //           child: AnimatedIcon(
                    //             icon: AnimatedIcons.close_menu,
                    //             progress: controller,
                    //             size: 100,
                    //           ),
                    //         ))),
                    //radius: 20,
                    //backgroundColor: Color(0xffEDEDED),
                    //    child: Container(
                    //    height: 100,
                    //  width: 105,
                    // padding: EdgeInsets.only(left: 5),
                    //child: Flow(
                    // delegate: FlowMenuDelegate(controller: controller),
                    //  children: <IconData>[
                    //   Icons.menu,
                    //  Icons.mail,
                    //   Icons.call,
                    //Icons.notifications,
                    //].map(buildItem).toList(),
                    //  ),
                    //RaisedButton(
                    //   onPressed: () {},
                    //   color: Colors.amber,
                    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    //   child: Icon(Icons.arrow_back_ios),
                    // ))
                    //IconButton(
                    //   icon: const Icon(Icons.arrow_back_ios),
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   shape: RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(10)),
                    //   color: Colors.white,
                    // )
                    //CircleAvatar(child: Center(child: Icon(Icons.arrow_back_ios)),
                    //),
                    //    )
                  ]),
                  const SizedBox(height: 25),
                  Text(
                    loadedBook.title,
                    style: TextStyle(
                      color: pickedColor ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    loadedBook.author,
                    style: TextStyle(
                      color: pickedColor ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                      height: 20,
                      width: 75,
                      child: Row(children: [
                        Expanded(
                            child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, builder) => const Icon(
                            Icons.star,
                            size: 10,
                            color: Color(0xffFFD600),
                          ),
                        )),
                        Text(
                          '5/5',
                          style: TextStyle(
                            color: pickedColor ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ])),
                  const SizedBox(height: 18),
                  const Divider(
                    color: Color(0xff8C8C8C),
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('INTRODUCTION',
                              style: TextStyle(
                                color:
                                    pickedColor ? Colors.black : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )))),
                  const SizedBox(height: 12),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                          'The car pulled to the right, and the suitcase beside them shifted. By its scent, the fox knew it held the boy\’s clothing and the things from his room he handled most often: the photo he kept on top of his bureau and the items he hid in the bottom drawer. He pawed at a corner, hoping to pry the suitcase open enough for the boy\’s weak nose to smell these favored things and be comforted. But just then the car slowed again, this time to arumbling crawl. The boy slumped forward, his head in his hands.',
                          style: TextStyle(
                            color: pickedColor ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ))),
                  const SizedBox(height: 100),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('CHAPTER One',
                          style: TextStyle(
                            color: pickedColor ? Colors.black : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ))),
                  const SizedBox(height: 5),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'The boy is now a Man',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ))),
                  const SizedBox(height: 15),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                          'The fox felt the car slow before the boy did, as he felt everything first. Through the pads of his paws, along his spine, in the sensitive whiskers a this wrists. By the vibrations, he learned also that the road had grown coarser. He stretched up from his boy’s lap and sniffed at threads of scent leaking in through the window, which told him they were now traveling into woodlands. The sharp odors of pine—wood, bark, cones, and needles— slivered through the air like blades, but beneath that, the fox recognized softer clover and wild garlic and ferns, and also a hundred things he had never encountered before but that smelled green and urgent. \n\nThe boy sensed something now, too. He pulled his pet back to him and gripped his baseball glove more tightly. The boy’s anxiety surprised the fox. The few times they had traveled in the car before, the boy had been calm or even excited. The fox nudged his muzzle into the glove’s webbing, although he hated the leather smell. His boy always laughed when he did this. He would close the glove around his pet\’s head, play-wrestling, and in this way the fox would distract him. But today the boy lifted his pet and buried his face in the fox\’s white ruff, pressing hard',
                          style: TextStyle(
                            color: pickedColor ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ))),
                ],
              )),
              Positioned(
                  left: 10,
                  top: 10,
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xffEDEDED), //<-- SEE HERE

                      child: SizedBox(
                          height: buttonSize,
                          width: buttonSize,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.black,
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                            ),
                          )))),
            ])),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - buttonSize;
    // final yStart = size.height - buttonSize;
    for (int i = context.childCount - 1; i >= 0; i--) {
      const margin = 8;
      final childSize = context.getChildSize(i)!.width;
      final dx = (childSize + margin) * i;
      final x = xStart;
      final y = 10 - (-dx) * controller.value;
      //final ofset = i * controller.value * 50;
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
}
