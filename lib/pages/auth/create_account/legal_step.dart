import 'package:Okuna/provider.dart';
import 'package:Okuna/services/localization.dart';
import 'package:Okuna/services/navigation_service.dart';
import 'package:Okuna/widgets/buttons/button.dart';
import 'package:Okuna/widgets/buttons/secondary_button.dart';
import 'package:Okuna/widgets/buttons/success_button.dart';
import 'package:Okuna/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class OBLegalStepPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OBLegalStepPageState();
  }
}

class OBLegalStepPageState extends State<OBLegalStepPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  late LocalizationService _localizationService;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var openbookProvider = OpenbookProvider.of(context);
    _localizationService = openbookProvider.localizationService;
    _navigationService = openbookProvider.navigationService;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(width: 10.0),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          _localizationService.auth__create_acc__legal,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _localizationService.auth__create_acc__legal_desc,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _localizationService.auth__create_acc__legal_desc_extra,
                          style: TextStyle(
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildDocuments(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ))),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _buildPreviousButton(context: context),
              ),
              Expanded(child: _buildNextButton()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocuments() {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 10,
        ),
        _buildDocument(
            title: _localizationService.drawer__useful_links_terms_of_use,
            onPressed: () => _navigationService
                .navigateToTermsOfUsePage(context: context)),
        const SizedBox(
          height: 10,
        ),
        _buildDocument(
            title: _localizationService.drawer__useful_links_privacy_policy,
            onPressed: () => _navigationService
                .navigateToPrivacyPolicyPage(context: context))
      ],
    );
  }

  Widget _buildDocument(
      {required String title,
      required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(30, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  title,
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OBIcon(
                OBIcons.chevronRight,
                color: Colors.black,
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _buildNextButton() {
    return OBSuccessButton(
      minWidth: double.infinity,
      size: OBButtonSize.large,
      child: Text(_localizationService.auth__create_acc__next,
          style: TextStyle(fontSize: 18.0)),
      onPressed: () {
        Navigator.pushNamed(context, '/auth/accept_step');
      },
    );
  }

  Widget _buildPreviousButton({required BuildContext context}) {
    String buttonText =
        _localizationService.trans('auth__create_acc__previous');

    return OBSecondaryButton(
      isFullWidth: true,
      isLarge: true,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            buttonText,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          )
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
