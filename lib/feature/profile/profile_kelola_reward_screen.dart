import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class KelolaRewardScreen extends StatefulWidget {
  const KelolaRewardScreen({super.key});

  @override
  State<KelolaRewardScreen> createState() => _KelolaRewardScreenState();
}

class _KelolaRewardScreenState extends State<KelolaRewardScreen> {
  final ApiService _apiService = GetIt.I<ApiService>();

  List<dynamic> _rewardList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRewards();
  }

  // Helper untuk mendapatkan warna berdasarkan peringkat (ID)
  Color _getRankColor(dynamic id) {
    int rank = int.tryParse(id.toString()) ?? 0;
    switch (rank) {
      case 1: return const Color(0xFFFFD700); // Emas
      case 2: return const Color(0xFFC0C0C0); // Perak
      case 3: return const Color(0xFFCD7F32); // Perunggu
      default: return primary; 
    }
  }

  // --- 1. GET LIST REWARD ---
  Future<void> _fetchRewards() async {
    setState(() => _isLoading = true);
    try {
      final response = await _apiService.get(path: '/api/v1/reward/list');
      
      if (response.statusCode == 200) {
        setState(() {
          // Mengambil array 'data' dari response Map
          _rewardList = response.data['data'];
        });
      } else {
        _showSnackBar(response.message ?? "Gagal mengambil daftar reward");
      }
    } catch (e) {
      _showSnackBar("Gagal memuat data. Periksa koneksi Anda.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // --- 2. CREATE REWARD ---
  Future<void> _createReward(String id, String title, String name, String code) async {
    try {
      final response = await _apiService.post(
        path: '/api/v1/reward/create',
        data: {
          "id_reward": id,
          "title": title,
          "reward_name": name,
          "voucher_code": code,
        },
      );

      if (response.statusCode == 200) {
        _showSnackBar("Reward berhasil ditambahkan!");
        _fetchRewards(); 
      } else {
        _showSnackBar(response.message ?? "Gagal menyimpan reward");
      }
    } catch (e) {
      _showSnackBar("Terjadi kesalahan saat menyimpan data");
    }
  }

  // --- 3. UPDATE REWARD ---
  Future<void> _updateReward(int id, String title, String name, String code) async {
    try {
      final response = await _apiService.put(
        path: '/api/v1/reward/update/$id',
        data: {
          "title": title,
          "reward_name": name,
          "voucher_code": code,
        },
      );

      if (response.statusCode == 200) {
        _showSnackBar("Reward berhasil diperbarui!");
        _fetchRewards();
      } else {
        _showSnackBar(response.message ?? "Gagal memperbarui reward");
      }
    } catch (e) {
      _showSnackBar("Terjadi kesalahan saat memperbarui data");
    }
  }

  // --- 4. DELETE REWARD ---
  Future<void> _deleteReward(String id) async {
    try {
      final response = await _apiService.delete(
        path: '/api/v1/reward/delete/$id',
      );

      if (response.statusCode == 200) {
        _showSnackBar("Reward berhasil dihapus");
        _fetchRewards();
      } else {
        _showSnackBar(response.message ?? "Gagal menghapus reward");
      }
    } catch (e) {
      _showSnackBar("Gagal menghapus data");
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Kelola Reward", style: semibold14.copyWith(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(onPressed: _fetchRewards, icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () => _showFormBottomSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _rewardList.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: _rewardList.length,
                  itemBuilder: (context, index) {
                    final item = _rewardList[index];
                    return _buildRewardCard(item);
                  },
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.redeem_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text("Belum ada reward", style: regular14.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildRewardCard(dynamic item) {
    final Color rankColor = _getRankColor(item['id_reward']);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: rankColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.emoji_events_outlined, color: rankColor),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: rankColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Juara ${item['id_reward']}',
                    style: bold16.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item['title'] ?? '',
                    style: regular12_5.copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                item['reward_name'] ?? '',
                style: semibold14.copyWith(fontSize: 15),
              ),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _showFormBottomSheet(context, reward: item);
                } else if (value == 'delete') {
                  _confirmDelete(item['id_reward']);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text("Edit")),
                const PopupMenuItem(value: 'delete', child: Text("Hapus", style: TextStyle(color: Colors.red))),
              ],
            ),
          ),
          _buildVoucherFooter(item['voucher_code'] ?? ''),
        ],
      ),
    );
  }

  Widget _buildVoucherFooter(String code) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("KODE: $code", style: semibold14.copyWith(color: primary, letterSpacing: 1.1, fontSize: 13)),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: code));
              _showSnackBar("Kode voucher disalin!");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: const Text("SALIN", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }

  void _showFormBottomSheet(BuildContext context, {dynamic reward}) {
    final bool isEdit = reward != null;
    
    final idC = TextEditingController(text: isEdit ? reward['id_reward'].toString() : '');
    final titleC = TextEditingController(text: isEdit ? reward['title'] : '');
    final nameC = TextEditingController(text: isEdit ? reward['reward_name'] : '');
    final codeC = TextEditingController(text: isEdit ? reward['voucher_code'] : '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 20),
            Text(isEdit ? "Update Reward" : "Tambah Reward Baru", style: semibold14.copyWith(fontSize: 18)),
            const SizedBox(height: 20),
            
            _buildInputField("ID Juara (Angka)", idC, keyboardType: TextInputType.number, enabled: !isEdit),
            _buildInputField("Judul (Contoh: Voucher Grab)", titleC),
            _buildInputField("Nama Reward (Contoh: Diskon 50rb)", nameC),
            _buildInputField("Kode Voucher", codeC),
            
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (idC.text.isEmpty || titleC.text.isEmpty || nameC.text.isEmpty || codeC.text.isEmpty) {
                    _showSnackBar("Semua field harus diisi");
                    return;
                  }
                  if (isEdit) {
                    _updateReward(reward['id_reward'], titleC.text, nameC.text, codeC.text);
                  } else {
                    _createReward(idC.text, titleC.text, nameC.text, codeC.text);
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary, 
                  padding: const EdgeInsets.symmetric(vertical: 16), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                child: Text(isEdit ? "SIMPAN PERUBAHAN" : "SIMPAN REWARD", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {TextInputType? keyboardType, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          filled: !enabled,
          fillColor: enabled ? Colors.transparent : Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Reward?"),
        content: const Text("Reward ini akan dihapus secara permanen dari sistem."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteReward(id.toString());
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}