
class InsuranceCompsFirst{
  final String title;
  final String subtitle;
  final int price;
  final String loyaltyPoints;
  final int iScore;
  final int index;
  final bool atFirst;
  final String image;
  final String limits;
  final List<String> insuranceOptions;
  bool selected;

  InsuranceCompsFirst(
      {
        required this.title,
        required this.atFirst,
        required this.subtitle,
        required this.price,
        required this.loyaltyPoints,
        required this.iScore,
        required this.index,
        required this.image,
        this.selected = false,
        required this.limits,
        required this.insuranceOptions,
      });
}

List<InsuranceCompsFirst> firstCompanies = [
  InsuranceCompsFirst(
    title: "Gig Egypt", // Gig Egypt
    subtitle: "Covering type: fire burglary accident",
    price: 5000,
    loyaltyPoints: "6/10",
    iScore: 50,
    index: 0,
    limits: "100/300/50",
    image: 'assets/first.jpg',
    atFirst: true,
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceCompsFirst(
    title: "Misr Insurance", // Misr Insurance
    subtitle: " نوع التغطيه: حريق سطو وحادث",
    price: 4000,
    loyaltyPoints: "8/10",
    iScore: 50,
    index: 1,
    image: 'assets/second.png',
    atFirst: true,
    limits: "100/200/50",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceCompsFirst(
    title: "Suez Canal Insurance", // Suez Canal Insurance
    subtitle:" نوع التغطيه: حريق سطو وحادث",
    price: 6000,
    loyaltyPoints: "6/10",
    iScore: 50,
    index: 2,
    image: 'assets/third.jpg',
    atFirst: true,
    limits: "100/300/50",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceCompsFirst(
    title: "Al Ahlia Insurance", // Al Ahlia Insurance
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 3000,
    loyaltyPoints: "4/10",
    iScore: 50,
    index: 3,
    image: 'assets/fourth.jpg',
    atFirst: true,
    limits: "200/300/50",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
];