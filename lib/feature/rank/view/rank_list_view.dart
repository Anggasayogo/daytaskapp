import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daytaskapp/feature/rank/bloc/rank_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';

class RankListView extends StatefulWidget {
  const RankListView({super.key});

  @override
  _RankListViewState createState() => _RankListViewState();
}

class _RankListViewState extends State<RankListView> {
  @override
  void initState() {
    super.initState();
    // Memanggil RankFetchEvent saat widget diinisialisasi
    context.read<RankBloc>().add(RankFetchEvent());
  }

  Widget build(BuildContext context) {
    return BlocBuilder<RankBloc, RankState>(
      builder: (context, state) {
        if (state is RankLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RankSuccessState) {
          final rankList = state.ranks;

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: rankList.length,
            itemBuilder: (context, index) {
              final rank = rankList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      '${rank.ranking}',
                      style: semibold12_5.copyWith(fontSize: 15),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: Image.asset('assets/images/ic_avatar2.png'),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      rank.username,
                      style: regular14.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is RankErrorState) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: Text('No Data Available'),
          );
        }
      },
    );
  }
}
