import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:untitled_flutter/data/model/get_answers_response.dart';
import 'package:untitled_flutter/ui/home/home_bloc/home_bloc.dart';
import 'package:untitled_flutter/ui/home/home_bloc/home_events.dart';
import 'package:untitled_flutter/ui/home/home_bloc/home_states.dart';

class HomeScreen extends StatefulWidget {
  static var route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetAnswersBloc _getAnswersBloc;
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAnswersBloc = BlocProvider.of<GetAnswersBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    //_getAnswersBloc.add(SearchAnswerEvent('stackoverflow'));
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            _queryLayout(),
            _buildBloc(),
          ],
        ),
      ),
    ));
  }

  Widget _queryLayout() {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'query',
            ),
            controller: textController,
            onChanged: (value) {
              print(value);
              //textController.text = value;
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                // if (_formKey.currentState!.validate()) {
                // Process data.
                print(textController.text);

                _getAnswersBloc.add(SearchAnswerEvent(
                    textController.text, _getAnswersBloc.pagingController));
                // }
              },
              child: const Text('Submit'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBloc() {
    return BlocBuilder<GetAnswersBloc, GetAnswerState>(
        bloc: _getAnswersBloc,
        builder: (context, state) {
          if (state is GetAnswerStateLoading) {
            return _buildLoadingView();
          }
          if (state is GetAnswerStateError) {
            return _buildErrorView(state.error);
          }
          if (state is GetAnswerStateSuccess) {
            return buildPagedListView(_getAnswersBloc.pagingController);
          }
          return Center(
            child: Text('welcome back'),
          );
        });
  }

  _buildLoadingView() {
    return getAnimatedText();
  }

  _buildErrorView(String error) {
    return Center(
      child: Text(error),
    );
  }

  _buildSuccessView(GetAnswersResponse getAnswersResponse) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(color: Colors.black12),
          shrinkWrap: true,
          itemCount: getAnswersResponse.items.length,
          itemBuilder: (ctx, index) =>
              _buildListItem(getAnswersResponse.items[index])),
    );
  }

  getAnimatedText() {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black87,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 6,
          fontFamily: GoogleFonts.mcLaren().fontFamily,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText('Loading ...'),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }

  _buildListItem(Item item) {
    return Container(
      color: Colors.amberAccent,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: ListTile(
        leading: Image.network(item.owner!.profileImage),
        title: Text(item.owner!.displayName),
        trailing: Text(item.score.toString()),
        subtitle: Text(DateUtils.dateOnly(
                DateTime.fromMillisecondsSinceEpoch(item.creationDate * 1000))
            .toUtc()
            .toString()),
      ),
    );
  }

  // todo #2
  Widget buildPagedListView(PagingController<int, Item> pagingController) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      Expanded(
        child: PagedListView<int, Item>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<Item>(
            itemBuilder: (context, item, index) => _buildListItem(item),
          ),
        ),
      );

  @override
  void dispose() {
    _getAnswersBloc.pagingController.dispose();
    _getAnswersBloc.close();
    super.dispose();
  }
}
