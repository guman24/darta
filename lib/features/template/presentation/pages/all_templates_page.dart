import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/themes.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/notification/presentation/pages/all_notifications_page.dart';
import 'package:sifaris_app/features/paper/presentation/pages/paper_create_page.dart';
import 'package:sifaris_app/features/template/domain/entities/template_category_entity.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';
import 'package:sifaris_app/features/template/presentation/blocs/category_template/categorytemplate_bloc.dart';
import 'package:sifaris_app/features/template/presentation/blocs/templates/templates_bloc.dart';
import 'package:sifaris_app/features/template/presentation/blocs/templates_toggle/templates_toggle_cubit.dart';
import 'package:expandable/expandable.dart';
import 'package:sifaris_app/features/template/presentation/widgets/templates_grid_item.dart';
import 'package:sifaris_app/injection_container.dart';

class AllTemplatesPage extends StatefulWidget {
  @override
  _AllTemplatesPageState createState() => _AllTemplatesPageState();
}

class _AllTemplatesPageState extends State<AllTemplatesPage> {
  bool _isCategory = false;
  bool isSearchBarExpand = false;
  List<TemplateEntity> randomTemplates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => sl<TemplatesBloc>()..add(LoadAllTemplatesEvent()),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: SizeConfig.screenHeight * 0.4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      AppColors.blueColor,
                      AppColors.primaryRed,
                    ])),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.blueColor,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.notifications,
                                    size: 30.0,
                                    color: AppColors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                AllNotificationsPage()));
                                  }),
                              SizedBox(
                                width: 20.0,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://thumbs.dreamstime.com/b/handsome-man-black-suit-white-shirt-posing-studio-attractive-guy-fashion-hairstyle-confident-man-short-beard-125019349.jpg"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            BlocConsumer<TemplatesToggleCubit, TemplatesToggleState>(
              listener: (context, state) {
                if (state.isCategoryTemplates) {
                  _isCategory = state.isCategoryTemplates;
                }
                if (state.isRandomTemplates) {
                  _isCategory = !state.isRandomTemplates;
                }
              },
              builder: (context, state) {
                if (state.isCategoryTemplates) {
                  _isCategory = state.isCategoryTemplates;
                }
                if (state.isRandomTemplates) {
                  _isCategory = !state.isRandomTemplates;
                }
                return Container(
                  height: SizeConfig.screenHeight,
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.1),
                  child: CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverToBoxAdapter(
                          child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                )),
                            constraints: BoxConstraints(
                                minHeight: SizeConfig.screenHeight * 0.6,
                                minWidth: SizeConfig.screenWidth,
                                maxHeight: double.infinity),
                            child: BlocBuilder<TemplatesBloc, TemplatesState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Container(
                                      child: isSearchBarExpand
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 10.0),
                                              padding: EdgeInsets.all(2.0),
                                              width: SizeConfig.screenWidth,
                                              decoration: InputTheme
                                                      .getInputBoxDecoration()
                                                  .copyWith(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0)),
                                              child: TextField(
                                                textInputAction:
                                                    TextInputAction.search,
                                                decoration: InputDecoration(
                                                    hintText: "खोजी गर्नुहोस्",
                                                    hintStyle: AppTextTheme
                                                        .generalStyle
                                                        .copyWith(
                                                      color: AppColors.textColor
                                                          .withOpacity(0.5),
                                                    ),
                                                    border: InputBorder.none,
                                                    prefixIcon:
                                                        Icon(Icons.search),
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isSearchBarExpand =
                                                              false;
                                                        });
                                                      },
                                                      icon: Icon(Icons.cancel),
                                                    )),
                                                onSubmitted: (value) {
                                                  print("*** $value");
                                                  context.read<TemplatesBloc>()
                                                    ..add(SearchTemplatesEvent(
                                                        keyword: value));
                                                },
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isSearchBarExpand = true;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(15.0),
                                                margin: EdgeInsets.only(
                                                    top: 10.0, bottom: 20.0),
                                                decoration: InputTheme
                                                        .getInputBoxDecoration()
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30.0)),
                                                child: Icon(
                                                  Icons.search_rounded,
                                                  size: 25.0,
                                                ),
                                              ),
                                            ),
                                    ),
                                    Container(
                                      child: !_isCategory
                                          ? RandomTemplates()
                                          : CategoryTemplates(),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    ));
  }
}

