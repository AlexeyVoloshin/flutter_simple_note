import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/models/note.dart';

enum ColorEvent { eventLavender, eventKhaki, eventMistyRose, eventAntiqueWhite, eventPaleTurquoise}

class ColorBloc extends Bloc<ColorEvent, int> {
  ColorBloc() : super(ColorNote.lavender.color) {
    on<ColorEvent>((event, emit) {
      if (event == ColorEvent.eventLavender) {
        emit(ColorNote.lavender.color);
      } else if (event == ColorEvent.eventKhaki) {
        emit(ColorNote.khaki.color);
      } else if (event == ColorEvent.eventMistyRose) {
        emit(ColorNote.mistyRose.color);
      } else if (event == ColorEvent.eventAntiqueWhite) {
        emit(ColorNote.antiqueWhite.color);
      } else if (event == ColorEvent.eventPaleTurquoise) {
        emit(ColorNote.paleTurquoise.color);
      } 
    });
  }
}