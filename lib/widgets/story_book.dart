import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/books.dart';
import '../screens/book_details_screen.dart';

class StoryBook extends StatelessWidget {
  final String type;
  const StoryBook({Key? key, required this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final theme2 = Theme.of(context);
    final books = Provider.of<Books>(context, listen: false).findBookType(type);
    return Container(
        margin: const EdgeInsets.only(top: 5),
        height: 305,
        alignment: Alignment.bottomLeft,
        // decoration: BoxDecoration(
        //   border: Border.all(
        //       color: theme.secondary, // Set border color
        //       width: 1.0), // Make rounded corner of border
        // ),
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 100),
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, i) => Row(children: [
                  Container(
                      width: 193,
                      color: theme.secondary,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                              top: -100,
                              child: SizedBox(
                                width: 151,
                                height: 174,
                                child: Image.network(books[i].imageUrl),
                              )),
                          Positioned(
                              top: 80,
                              child: Column(children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(books[i].title,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text('by ${books[i].author}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    )),
                                SizedBox(
                                    height: 20,
                                    width: 75,
                                    child: Row(children: [
                                      Expanded(
                                          child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, builder) =>
                                            const Icon(
                                          Icons.star,
                                          size: 10,
                                          color: Color(0xffFFD600),
                                        ),
                                      )),
                                      const Text(
                                        '5/5',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ])),
                                const SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                    height: 34,
                                    width: 143,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: books[i].type == 'recent'
                                                ? theme.primary
                                                : theme2.primaryColor,
                                            onPrimary: theme.secondary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            )),
                                        child: Text(
                                            books[i].type == 'recent'
                                                ? 'Continue Reading'
                                                : 'Start Reading',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              //color: Colors.grey,
                                            )),
                                        onPressed: () {
                                          print('ptr');
                                          Navigator.of(context).pushNamed(
                                              BookDetailsScreen.routeName,
                                              arguments: books[i].id);
                                        }))
                              ])),
                        ],
                      )),
                  const SizedBox(
                    width: 13,
                  )
                ])));
  }
}
