class InsuranceCompsSecond{
  final String title;
  final String subtitle;
  final int price;
  final String loyaltyPoints;
  final int iScore;
  final int index;
  final String image;
  final String limits;
  final bool atFirst;
  bool selected;
  final List<String> insuranceOptions;

  InsuranceCompsSecond(
      {
        required this.title,
        required this.subtitle,
        required this.limits,
        required this.atFirst,
        required this.price,
        required this.loyaltyPoints,
        required this.iScore,
        required this.index,
        required this.image,
        this.selected = false,
        required this.insuranceOptions,
      });
}

List<InsuranceCompsSecond> secondCompanies = [
  InsuranceCompsSecond(
    title: "نايل تكافل",
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 8600,
    loyaltyPoints: "9/10",
    iScore: 50,
    index: 0,
    limits: "200/300/50",
    image: 'assets/fifth.jpg',
    atFirst: false,
    insuranceOptions : [
      "استئجار سياره",
      "المساعده علي الطريق",
      "تخطيه الحوادث الشخصيه للركاب",
    ],
  ),
  InsuranceCompsSecond(
    title: "بيت التأمين المصري السعودي",
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 2400,
    loyaltyPoints: "10/10",
    iScore: 50,
    index: 1,
    limits: "100/300/100",
    atFirst: false,
    image: 'assets/sixth.jpg',
    insuranceOptions : [
      "استئجار سياره",
      "تخطيه الحوادث الشخصيه للسائق",
      "تغطيه السائقين الاقل من 21 سنه",
      "تغطيه دول مجلس التعاون الخليجي",
    ],
  ),
  InsuranceCompsSecond(
    title: "شركة المهندس للتأمين",
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 1800,
    loyaltyPoints: "3/10",
    iScore: 50,
    atFirst: false,
    index: 2,
    limits: "100/200/50",
    image: 'assets/seventh.jpg',
    insuranceOptions : [
      "استئجار سياره",
      "المساعده علي الطريق",
      "تخطيه الحوادث الشخصيه للركاب",
      "تخطيه الحوادث الشخصيه للسائق",
      "تغطيه السائقين الاقل من 21 سنه",
    ],
  ),
  InsuranceCompsSecond(
    title: "الدلتا للتأمين",
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 3300,
    loyaltyPoints: "5/10",
    iScore: 50,
    index: 3,
    image: 'assets/eigth.jpg',
    atFirst: false,
    limits: "100/300/50",
    insuranceOptions : [
      "استئجار سياره",
      "المساعده علي الطريق",
      "تخطيه الحوادث الشخصيه للركاب",
      "تغطيه دول مجلس التعاون الخليجي",
    ],
  ),
];