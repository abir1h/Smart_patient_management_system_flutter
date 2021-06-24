import 'package:flutter/material.dart';
class CategoryCard extends StatelessWidget {
  final String imgsrc;
  final String title;
  final Function press;
  const CategoryCard({
    Key key,
    this.imgsrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -18,
              color: Colors.white70,
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          shadowColor:Colors.white70 ,
          elevation: 30.0,
          child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Image.asset(imgsrc),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}