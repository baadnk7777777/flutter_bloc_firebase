import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/add_request_page/add_request_import.dart';

class AddRequestPage extends StatelessWidget {
  static const String route = 'addRequest';
  const AddRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode searchFocusNode = FocusNode();
    FocusNode textFieldFocusNode = FocusNode();
    final TextEditingController issueController = TextEditingController();
    final SingleValueDropDownController singleValueDropDownController =
        SingleValueDropDownController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Request',
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromRGBO(238, 237, 237, 1),
      ),
      body: BlocBuilder<AddRequestBloc, AddRequestState>(
        builder: (context, state) {
          if (state.status == StateStatus.success ||
              state.status == StateStatus.initial) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Focus(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      DropDownTextField(
                        controller: singleValueDropDownController,
                        textFieldDecoration: const InputDecoration(
                          hintText: 'Select request',
                          hintStyle: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        listTextStyle: const TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                        dropdownColor: Colors.white,
                        clearOption: false,
                        textFieldFocusNode: textFieldFocusNode,
                        searchFocusNode: searchFocusNode,
                        // searchAutofocus: true,
                        dropDownItemCount: 1,
                        searchShowCursor: false,
                        dropDownList: const [
                          DropDownValueModel(name: 'Solar', value: "Solar"),
                        ],
                        onChanged: (value) {
                          String valueString =
                              (value as DropDownValueModel).value;

                          context
                              .read<AddRequestBloc>()
                              .add(RequestTypeChanged(valueString));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: issueController,
                        minLines: 1,
                        maxLines: 5,
                        onChanged: (value) {
                          context
                              .read<AddRequestBloc>()
                              .add(RequestIssuesChanged(issueController.text));
                        },
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontFamily: "poppins",
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                            labelText: 'Issue',
                            hintText: 'Issue',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 10.0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              // borderSide: BorderSide.none,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          context.read<AddRequestBloc>().add(
                                RequestSubmitted(
                                    context.read<LoginFormBloc>().state.uid),
                              );

                          issueController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Submit Request',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'poppins',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.status == StateStatus.loading) {
            return Expanded(
              child: Container(
                color: Colors.white,
                child: const Center(
                  child: SuccessPage(),
                ),
              ),
            );
          } else {
            return Container(
              child: const Text('error'),
            );
          }
        },
      ),
    );
  }
}
