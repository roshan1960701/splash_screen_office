import 'package:flutter/material.dart';
import 'package:splash_screen/EligiblityScreenProvider.dart';
import 'package:provider/provider.dart';

class EligiblityScreen extends StatelessWidget {
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EligiblityScreenProvider>(
        create: (context) => EligiblityScreenProvider(),
        child: Builder(
            builder: (context) {

              return Scaffold(
                body: Container(
                  padding: EdgeInsets.all(16),
                  child: Form(
                      child: Consumer<EligiblityScreenProvider>(
                        builder: (context, provider, child){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,

                                    //if isEligible is null then set orange color else if it is true then set green else red
                                    color: (provider.isEligible == null) ? Colors.orangeAccent : provider.isEligible ? Colors.green : Colors.redAccent
                                ),
                                height: 50,
                                width: 50,
                              ),

                              SizedBox(height: 16,),

                              TextFormField(
                                controller: ageController,
                                decoration: InputDecoration(
                                  hintText: "Give your age",
                                ),
                              ),
                              SizedBox(height: 16,),
                              Container(
                                width: double.infinity,
                                child: FlatButton(
                                  child: Text("Check"),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: (){

                                    //getting the text from TextField and converting it into int
                                    final int age = int.parse(ageController.text.trim());

                                    //Calling the method from provider.
                                    provider.checkEligiblity(age);
                                  },
                                ),
                              ),
                              SizedBox(height: 16,),

                              Text(provider.eligiblityMessage)

                            ],
                          );
                        },
                      )
                  ),
                ),
              );
            }
        )
    );
  }
}
