import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller.dart';
import 'model.dart' as models;
import 'view.dart' as views;

class Mvc {
  models.Game _model;
  Controller _controller;
  views.Game _view;

  Mvc() {
    _model = models.Game();
    _controller = Controller(_model);
    _view = views.Game(_model, _controller);
  }

  models.Game get model => _model;
  Controller get controller => _controller;
  views.Game get view => _view;
}

class View extends StatelessWidget {
  final Mvc _mvc;

  View() : _mvc = Mvc();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 4.0,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Material Freecell',
                  style: GoogleFonts.frederickaTheGreat(
                      textStyle: Theme.of(context).textTheme.headline5),
                ),
              ),
            ),
          ),
          body: _mvc.view,
          bottomNavigationBar: BottomAppBar(
            // shape: CircularNotchedRectangle(),
            notchMargin: 2.0,
            clipBehavior: Clip.antiAlias,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.undo),
                  tooltip: 'Undo',
                  onPressed: _mvc.controller.undo,
                ),
                IconButton(
                  icon: Icon(Icons.fiber_new),
                  tooltip: 'New Deal',
                  onPressed: _mvc.controller.deal,
                ),
              ],
            ),
          ),
        ),
      );
}
