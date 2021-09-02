import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Description:
///
/// @author tangzhentao 
/// @date 2020/8/4 

PreferredSizeWidget cpAppBar(BuildContext context, {required String title, PreferredSizeWidget? bottom, List<Widget>? actions,})
        => AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(title),
          centerTitle: false,
          actions: actions,
          bottom: bottom,
          elevation: 0,
        );