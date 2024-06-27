
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_google/model/sign_in_response_model.dart';
import '../provider/change_data_provider.dart';

class SignInDetailScreen extends StatefulWidget {
  SignInResponseModel? signInResponseData;

  SignInDetailScreen({super.key,this.signInResponseData});

  @override
  State<SignInDetailScreen> createState() => SignInDetailScreenDemo();

}

class SignInDetailScreenDemo extends State<SignInDetailScreen> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangeDataProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In Detail Screen'),
        ),
        body:  Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Row(
                children: [
                  const Text("First Name : ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                   ),
                  ),
                  Text(widget.signInResponseData!.firstName ?? "",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                  ),),
                ],
              ),
              Visibility(
                visible: widget.signInResponseData?.lastName != "" ? true : false,
                child: Row(
                  children: [
                    const Text("Last Name : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(widget.signInResponseData!.lastName ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text("Gender : ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(widget.signInResponseData!.gender ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),),
                ],
              ),
              Row(
                children: [
                  const Text("User Name : ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(widget.signInResponseData!.username ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),),
                ],
              ),
              Row(
                children: [
                  const Text("Password : ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(widget.signInResponseData!.password ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),),
                ],
              ),
              Row(
                children: [
                  const Text("Birth Date : ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(widget.signInResponseData!.birthDate ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  //for vertical space
  sizeBoxHeight() {
    return const SizedBox(
      height: 20,
    );
  }



}