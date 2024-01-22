import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/bloc/message_bloc.dart';

class CustomKeyboard extends StatelessWidget {
  final String uId;

  const CustomKeyboard({super.key, required this.uId});

  @override
  Widget build(BuildContext context) {
    TextEditingController mycontroller = TextEditingController();

    return Container(
      child: Stack(
        children: <Widget>[
          const DecoratedBox(decoration: BoxDecoration()),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: mycontroller,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 12.0),
                                  child: GestureDetector(
                                    child: const Icon(
                                      Icons.send_rounded,
                                      color: Colors.black,
                                    ),
                                    onTap: () {
                                      context.read<MessageBloc>().add(
                                            SendMessageEvent(
                                              message: mycontroller.text,
                                              uId: uId,
                                              chatId: 1,
                                            ),
                                          );

                                      mycontroller.clear();
                                    },
                                  ),
                                ),
                                //  suffixIcon: Padding(
                                //         padding: const EdgeInsetsDirectional.only(end: 12.0),
                                //         child: GestureDetector(
                                //           child: const Icon(
                                //             Icons.send_rounded,
                                //             color: Colors.black,
                                //           ),
                                //           onTap: () {
                                //             context.read<MessageBloc>().add(
                                //                   SendMessageEvent(
                                //                     message: mycontroller.text,
                                //                     uId: uId,
                                //                     chatId: 1,
                                //                   ),
                                //                 );

                                //             mycontroller.clear();
                                //           },
                                //         ),
                                hintText: "Message",
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    width: 3,
                                    color: Colors.red,
                                  ),
                                ),
                                counterText: "",
                              ),
                            ),
                          ),
                          // stickerButton(),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
