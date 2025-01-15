import 'package:d_chart/d_chart.dart';
import 'package:daytaskapp/feature/rank/bloc/rank_bloc.dart';
import 'package:daytaskapp/feature/rank/view/rank_list_view.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Text('Top 5 Task Rank',
                  style: semibold14.copyWith(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 13 / 9,
              child: BlocBuilder<RankBloc, RankState>(
                builder: (context, state) {
                  if (state is RankSuccessState) {
                    final chartData = state.ranks.map((item) {
                      return OrdinalData(
                        domain: item.username, 
                        measure: int.parse(item.totalPoint),
                      );
                    }).toList();

                    return DChartBarO(
                      groupList: [
                        OrdinalGroup(
                          id: '1',
                          data: chartData,
                          color: primary,
                        ),
                      ],
                    );
                  } else if (state is RankLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RankErrorState) {
                    return Center(child: Text('Failed to load data'));
                  }
                  return Center(child: Text('No data available'));
                },
              ),
            ),

            const SizedBox(height: 30),
            const RankListView(),
          ],
        ),
      ),
    );
  }
}
