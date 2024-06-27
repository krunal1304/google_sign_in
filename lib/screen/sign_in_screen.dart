
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_google/screen/sign_in_detail_screen.dart';
import '../basic/email_validation.dart';
import '../model/sign_in_response_model.dart';
import '../provider/change_data_provider.dart';
import '../service/api_base.dart';
import '../service/api_url.dart';
import '../widget/app_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenDemo();
}

class SignInScreenDemo extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _recoveryEmailController = TextEditingController();
  late BuildContext buildContext;

  final List<String> _genders = ['Male', 'Female', 'Other'];

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String? selectedGender;
  SignInResponseModel? signInModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangeDataProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In Screen'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [personalInfo(), loginInfo()],
            ),
          ),
        ),
      ),
    );
  }

  //for personal data
  personalInfo() {
    return Column(
      children: [
        AppTextFormField(
          label: "First name",
          input: TextInputType.text,
          txtController: _firstNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter first name';
            }
            if (!RegExp(r'^[a-z]+$').hasMatch(value)) {
              return 'Are you sure that you have entered your name correctly?';
            }
            return null;
          },
        ),
        sizeBoxHeight(),
        AppTextFormField(
          label: "Surname (optional)",
          input: TextInputType.text,
          txtController: _surnameController,
          validator: (value) {
            if (value!.isNotEmpty) {
              if (!RegExp(r'^[a-z]+$').hasMatch(value ?? "")) {
                return 'Are you sure that you have entered your surname correctly?';
              }
            }
            return null;
          },
        ),
        sizeBoxHeight(),
        Consumer<ChangeDataProvider>(builder: (context, provider, child) {
          buildContext = context;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                      label: "Day",
                      input: TextInputType.number,
                      txtController: _dayController,
                      error: provider.isSelectDate == false ? true : false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Month',
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.isSelectDate == false
                                  ? Colors.red
                                  : Colors.grey),
                        ),
                        isDense: true,
                      ),
                      items:
                          _months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        _monthController.text = newValue ?? "January";
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppTextFormField(
                      label: "Year",
                      input: TextInputType.number,
                      txtController: _yearController,
                      error: provider.isSelectDate == false ? true : false,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: provider.isSelectDate == true ? false : true,
                child: const Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Enter valid date",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              sizeBoxHeight(),
              DropdownButtonFormField<String>(
                value: provider.selectGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: _genders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedGender = newValue;
                  Provider.of<ChangeDataProvider>(buildContext, listen: false)
                      .selectedGender(newValue);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select your gender';
                  }
                  return null;
                },
              ),
            ],
          );
        }),
        sizeBoxHeight(),
      ],
    );
  }

  //for login data
  loginInfo() {
    return Column(
      children: [
        AppTextFormField(
          label: "Create a gmail address",
          predefineText: '@gmail.com',
          input: TextInputType.emailAddress,
          txtController: _emailController,
          autovalidate: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isNotEmpty) {
              if (value.length < 8) {
                return 'Enter minimum 8 character';
              } else {
                if (!RegExp(r'^(?=.*[A-Za-z])[a-zA-Z0-9.]*[^.@-]$')
                    .hasMatch(value ?? "")) {
                  String lastCharacter = value.substring(value.length - 1);
                  if (lastCharacter == ".") {
                    return 'Sorry, the last character of user name must be an ASCII latter (a-z) or (0-9)';
                  } else {
                    return 'Sorry, only letters (a-z), numbers (0-9), and periods (.) are allowed.';
                  }
                }
              }
            } else if (value == null || value.isEmpty) {
              return 'Enter gmail address';
            }
            return null;
          },
          inputFormatter: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
        ),
        sizeBoxHeight(),
        Consumer<ChangeDataProvider>(builder: (context, provider, child) {
          buildContext = context;
          return Column(
            children: [
              AppTextFormField(
                label: "Password",
                isSecure: provider.isShowPassword == false ? true : false,
                input: TextInputType.text,
                txtController: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your Password';
                  } else if (value.isNotEmpty) {
                    if (value.length < 8) {
                      return 'Enter minimum 8 character';
                    } else {
                      if (!RegExp(
                              r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$')
                          .hasMatch(value ?? "")) {
                        return 'Try a mix of letters, numbers and symbols';
                      }
                    }
                  }
                  return null;
                },
              ),
              sizeBoxHeight(),
              AppTextFormField(
                label: "Confirm password",
                isSecure: provider.isShowPassword == false ? true : false,
                input: TextInputType.text,
                txtController: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your confirm password';
                  }
                  if (value != _passwordController.text) {
                    return 'Password do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: provider.isShowPassword,
                    onChanged: (bool? value) {
                      Provider.of<ChangeDataProvider>(buildContext,
                              listen: false)
                          .callPassword(value);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'Show Password',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          );
        }),
        sizeBoxHeight(),
        AppTextFormField(
          label: "Recovery gmail address (optional)",
          input: TextInputType.emailAddress,
          txtController: _recoveryEmailController,
          autovalidate: AutovalidateMode.onUserInteraction,
          validator: Basic.validateEmail,
          inputFormatter: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
        ),
        sizeBoxHeight(),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Provider.of<ChangeDataProvider>(buildContext, listen: false)
                    .selectDate(true);
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  signInApi();
                });
              } else {
                if (_dayController.text == "" ||
                    _monthController.text == "" ||
                    _yearController.text == "") {
                  Provider.of<ChangeDataProvider>(buildContext, listen: false)
                      .selectDate(false);
                } else if (_dayController.text != "" &&
                    _yearController.text != "") {
                  int day = int.tryParse(_dayController.text) ?? 0;
                  int year = int.tryParse(_yearController.text) ?? 0;
                  if ((day < 1 || day > 31) ||
                      (year < 1900 || year > DateTime.now().year)) {
                    Provider.of<ChangeDataProvider>(buildContext, listen: false)
                        .selectDate(false);
                  } else {
                    Provider.of<ChangeDataProvider>(buildContext, listen: false)
                        .selectDate(true);
                  }
                }
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            child: const Text(
              'SUBMIT',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        sizeBoxHeight(),
      ],
    );
  }

  //for vertical space
  sizeBoxHeight() {
    return const SizedBox(
      height: 20,
    );
  }

  //Sign In Api Call
  signInApi() async {

    Map<String, dynamic> queryParams = {};

    queryParams["firstName"] = _firstNameController.text;
    if (_surnameController.text != "") {
      queryParams["lastName"] = _surnameController.text;
    }
    queryParams["gender"] = selectedGender;
    queryParams["username"] = "${_emailController.text}@gmail.com";
    queryParams["password"] = _passwordController.text;
    queryParams["birthDate"] =
        "${_dayController.text} ${_monthController.text} ${_yearController.text}";

    var result = await postApiCall(ApiUrl.signIN, queryParams,context);

    if (result.result != null) {
      signInModel = SignInResponseModel.fromJson(result.result);

      ScaffoldMessenger.of(buildContext).showSnackBar(
        const SnackBar(content: Text('Sign in complete successfully')),
      );

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInDetailScreen(
                signInResponseData: signInModel,
              )),
        );
      }
    }


  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _recoveryEmailController.dispose();
    super.dispose();
  }
}
