import 'package:flutter/material.dart';
import 'package:schallange/components/myActivityBox.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<String> titles = [
    'Günlük egzersizimi yaptım.',
    'İnsanlarla sosyal etkileşimde bulundum.',
    'Bugün yeni şeyler öğrendim ve geliştim.',
    'Meditasyon ve yoga yaptım.',
    'Sağlıklı beslendim.',
    'Profesyonel destek aldım.',
    'Günlük planlamalarımı yaptım.',
    'Yeni bir hobi edindim.',
    'Doğa ile zaman geçirdim.',
  ];
  List<String> subTitles = [
    'Düzenli egzersiz yapmak, vücutta endorfin salgılanmasını artırarak ruh halini iyileştirebilir ve bağımlılıkla mücadelede destek olabilir.',
    'Aile ve arkadaşlarla vakit geçirmek, destek almak ve sosyal ilişkileri güçlendirmek önemlidir.',
    'Kendinizi geliştirecek kitaplar okumak, online kurslara katılmak veya yeni beceriler öğrenmek, kişisel gelişimi teşvik eder.',
    'Stresle baş etme becerilerini geliştirebilir, zihinsel odaklanma ve iç huzur sağlayabilir.',
    'Dengeli ve sağlıklı bir beslenme düzeni, vücudunuzun ihtiyaçlarını karşılamak ve genel sağlığı iyileştirmek için önemlidir.',
    'Bir terapist veya danışmanla düzenli olarak görüşmek, bağımlılıkla başa çıkma stratejilerini geliştirmenize yardımcı olabilir.',
    'Günlük hedefler belirlemek ve bir günlük plan oluşturmak, disiplinli olmanıza ve ilerleme kaydetmenize yardımcı olabilir.',
    'Yeni bir hobi edinmek, zamanı dolu dolu geçirmenizi sağlar ve ilgi alanlarınıza odaklanmanızı sağlar.',
    'Doğa yürüyüşleri yapmak, temiz hava almak ve doğal çevreyle bağlantı kurmak, ruh sağlığını güçlendirebilir.',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Aktivitelerim"),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return MyActivityBox(title: titles[index], text: subTitles[index]);
        },
      ),
    );
  }
}
