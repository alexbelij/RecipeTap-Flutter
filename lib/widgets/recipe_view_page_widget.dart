// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:recipetap/models/recipe_model.dart';
import 'package:recipetap/pages/home_screen.dart';
import 'package:recipetap/provider/recently_viewed_provider.dart';
import 'package:recipetap/utility/pdf_creator.dart';
import 'package:sliver_fab/sliver_fab.dart';

import 'loading_spinner.dart';
// import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class RecipeViewPageWidget extends StatefulWidget {
  const RecipeViewPageWidget({
    Key key,
    @required this.headline,
    @required this.images,
    @required this.desc,
    @required this.timeExists,
    @required this.time,
    @required this.servingsExist,
    @required this.servings,
    @required this.nutritionalFactsExits,
    @required this.oldWebsite,
    @required this.nutritionalFacts,
    @required this.nutritionalFactsNew,
    @required this.yeildExists,
    @required this.yeild,
    @required this.ingredients,
    @required this.directions,
    @required this.cooksNotesExits,
    @required this.newWebsiteFooterNotesExist,
    @required this.cooksNotes,
    @required this.recipe,
    @required this.isFav,
  }) : super(key: key);

  final String headline;
  final List<String> images;
  final String desc;
  final bool timeExists;
  final String time;
  final bool servingsExist;
  final String servings;
  final bool nutritionalFactsExits;
  final bool oldWebsite;
  final List nutritionalFacts;
  final List nutritionalFactsNew;
  final bool yeildExists;
  final String yeild;
  final List ingredients;
  final List directions;
  final bool cooksNotesExits;
  final bool newWebsiteFooterNotesExist;
  final List cooksNotes;
  final bool isFav;
  final RecipeModel recipe;

  @override
  _RecipeViewPageWidgetState createState() => _RecipeViewPageWidgetState();
}

class _RecipeViewPageWidgetState extends State<RecipeViewPageWidget> {
  var _isLoading = false;
  bool isFav;

  // ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    isFav = widget.isFav;
    super.initState();
  }

  // File _imageFile;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // capture() async {
  //   screenshotController.capture().then((File image) {
  //     //Capture Done
  //     setState(() {
  //       _imageFile = image;
  //     });
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  //   final directory = (await getApplicationDocumentsDirectory())
  //       .path; //from path_provide package
  //   String fileName = DateTime.now().toIso8601String();
  //   final path = '$directory/$fileName.png';

  //   screenshotController.capture(
  //       path: path //set path where screenshot will be saved
  //       );
  //   print(path);
  // }

  // generatePdf() {
  //   reportView(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _isLoading
          ? Center(child: LoadingSpinner(size: 140, color: Colors.grey))
          :
          // controller: screenshotController,
          SliverFab(
              floatingWidget: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 25,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: isFav
                        ? () async {
                            isFav = false;
                            await Provider.of<RecentsProvider>(context,
                                    listen: false)
                                .removeFav(
                                    widget.recipe.recipeUrl, currentUser.email);

                            if (await Provider.of<RecentsProvider>(context,
                                        listen: false)
                                    .checkIfFav(widget.recipe.recipeUrl,
                                        currentUser.email) ==
                                false) {
                              isFav = true;
                              _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(
                                    content: new Text(
                                        '${widget.headline} \nRemoved From Favourites')),
                              );
                              print("SnackBar");
                            } else {
                              isFav = false;
                              _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(
                                    content: new Text(
                                        'Failed To Remove From Favourites')),
                              );
                            }
                          }
                        : () async {
                            if (currentUser != null) {
                              isFav = true;
                              await Provider.of<RecentsProvider>(context,
                                      listen: false)
                                  .addToFavourites(
                                      widget.recipe, currentUser.email);

                              if (!await Provider.of<RecentsProvider>(context,
                                      listen: false)
                                  .checkIfFav(widget.recipe.recipeUrl,
                                      currentUser.email)) {
                                _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text(
                                          'Failed To Add To Favourites')),
                                );
                                isFav = false;
                              } else {
                                _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text(
                                          '${widget.headline} \nAdded To Favourites')),
                                );
                              }
                            } else {
                              _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text(
                                          "Log In To Add To Favourites !")));
                            }
                          },
                  ),
                ),
              ),
              floatingPosition: FloatingPosition(
                  left: MediaQuery.of(context).size.width * 0.8),
              expandedHeight: MediaQuery.of(context).size.height / 3,
              slivers: <Widget>[
                SliverAppBar(
                  // title: Text(headline),
                  // elevation: 0.1,
                  expandedHeight: MediaQuery.of(context).size.height / 3,

                  pinned: true,
                  // backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: (widget.images[0] == null ||
                              widget.images[0] ==
                                  "https://www.allrecipes.com/img/icons/generic-recipe.svg" ||
                              widget.images[0] ==
                                  "https://images.media-allrecipes.com/images/82579.png" ||
                              widget.images[0] ==
                                  "https://images.media-allrecipes.com/images/79591.png")
                          ? Theme.of(context).iconTheme.color
                          : Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    title: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 6,
                      ),
                      child: Text(
                        widget.headline ?? "",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    background: Container(
                      height: 200,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Swiper(
                        itemHeight: 200,
                        itemCount: widget.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(45),
                              bottomRight: Radius.circular(45),
                            ),
                            child: (widget.images[index] == null ||
                                    widget.images[index] ==
                                        "https://www.allrecipes.com/img/icons/generic-recipe.svg" ||
                                    widget.images[index] ==
                                        "https://images.media-allrecipes.com/images/82579.png" ||
                                    widget.images[index] ==
                                        "https://images.media-allrecipes.com/images/79591.png")
                                ? Image.asset(
                                    'assets/logo/banner.png',
                                    fit: BoxFit.contain,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : null,
                                  )
                                : Image.network(
                                    widget.images[index] ?? "",
                                    fit: BoxFit.cover,
                                  ),
                          );
                        },

                        pagination: SwiperPagination(
                          margin: EdgeInsets.only(top: 50),
                          builder: SwiperPagination.dots,
                          alignment: Alignment.topCenter,
                        ),

                        // control: new SwiperControl(
                        //   iconNext: null,
                        //   iconPrevious: null,
                        // ),
                        physics: BouncingScrollPhysics(),
                        // layout: SwiperLayout.DEFAULT,
                        // viewportFraction: 0.8,
                        // scale: 0.9,
                        itemWidth: 300.0,
                        loop: false,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                      child: ReadMoreText(
                        widget.desc,
                        trimLines: 2,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        colorClickableText: Colors.grey,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: '  Show more',
                        trimExpandedText: '  Show less',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 85,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (widget.timeExists)
                            Container(
                              height: 85,
                              width: MediaQuery.of(context).size.width / 5,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.timer),
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.time ?? "",
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (widget.servingsExist)
                            Container(
                              height: 85,
                              width: MediaQuery.of(context).size.width / 5,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.people_outline),
                                  Text(
                                    "Serves".toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.servings ?? "--",
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (widget.nutritionalFactsExits)
                            Container(
                              height: 85,
                              width: MediaQuery.of(context).size.width / 5,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.restaurant_menu),
                                  Text(
                                    "Calories".toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.nutritionalFactsExits
                                        ? widget.oldWebsite
                                            ? widget.nutritionalFacts[0]
                                            : widget.nutritionalFactsNew[0]
                                        : "--" ?? "--",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (widget.yeildExists && widget.oldWebsite == true)
                            Container(
                              height: 85,
                              width: MediaQuery.of(context).size.width / 5,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.fastfood),
                                  Text(
                                    "YEILDS",
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.yeildExists
                                        ? widget.oldWebsite
                                            ? widget.yeild ?? "--"
                                            : "--"
                                        : "--" ?? "--",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      // vertical: 25,
                    ),
                    child: Text(
                      'INGREDIENTS',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 25),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          // vertical: 25,
                        ),
                        child: ListTile(
                          title: Text(widget.ingredients[index]),
                        ),
                      );
                    },
                    childCount: widget.oldWebsite
                        ? widget.ingredients.length
                        : widget.ingredients.length - 2,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                    ),
                    child: Text(
                      'DIRECTIONS',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 25),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${index + 1}'),
                          ),
                          title: Text(widget.directions[index] ?? ""),
                        ),
                      );
                      // Text(directions[index]);
                    },
                    childCount: widget.directions.length - 1,
                  ),
                ),
                if (widget.nutritionalFactsExits)
                  SliverToBoxAdapter(
                    child: Divider(),
                  ),
                if (widget.nutritionalFactsExits)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      child: Text(
                        'NUTRITIONAL FACTS',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(fontSize: 25),
                      ),
                    ),
                  ),
                if (widget.nutritionalFactsExits)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      widget.oldWebsite
                          ? (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: ListTile(
                                  title: Text(widget.nutritionalFacts[index]
                                      .toString()
                                      .trimRight()),
                                ),
                              );
                            }
                          : (BuildContext context, int index) {
                              return ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(widget.nutritionalFactsNew[index]
                                      .toString()
                                      .trim()),
                                ),
                              );
                            },
                      childCount: widget.oldWebsite
                          ? widget.nutritionalFacts.length - 1
                          : widget.nutritionalFactsNew.length,
                    ),
                  ),
                if ((widget.oldWebsite && widget.cooksNotesExits) ||
                    widget.newWebsiteFooterNotesExist)
                  SliverToBoxAdapter(
                    child: Divider(),
                  ),
                if ((widget.oldWebsite && widget.cooksNotesExits) ||
                    widget.newWebsiteFooterNotesExist)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      child: Text(
                        "COOK'S NOTES",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(fontSize: 25),
                      ),
                    ),
                  ),
                if ((widget.oldWebsite && widget.cooksNotesExits) ||
                    widget.newWebsiteFooterNotesExist)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      widget.oldWebsite
                          ? (BuildContext context, int index) {
                              // print(cooksNotes.length);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: ListTile(
                                  title:
                                      Text(widget.cooksNotes[index].toString()
                                          // .substring(20)
                                          // .trim()
                                          ??
                                          ""),
                                ),
                              );
                            }
                          : (BuildContext context, int index) {
                              // print(cooksNotes[0].length);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: ListTile(
                                  title:
                                      Text(widget.cooksNotes[0][index].trim()),
                                ),
                              );
                              // Text(cooksNotes[0][index].trim());
                            },
                      childCount: widget.oldWebsite
                          ? widget.cooksNotes.length
                          : widget.cooksNotes[0].length,
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/recipeview.jpg',
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                            ),
                            child: Align(
                              child: Text(
                                'Bon Appetit!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      fontSize: 25,
                                      color: Theme.of(context).accentColor,
                                    ),
                              ),
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        if (await Permission.storage.request().isGranted) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Loading..."),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              );
                            },
                          );
                          await reportView(context, widget.recipe,
                              widget.recipe.coverPhotoUrl[0]);
                          // Either the permission was already granted before or the user just granted it.
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    "Failed To Generate PDF.\nWe are looking into it"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                      // capture,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          height: 60,
                          color: Color(0xfff4d6cd),
                          child: Center(
                            child: Text(
                              'Save The Recipe As PDF',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 70,
                  ),
                ),
                // SliverFillRemaining(
                //   child: Column(
                //     children: <Widget>[
                //       // extra cooks notes
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }
}
