import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Product_det extends StatefulWidget {
  const Product_det({super.key});

  @override
  State<Product_det> createState() => _Product_detState();
}

class _Product_detState extends State<Product_det> {
  @override 
  Widget build(BuildContext context) {

    bool _isFavorited = true;

    void _toggleFavorite() {
      setState(() {
        _isFavorited = !_isFavorited;
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          leading: Row(
            children: <Widget>[
              const SizedBox(
                width: 5.0,
              ),
              IconButton(
                color: const Color.fromARGB(255, 255, 0, 0),
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
              onPressed: () {},
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255), 
        body:  ListView(
          children:<Widget>[
            Column(
              children: <Widget>[
                const CarouselWithIndicatorDemo(),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.red,
                      width: 3.0
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )
                  ),
                  height: 500.0,
                  width: 500.0,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Impermeable ligero',
                            style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              '1 pieza',
                              style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const CounterDesign(),
                            const SizedBox(
                            height: 10.0,
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                            const SizedBox(
                            height: 10.0,
                            ),
                            const Text(
                              'Descripcion',
                              style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Text(
                              'Preparate para la lluvia con el impermeable ligero de HAAS F1 Team.'
                              'El impermeable es bastante ligero y con varios bolsillos para tu comodidad',
                              style: TextStyle(letterSpacing: 2.0, fontSize: 15.0, color: Colors.white),
                            ),
                            const SizedBox(
                            height: 10.0,
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                            const SizedBox(
                            height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                ButtonTheme(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255))
                                  ),
                                  height: 70.0,
                                  child:  ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 0, 0))),
                                    onPressed: _toggleFavorite,
                                    child: IconButton(
                                      icon: _isFavorited
                                        ? const Icon(
                                          Icons.favorite_border,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          )
                                        : const Icon(
                                          Icons.favorite,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        onPressed: _toggleFavorite,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 130.0,
                                ),
                                ButtonTheme(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                  height: 70.0,
                                  minWidth: 260.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 17, 0)), elevation: MaterialStateProperty.all(0.0),padding: MaterialStateProperty.all(const EdgeInsets.all(17))),
                                    onPressed: (){},
                                    child: const Text(
                                      'Añadir al carrito',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255), 
                                        fontWeight: FontWeight.bold),),
                                  ),
                                )
                              ],
                            ),
                        ]),
                      ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<CarouselWithIndicatorDemo> createState() => _CarouselWithIndicatorDemoState();
}

class _CarouselWithIndicatorDemoState extends State<CarouselWithIndicatorDemo> {
  @override
  Widget build(BuildContext context) {
    
    int _current = 0;

    final List<String> imgList = [
      "assets/images/Haas_RC.png",
      "assets/images/Haas_RC_2.png",
      "assets/images/Haas_RC_3.png",
      "assets/images/Haas_RC_4.png",
      "assets/images/Haas_RC_5.png"
    ];
    
    return Column(
      children: [
        CarouselSlider(
          items: imgList.map((item) => Container(
            child: Center(
              child: Image.asset(item.toString())),
          )).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason){
              setState(() {
                _current = index;
              });
            }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                  ? Color.fromRGBO(255, 0, 0, 1) : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

class CounterDesign extends StatefulWidget {
  const CounterDesign({super.key});

  @override
  State<CounterDesign> createState() => _CounterDesignState();
}

class _CounterDesignState extends State<CounterDesign> {
  
  int _n = 0;
  int _amt = 0;
  
  void add() {
    setState(() {
      _n++;
      _amt = _amt + 450;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
      if(_amt != 0) _amt = _amt - 450;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 143.0,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 17, 0),
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: (){
                  add();
                },
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text('$_n', style: const TextStyle(fontSize: 30.0, color: Colors.white)),
              const SizedBox(
                width: 10.0,
              ),
              IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                onPressed: (){
                  minus();
                },
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 30.0,
        ),
        Container(
          child: Text(
            'Total: $_amt mxn',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.white
            ),
          )
        ),
      ],
    );
  }
}