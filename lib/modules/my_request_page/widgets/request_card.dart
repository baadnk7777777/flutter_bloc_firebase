import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';
import 'dart:math' as math;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  final ServicesRequest servicesRequest;
  const RequestCard({super.key, required this.servicesRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(5.0, 5.0),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: 180,
                width: 60,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey,
                      width: 2.0, // You can adjust the width as needed
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 75,
                  left: -10,
                  child: Transform.rotate(
                      angle: -math.pi / 2,
                      child: Text(
                        DateFormat.yMMMd().format(
                          servicesRequest.timestamp!.toDate().toLocal(),
                        ),
                        style: const TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 14,
                          fontFamily: 'poppins,',
                        ),
                      )))
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Request for',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return servicesRequest.rating! <= index
                                    ? const Icon(
                                        Icons.star_rounded,
                                        color: Colors.grey,
                                      )
                                    : const Icon(
                                        Icons.star_rounded,
                                        color: Colors.orangeAccent,
                                      );
                              },
                            ),
                          ),
                        ),
                        // const Row(
                        //   children: [
                        //     Icon(
                        //       Icons.star_rounded,
                        //       color: Colors.orangeAccent,
                        //     ),
                        //     Icon(
                        //       Icons.star_rounded,
                        //       color: Colors.orangeAccent,
                        //     ),
                        //     Icon(
                        //       Icons.star_rounded,
                        //       color: Colors.orangeAccent,
                        //     ),
                        //     Icon(
                        //       Icons.star_rounded,
                        //       color: Colors.grey,
                        //     ),
                        //     Icon(
                        //       Icons.star_rounded,
                        //       color: Colors.grey,
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  Text(
                    servicesRequest.serviceType.toString(),
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const Text(
                    'Issue:',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          servicesRequest.issue!,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                    TextSpan(
                        text: 'Ticket ID: ',
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: servicesRequest.id,
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent,
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
