import 'package:flutter/material.dart';

import './tabs_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme2 = Theme.of(context);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
        //backgroundColor: Colors.black, 
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: SizedBox(
          height: 56,
          width: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: const Icon(Icons.arrow_forward, size: 40),
            onPressed: () async {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
              //Provider.of<Auth>(context, listen: false).checker();
            },
          )),
      body: SafeArea(
        child: Container(
            height: mediaQuery.size.height - mediaQuery.padding.top,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(color: 
             Color(0xff15133C).withOpacity(0.95),             //theme.primary.withOpacity(0.5),             
                // gradient: LinearGradient(
                //   colors: [
                //     Colors.white.withOpacity(0.1),
                //     theme.primary.withOpacity(0.1),
                //   ],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   stops: [0, 3],
                // ),
                ),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Storytelling has',
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 31,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Wrap(children: [
                            const Text('never been this ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 31,
                                  fontWeight: FontWeight.w700,
                                )),
                            Text('easy',
                                style: TextStyle(
                                  color: theme.primary,
                                  fontSize: 31,
                                  fontWeight: FontWeight.w700,
                                ))
                          ]),
                        ])),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/intro.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
