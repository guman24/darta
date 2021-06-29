import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/custom_scaffold_messenger.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/paper/presentation/pages/paper_create_page.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';

import '../../../../injection_container.dart';

class TemplateGridItem extends StatefulWidget {
  final int index;

  const TemplateGridItem({
    Key key,
    @required this.templates,
    @required this.index,
  }) : super(key: key);

  final List<TemplateEntity> templates;

  @override
  _TemplateGridItemState createState() => _TemplateGridItemState();
}

class _TemplateGridItemState extends State<TemplateGridItem> {
  SessionModel sessionModel = SessionModel();
  @override
  void initState() {
    super.initState();
    getSession();
  }

  void getSession() async {
    sessionModel = await sl<AuthLocalDataSource>().getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        GestureDetector(
          onTap: () {
            print("Hello ${sessionModel.verificationStatus}");
            if (sessionModel.verificationStatus == "verified" ||
                sessionModel.verificationStatus == "Verified") {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PaperCreatePage(
                          templateEntity: widget.templates[widget.index])),
                  (route) => true);
            } else if (sessionModel.verificationStatus == "unverified" ||
                sessionModel.verificationStatus == "Unverified") {
              print("here***");
              showCustomSnack(
                  context: context,
                  type: SnackBarMessegeType.ERROR.toString(),
                  messege: "Your Kyc is under review for verification");
            } else {
              return null;
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                // dhanchaList[index].icon,
                Icons.file_copy,
                size: 30,
                color: AppColors.blueColor,
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  widget.templates[widget.index].title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: AppTextTheme.generalStyle.copyWith(
                    color: AppColors.black,
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            return showDialog(
                context: context,
                builder: (context) => Dialog(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.business_center,
                            ),
                            Text(
                              widget.templates[widget.index].title,
                              style: AppTextTheme.subtitleStyle.copyWith(
                                color: AppColors.textColor,
                              ),
                            ),
                            widget.templates[widget.index].information != ""
                                ? Html(
                                    data:
                                        """${widget.templates[widget.index].information}""",
                                  )
                                : Text(
                                    "सुचना छैन",
                                    style: AppTextTheme.generalStyle.copyWith(
                                      color: AppColors.primaryRed,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ));
          },
          child: Container(
            margin: EdgeInsets.only(top: 2.0, left: 100.0),
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blueColor.withOpacity(0.1)),
            child: Icon(
              FontAwesomeIcons.info,
              size: 12.0,
              color: AppColors.blueColor,
            ),
          ),
        ),
      ],
    );
  }
}
