import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daytaskapp/feature/rank/bloc/rank_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';

class RankListView extends StatefulWidget {
  const RankListView({super.key});

  @override
  State<RankListView> createState() => _RankListViewState();
}

class _RankListViewState extends State<RankListView> {
  @override
  void initState() {
    super.initState();
    context.read<RankBloc>().add(RankFetchEvent());
  }

  /// Warna piala Top 3
  Color _trophyColor(int ranking) {
    switch (ranking) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.grey;
    }
  }

  /// Background khusus Top 3
  Color _rowBackground(int ranking) {
    if (ranking == 1) return Colors.amber.withOpacity(0.15);
    if (ranking == 2) return Colors.grey.withOpacity(0.15);
    if (ranking == 3) return Colors.brown.withOpacity(0.15);
    return Colors.transparent;
  }

  /// Avatar + Rank Number
  Widget _buildAvatar(int ranking) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage:
              const AssetImage('assets/images/ic_avatar2.png'),
        ),
        CircleAvatar(
          radius: 9,
          backgroundColor: Colors.black,
          child: Text(
            ranking.toString(),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// Piala Top 3 (kalau bukan Top 3, return kosong)
  Widget _buildTrophy(int ranking) {
    if (ranking > 3) return const SizedBox(width: 26);

    return Icon(
      Icons.emoji_events,
      color: _trophyColor(ranking),
      size: 26,
    );
  }

  /// Aksi Get Reward
  void _onGetReward(BuildContext context, int ranking, String username) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Get reward untuk $username (Rank $ranking)'),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankBloc, RankState>(
      builder: (context, state) {
        if (state is RankLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RankErrorState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is RankSuccessState) {
          final rankList = state.ranks;

          if (rankList.isEmpty) {
            return const Center(child: Text('No Data Available'));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rankList.length,
            itemBuilder: (context, index) {
              final rank = rankList[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Material(
                  color: _rowBackground(rank.ranking),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _onGetReward(
                      context,
                      rank.ranking,
                      rank.username,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          /// 🏆 Trophy
                          _buildTrophy(rank.ranking),

                          const SizedBox(width: 12),

                          /// 👤 Avatar + Rank Number
                          _buildAvatar(rank.ranking),

                          const SizedBox(width: 12),

                          /// Username
                          Expanded(
                            child: Text(
                              rank.username,
                              style: regular14.copyWith(
                                fontSize: 15,
                                fontWeight: rank.ranking <= 3
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          /// 👉 Get Reward
                          // Icon(
                          //   Icons.chevron_right,
                          //   color: primary,
                          //   size: 28,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const Center(child: Text('No Data Available'));
      },
    );
  }
}
