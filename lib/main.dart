import 'package:flutter/material.dart';
import 'package:test1009/detail_page/test_page.dart'; //切換到其他頁面

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'landscape',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 第一張圖片
              Row(
                children: [
                  const SizedBox(width: 20),
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('Image/pic1.jpg'),
                        ),
                      );
                    }
                  ),
                  const SizedBox(width: 20),
                  const Text('海科館', style: TextStyle(fontSize: 30)),
                ],
              ),

              const SizedBox(height: 30),

              // 第二張圖片
              Row(
                children: [
                  const SizedBox(width: 20),
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('Image/pic2.jpg'),
                        ),
                      );
                    }
                  ),
                  const SizedBox(width: 20),
                  const Text('基隆車站', style: TextStyle(fontSize: 30)),
                ],
              ),

              const SizedBox(height: 30),

              // 第三張圖片
              Row(
                children: [
                  const SizedBox(width: 20),
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('Image/pic3.jpg'),
                        ),
                      );
                    }
                  ),
                  const SizedBox(width: 20),
                  const Text('和平島', style: TextStyle(fontSize: 30)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Container(
              //   width: 350,
              //   height: 80,
              //
              //   decoration: BoxDecoration(
              //     borderRadius:BorderRadius.circular(50),
              //     color: Colors.yellow,
              //   ),
              //
              //   child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const SizedBox(
              //           width: 50,
              //           height: 50,
              //         ),
              //         CircleAvatar(
              //           radius: 100,
              //           backgroundImage: AssetImage('Image/pic1.jpg'),
              //         ),
              //         Text(
              //           '海科館',
              //           style: TextStyle(fontSize: 60),
              //         ),
              //       ]
              //
              //   ),
              //
              // ),
              //
              // const SizedBox(
              //   width: 30,
              //   height: 30,
              // ),
              //
              // Container(
              //   width: 350,
              //   height: 80,
              //
              //   decoration: BoxDecoration(
              //     borderRadius:BorderRadius.circular(50),
              //     color: Colors.yellow,
              //   ),
              //
              //   child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //
              //       ]
              //
              //   ),
              // ),



              ///const Gap(50),
