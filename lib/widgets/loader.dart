import 'package:flutter/material.dart';


Widget Loader(other, loading){

  Widget loader(){
    return SizedBox.expand(
      child: Container(
        color: Colors.grey.withOpacity(.6),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  return Stack(
    children: [other, Visibility(visible: loading, child: loader(),)],
  );
}
