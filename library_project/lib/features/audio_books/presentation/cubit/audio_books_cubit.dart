import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_books_state.dart';

class AudioBooksCubit extends Cubit<AudioBooksState> {
  AudioBooksCubit() : super(AudioBooksInitial());
}
