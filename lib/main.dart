import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:day6_exercise2/blocs/input_cubit.dart';
import 'package:day6_exercise2/blocs/input_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BlocProvider(
          create: (context) => DetectUserInput(),
          child: CheckUserInputs(title: 'Type something')),
    );
  }
}

class CheckUserInputs extends StatefulWidget {
  CheckUserInputs({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CheckUserInputsStates createState() => _CheckUserInputsStates();
}

class _CheckUserInputsStates extends State<CheckUserInputs> {
  final _nameController = TextEditingController();
  late var userInputBloc;
  bool check = false;
  String Results = "";
  void checkField() {
    setState(() {
      if (_nameController.text.isNotEmpty) {
        check = true;
      } else {
        check = false;
      }
    });
  }

  void capitalize() {
    if (check) {
      userInputBloc.toCapital(_nameController.text);
    } else {
      userInputBloc.InvalidCheck();
    }
  }

  void initState() {
    _nameController.addListener(checkField);
    super.initState();
  }

  //if state == CaptalizeState then return Text('$state.userStr')

  @override
  Widget build(BuildContext context) {
    userInputBloc = BlocProvider.of<DetectUserInput>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              BlocConsumer<DetectUserInput, UserInputsState>(
                bloc: context.read<DetectUserInput>(),
                builder: (context, state) {
                  return Center(
                      child: Column(children: [
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Say something!',
                          border: OutlineInputBorder(),
                          hintText: 'Write a sentence',
                        ),
                        controller: _nameController),
                    ElevatedButton(
                      child: Text('Capitalise it!'),
                      onPressed: () {
                        capitalize();
                      },
                    ),
                    Text(
                      Results,
                    ),
                  ]));
                },
                listener: (context, state) {
                  if (state is CapitalizeState && check == true) {
                    Results = ('${state.userStr}');
                  } else if (state is DetectUserInputsEmptyState &&
                      check == false) {
                    Results = 'You have not entered anything';
                  }
                },
              )
            ],
          ),
        ));
  }
}
