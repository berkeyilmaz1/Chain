import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:schallange/components/myAlertBox.dart';
import 'package:schallange/constants/constants.dart';

class MyRatingBar extends StatelessWidget {
  const MyRatingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: 0,
        itemCount: 5,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const Icon(
                Icons.sentiment_very_dissatisfied,
                color: Colors.red,
              );
            case 1:
              return const Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.redAccent,
              );
            case 2:
              return const Icon(
                Icons.sentiment_neutral,
                color: Colors.amber,
              );
            case 3:
              return const Icon(
                Icons.sentiment_satisfied,
                color: Colors.lightGreen,
              );
            case 4:
              return const Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.green,
              );
            default:
              return Container();
          }
        },
        onRatingUpdate: (rating) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              switch (rating) {
                case 0:
                  return myAlertBox(
                    rating: rating,
                    message: ratingTexts.zero,
                  );
                case 1:
                  return myAlertBox(
                    rating: rating,
                    message: ratingTexts.one,
                  );
                case 2:
                  return myAlertBox(
                    rating: rating,
                    message: ratingTexts.two,
                  );
                case 3:
                  return myAlertBox(
                    rating: rating,
                    message: ratingTexts.three,
                  );
                case 4:
                  return myAlertBox(
                    rating: rating,
                    message: ratingTexts.four,
                  );
                case 5:
                  return myAlertBox(
                    rating: rating,
                    message: ratingTexts.five,
                  );
                  default:
                  return Container();
              }

              /* AlertDialog(
                title: Text('Your Rating'),
                content: Text('You rated this item as: $rating'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              ); */
            },
          );
        });
  }
}
