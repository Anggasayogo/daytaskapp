import 'package:daytaskapp/feature/profile/bloc/reward_bloc.dart';
import 'package:daytaskapp/feature/profile/bloc/reward_event.dart';
import 'package:daytaskapp/feature/profile/bloc/reward_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daytaskapp/data/models/reward_voucher.dart';

const Color primaryBlue = Color(0xFF0560FD);

class RewardList extends StatefulWidget {
  const RewardList({super.key});

  @override
  State<RewardList> createState() => _RewardListState();
}

class _RewardListState extends State<RewardList> {
  @override
  void initState() {
    super.initState();
    // 🔥 PANGGIL SEKALI SAJA DI SINI
    context.read<RewardBloc>().add(FetchRewards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reward Saya'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: BlocBuilder<RewardBloc, RewardState>(
        builder: (context, state) {
          if (state is RewardLoading) {
            return const Center(
              child: CircularProgressIndicator(color: primaryBlue),
            );
          }

          if (state is RewardLoaded) {
            if (state.rewards.isEmpty) {
              return const Center(child: Text('Belum ada reward'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.rewards.length,
              itemBuilder: (_, i) {
                return _VoucherCard(reward: state.rewards[i]);
              },
            );
          }

          if (state is RewardError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}


class _VoucherCard extends StatelessWidget {
  final RewardVoucher reward;

  const _VoucherCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            primaryBlue.withOpacity(0.08),
            primaryBlue.withOpacity(0.16),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: primaryBlue.withOpacity(0.6), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'VOUCHER',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              reward.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              reward.rewardName,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reward.voucherCode,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                    letterSpacing: 1.5,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, color: primaryBlue),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: reward.voucherCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voucher berhasil disalin'),
                      ),
                    );
                  },
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
