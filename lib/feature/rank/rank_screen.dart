import 'package:d_chart/d_chart.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';

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
              child: DChartBarO(
                groupList: [
                  OrdinalGroup(
                    id: '1',
                    data: [
                      OrdinalData(domain: 'Angga', measure: 70),
                      OrdinalData(domain: 'Kms Agil', measure: 50),
                      OrdinalData(domain: 'Febri', measure: 30),
                      OrdinalData(domain: 'Dani', measure: 25),
                    ],
                    color: primary
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text('1', style: semibold12_5.copyWith(fontSize: 15)),
                const SizedBox(width: 10),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Image.asset('assets/images/ic_avatar2.png'),
                ),
                const SizedBox(width: 10),
                Text('Angga Maulana', style: regular14.copyWith(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text('2', style: semibold12_5.copyWith(fontSize: 15)),
                const SizedBox(width: 10),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Image.asset('assets/images/ic_avatar2.png'),
                ),
                const SizedBox(width: 10),
                Text('Kms Agil Yudhoyono', style: regular14.copyWith(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text('3', style: semibold12_5.copyWith(fontSize: 15)),
                const SizedBox(width: 10),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Image.asset('assets/images/ic_avatar2.png'),
                ),
                const SizedBox(width: 10),
                Text('Febri Makarim', style: regular14.copyWith(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text('4', style: semibold12_5.copyWith(fontSize: 15)),
                const SizedBox(width: 10),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Image.asset('assets/images/ic_avatar2.png'),
                ),
                const SizedBox(width: 10),
                Text('Dani Tuak Hercules', style: regular14.copyWith(fontSize: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
