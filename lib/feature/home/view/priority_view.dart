import 'package:daytaskapp/feature/home/bloc/priority_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriorityView extends StatefulWidget {
  const PriorityView({super.key});

  @override
  State<PriorityView> createState() => _PriorityViewState();
}

class _PriorityViewState extends State<PriorityView> {
  int? selectedPriorityId;

  @override
  void initState() {
    super.initState();
    // Memanggil event PriorityFetchEvent saat widget diinisialisasi
    context.read<PriorityBloc>().add(PriorityFetchEvent());
  }

  bool _isPrioritySelected(int idPriority) {
    return selectedPriorityId == idPriority; 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PriorityBloc, PriorityState>(
          builder: (context, state) {
            if (state is PriorityLoadingState) {
              // Tampilkan indikator loading saat state dalam proses
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PrioritySuccessState) {
              // Data berhasil diambil, buat tombol dinamis berdasarkan data
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.priorities.map((priority) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 115, // Atur lebar tombol
                          child: TextButton(
                            onPressed: () {
                              // Aksi tombol ketika ditekan
                              print("Priority Selected: ${priority.priorityName}");
                              setState(() {
                                selectedPriorityId = priority.idPriority;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: _isPrioritySelected(priority.idPriority)
                                  ? primary
                                  : Colors.grey[
                                      200], // Ubah warna berdasarkan kondisi
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              priority.priorityName,
                              style: regular12_5.copyWith(
                                fontSize: 12,
                                color: _isPrioritySelected(priority.idPriority)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10), // Jarak antar tombol
                      ],
                    );
                  }).toList(),
                ),
              );
            } else if (state is PriorityErrorState) {
              // Tampilkan pesan error jika terjadi kesalahan
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              // Tampilkan UI default saat state initial
              return const Center(
                child: Text("No data available"),
              );
            }
          },
        ),
      ],
    );
  }
}
