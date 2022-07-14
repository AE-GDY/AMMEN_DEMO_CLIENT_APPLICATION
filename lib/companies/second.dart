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
    title: "Nile Takaful", // Nile Takaful
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 8600,
    loyaltyPoints: "9/10",
    iScore: 50,
    index: 0,
    limits: "200/300/50",
    image: 'assets/fifth.jpg',
    atFirst: false,
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceCompsSecond(
    title: "Egyptian Saudi Insurance", //Egyptian Saudi Insurance House
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 2400,
    loyaltyPoints: "10/10",
    iScore: 50,
    index: 1,
    limits: "100/300/100",
    atFirst: false,
    image: 'assets/sixth.jpg',
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceCompsSecond(
    title: "Mohandes Insurance Co.", // Mohandes Insurance Co.
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 1800,
    loyaltyPoints: "3/10",
    iScore: 50,
    atFirst: false,
    index: 2,
    limits: "100/200/50",
    image: 'assets/seventh.jpg',
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceCompsSecond(
    title: "Delta Insurance", // Delta Insurance
    subtitle: "نوع التغطيه: حريق سطو وحادث",
    price: 3300,
    loyaltyPoints: "5/10",
    iScore: 50,
    index: 3,
    image: 'assets/eigth.jpg',
    atFirst: false,
    limits: "100/300/50",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
];