class RandomTemplates extends StatefulWidget {
  const RandomTemplates({
    Key key,
  }) : super(key: key);
  @override
  _RandomTemplatesState createState() => _RandomTemplatesState();
}

class _RandomTemplatesState extends State<RandomTemplates> {
  List<TemplateEntity> randomTemplates = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<TemplatesBloc, TemplatesState>(
      listener: (context, state) {
        print("Listen $state");
        if (state is TemplatesLoaded) {
          randomTemplates = state.templates;
        }
      },
      child: BlocBuilder<TemplatesBloc, TemplatesState>(
        builder: (context, state) {
          print("***temp state $state");
          if (state is TemplatesLoaded) {
            randomTemplates = state.templates;
          } else if (state is TemplatesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TemplatesFailed) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "सिफारिसका ढाँचा",
                      style: AppTextTheme.titleStyle.copyWith(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<TemplatesToggleCubit>()..categoryToggle();
                      },
                      child: Text(
                        "क्याटागोरीमा हेर्नुहोस",
                        style: AppTextTheme.generalStyle.copyWith(
                          color: AppColors.blueColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: GridView.builder(
                        itemCount: randomTemplates.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: AppColors.grayColor.withOpacity(0.5),
                              width: 0.5,
                            )),
                            child: TemplateGridItem(
                              templates: randomTemplates,
                              index: index,
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryTemplates extends StatefulWidget {
  @override
  _CategoryTemplatesState createState() => _CategoryTemplatesState();
}

class _CategoryTemplatesState extends State<CategoryTemplates> {
  bool isSearchBarExpand = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<CategorytemplateBloc>()..add(LoadCategoryTemplatesEvent()),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ढाँचाका क्याटागोरी",
                style: AppTextTheme.titleStyle.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<TemplatesToggleCubit>()..randomToggle();
                },
                child: Text(
                  "सबै हेर्नुहोस",
                  style: AppTextTheme.generalStyle.copyWith(
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<CategorytemplateBloc, CategorytemplateState>(
            builder: (context, state) {
              if (state is CategoryTemplatesLoaded) {
                final List<TemplateCategoryEntity> _categoryTemplates =
                    state.categories;
                final List<Color> _colors =
                    categoryColorList.take(_categoryTemplates.length).toList();
                return ListView.builder(
                    itemCount: _categoryTemplates.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToExpand: true,
                          tapBodyToCollapse: false,
                          tapHeaderToExpand: true,
                          hasIcon: false,
                          useInkWell: true,
                        ),
                        header: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 0.0),
                          alignment: Alignment.center,
                          decoration:
                              InputTheme.getInputBoxDecoration().copyWith(
                            color: _colors[index],
                          ),
                          padding: EdgeInsets.all(12.0),
                          child: Text(_categoryTemplates[index].categoryName,
                              style: AppTextTheme.normalStyle),
                        ),
                        expanded: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 10.0),
                          child: GridView.builder(
                              // itemCount: 12,
                              itemCount:
                                  _categoryTemplates[index].templates.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1.0,
                              ),
                              itemBuilder: (context, i) {
                                // print(
                                // "category templates ****${_categoryTemplates[index].templates[i]}");
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: AppColors.grayColor.withOpacity(0.5),
                                    width: 0.5,
                                  )),
                                  child: TemplateGridItem(
                                      templates:
                                          _categoryTemplates[index].templates,
                                      index: i),
                                );
                              }),
                        ),
                        collapsed: null,
                      );
                    });
              } else if (state is CategoryTemplateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CategoryTemplatesFailed) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return Container();
              }
            },
          )
        ]),
      ),
    );
  }
}
